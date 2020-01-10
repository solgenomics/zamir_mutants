#!/usr/bin/perl



use zamir::db_link;
use CGI qw(:standard);
use CGI::Carp qw(fatalsToBrowser);
use DBI;
use DBD::mysql;




my ($MAIN_URL, $FILENAME, $DIR, $DAVIS_DIR);
my $menu;


$FILENAME  = "mutant02_search.cgi";

$DIR       = "/cgi-bin/mutation_site/";
$PIC_DIR   = "/soldb/www_not/html/mutation_images/";
$MAIN_URL  = "/cgi-bin/mutation_site/$FILENAME";
$DAVIS_DIR = "http://tgrc.ucdavis.edu/data/acc/GenDetail.CFM?GENES.gene=";



%high_category = ("seed" => "seed",      
                 "plant size" => "plant_size",
                 "plant habit" => "plant_habit",
                 "leaf morphology" => "leaf_m",
                 "leaf color" => "leaf_c",
                 "flowering" => "flowering",
                 "inflorescence" => "inflor",
				 "flower morphology" => "flower_m",
				 "flower color" => "flower_c",
				 "fruit size" => "fruit_s",
				 "fruit morphology" => "fruit_m",
				 "fruit color" => "fruit_c",
				 "fruit ripening" => "fruit_r",
				 "sterility" => "sterility",
				 "disease and stress response" => "dr",			 
				 );
			
@thumbnail = ();
@halfsize  = ();


####################################   MAIN   ###############################################

print "content-type: text/html\n\n";



$menu = param("menu");



if ($menu eq "search_by_code")
{
	results(0);
}
elsif ($menu eq "search_by_keyword")
{
	results(1);
}
elsif ($menu eq "search_by_category")
{
	results(2);
}
else
{
	display_search();
}



	
	
	
	




###################################   display_search   #######################################

sub display_search()
{
	
	my $text = "";
	my $temp = "";
	my ($i, $j);
	my @mids = ();
	my $high;
	my ($first, $second, $form1, $form2);
	
	
	
	$text .= center_stat(h1_stat("Mutation Site - Search")) . "<HR>";
	
	
	$text  .= under_line_stat(h3_stat("Search according to family ID"));
	$text  .= text_item("code", 30, "") . "<br>";
	$text  .= submit_item("Search") . reset_item("Clear");
	$text  .= "<br><br>";
	$form1  = form($text, "search_by_code");
	
	$text = "";
	
	
	$text  .= under_line_stat(h3_stat("Search according to keyword"));
	$text  .= text_item("keyword", 30, "") . "<br>";
	$text  .= submit_item("Search") . reset_item("Clear");	
	$text  .= "<br><br>";
	$form2  = form($text, "search_by_keyword");
	
	
	$text = "";
	
	
	$text .= under_line_stat(h3_stat("Search according to phenotype"));	
	
	$temp .= row_element(h3_stat("High Category"), h3_stat("Sub Category"));
	
	
	
	for ($i=0; $i<15; $i++)
	{
		$j = $i + 1;
	
		$high = get_high($j);
		
		
		
		@mids = get_mid_by_high($high);
	
		$first  = checkbox_item("c$j", 0) . "  " . bold_stat("$high");
		$second = select_item("s$j", $j, "", @mids);
		$temp  .= row_element($first, $second);
	
	}
	
	$text  .= table_element($temp);
	
	$text  .= submit_item("Search") . reset_item("Clear") . checkbox_item("type", 0);
	$text  .= "check here to get results which contain" . under_line_stat(" ONLY ") . "the selected categories (and don't contain any other category)";
	
	$text  = form($text,"search_by_category");

	to_html("", "$form1$form2$text");
	
	
}	






###################################   get_search   #######################################

sub get_search()
{
	
	my $mid ;
	my $high;
	my ($i, $j, $high_col);
	my ($type) = @_;
	my @request = ();
	my @codes = ();
	my @query = ();
	my $ref = \@codes;
	my $mid_num;
	my $param;
	
	
	if ($type == 2)
	{
		
	
		for ($i=0; $i<15; $i++)
		{
			$j = $i+1;
			if (param("c$j") eq "on")
			{
				$high = get_high($j);			
				
				$mid = param("s$j");
				
				push(@request, [$high, $mid]);
							
				$high_col = $high_category{"$high"};
							
				$mid_num = get_id_of_mid($high, $mid);					
								
				push(@query, [$high_col, $mid_num]);		
				
			
			}
		}
		
		
		if (param("type") eq "on")
		{
			$ref = get_rows(\@query, 1);				
		}
		else
		{
			$ref = get_rows(\@query);				
		}
	}
	
	
	elsif($type == 1)
	{
		$param = param("keyword");
		$ref = get_rows_by_description($param, 1);
		
		check($param, 1);
		push (@request, $param);
	}
	elsif($type == 0)
	{
		$param = param("code");
		$ref = get_rows_by_description($param, 0);
		
		check($param, 0);
		push (@request, $param);
		
	}
	
	
	
	return ($ref, \@request);
	

	
	
}	



############################################   results   #####################################

sub results()
{
	
	get_pictures();

	my ($type) = @_;
	my $text = "";	
	my (@arg, @rows, @request, $high, $mid);
	my ($temp, $items, $i, $j);	
	
	
	@arg     = &get_search($type);		
	@rows    = @{$arg[0]};
	@request = @{$arg[1]};
	
		
	
	
	$items = @rows; 	
	
	$text .= center_stat(under_line_stat(bold_stat(h1_stat("Search Results"))));
	
	$text .= under_line_stat(h3_stat("you searched for : <br>"));
	
	
	if ($type == 2)
	{
		$temp = 1;
		foreach $i (@request)
		{
			($high, $mid) = @{$i};
			if ($mid)
			{
				$text .= h3_stat("$temp) $high ($mid) <br>");
			}
			else
			{
				$text .= h3_stat("$temp) $high  <br>");
			}
			$temp = $temp + 1;
		}
	}
	else
	{
		my $req = $request[0];
	
		if ($type == 1)
		{
			$text .= h3_stat("keyword - " .  "\"$req\"");
		}
		else
		{
			$text .= h3_stat("codes - \"$req\"");		
		}
	}
	
	$text .= "<hr>";
	
	$text .= h2_stat("$items items found !");
	
	$text .= "<BR>Click here to go back    ";
	$text .= submit_item("Back");
	$text .= "<BR>\n";
	$text  = form($text, "get_search");
	
	
		
	
	for ($i=0; $i<@rows; $i++)
	{
		$j = $i+1;
		$text .= "<HR>";
		$text .= h2_stat("$j)");
		$text .= "<BR>";		
		
		$text .= format_result($rows[$i]);
	
	
	}

	
	to_html("", "$text");

}





###########################################   format_result   ###################################

sub format_result()
{
	my ($arg) = @_;
	
	my @row = @{$arg};
	
	
	my $text = "";
	my $item;
	my $i;
	my ($high, $mid, $thumb);
	my ($code, $details, $verified, $gene, $similar_to);
	
	$code       = $row[0];
	$details    = $row[16];
	$verified   = $row[17];
	$gene       = $row[18];
	$similar_to = $row[19];
	
	
	
	
	$text .= bold_stat("code : 	    $code<BR>");
	
	if ($details)
	{
		$text .= bold_stat("details : 	$details<BR>");
	}
	if ($verified eq 'y')
	{
		$text .= bold_stat("verified : 	YES<BR>");
	}
	else
	{
		$text .= bold_stat("verified : 	NO<BR>");
	}
	if ($gene)
	{
		$text .= bold_stat("gene : 	    $gene<BR>");
	}
	if ($similar_to)
	{
		$text .= ak_stat("$DAVIS_DIR$similar_to", "similar to $similar_to (TGRC gene)");
	}
	
	$text .= h3_stat("categories : ");
	
	for ($i=1; $i<=15; $i++)
	{
		$item = $row[$i];
		if ($item)
		{
			$high = get_high($i);
			
			($mid)  = get_mid_by_high($high, $item);
			$text .= bold_stat("$high (sub category : $mid)<BR>");
		}
	
	}
	
	foreach $thumb (@thumbnail)
	{
		if ($thumb =~ /($code.*\.jpg)/)
		{
			$text .= "<td><a href=/mutation_images/half_size/$1 TARGET=\"_blanc\"><img src=/mutation_images/thumbnails/$thumb></a></td>";
		}
	}
	
	
	return $text;
	

}



############################################   get_rows   ##################################

sub get_rows()
{

   	my ($ref, $type) = @_ ;
	
	
	my @args = @{$ref};
	
	my @res = ();	
	
	my $error;
	my $item;
	my $query;
	my $count = 0;
	my $where = "";
	my ($item, $h, $m);
	my @temp, @cat, @values;
   	
	
	
	foreach my $item (@args)
	{
		$count ++;
		
		@temp = @{$item};
		$h = $temp[0];
		$m = $temp[1];
		
		push(@cat, $h);
		
		if ($m)
		{
			$where .= "$h = $m";
		}
		else
		{
			$where .= "$h != 0";
		}
		
		if ($count < @args)
		{
			$where .= " AND ";
		}
	}
	
	
	
	if ($type)
	{
		@values = values(%high_category);
		
		foreach my $item (@values)
		{
			if (exist ($item, \@cat) == 0)
			{
				$where .= " AND $item = 0 ";
			}
		}
	}
	
	$query = "SELECT * FROM mutant02 WHERE $where";
	
	

	my $dbh = db_link::connect_db("naama","web_usr");
	
	
	
	my $sth = $dbh->prepare($query); 
	unless($sth)
   	{
   		$error = $dbh->errstr;
		error("prepare :: $query : $error");
   	}
	
	
   	my $rv  = $sth->execute;
	unless($rv)
   	{
   		$error = $sth->errstr;
		error("Execute :: $query : $error");
   	}
	

	
	while(@temp = $sth->fetchrow_array)
	{
			push(@res, [@temp]);
	}
	
	
	$sth->finish;
	$rv = $dbh->disconnect;

	return \@res;
	

}



############################################   get_rows_by_description   ##################################

sub get_rows_by_description()
{
   	my ($param, $type) = @_ ;
	
	
	my @res = ();
	my @items;
	
	my $error;
	my $query;
	
	if ($type == 1)
	{
   		$query = "SELECT * FROM mutant02 WHERE details like \"%$param%\"";
	}
	else
	{
		$query = "SELECT * FROM mutant02 WHERE code like \"%$param%\"";
	}
	
	
   	

	my $dbh = db_link::connect_db("naama","web_usr");
	#my $dbh = DBI->connect($DB, "naama", "naama1") || error($DBI::errstr);
	
	
	my $sth = $dbh->prepare($query); 
	unless($sth)
   	{
   		$error = $dbh->errstr;
		error("prepare :: $query : $error");
   	}
	
	
   	my $rv  = $sth->execute;
	unless($rv)
   	{
   		$error = $sth->errstr;
		error("Execute :: $query : $error");
   	}
	

	
	while(@items = $sth->fetchrow_array)
	{
			push(@res, [@items]);
	}
	
	
	$sth->finish;
	$rv = $dbh->disconnect;

	return \@res;
	

}






############################################   get_rows_by_code   ##################################

sub get_rows_by_code()
{
   	my ($code) = @_ ;
	my @res = ();
	my $error;
	my @items;
	my $query;
	
   	$query = "SELECT * FROM mutant02 WHERE code = \"$code\"";
   	

	my $dbh = db_link::connect_db("naama","web_usr");
	
	
	my $sth = $dbh->prepare($query); 
	unless($sth)
   	{
   		$error = $dbh->errstr;
		error("prepare :: $query : $error");
   	}
	
	
   	my $rv  = $sth->execute;
	unless($rv)
   	{
   		$error = $sth->errstr;
		error("Execute :: $query : $error");
   	}
	

	
	@items = $sth->fetchrow_array;
	#push(@res, [@items]);
	
	
	
	$sth->finish;
	$rv = $dbh->disconnect;

	return \@items;
	

}







###########################################   get_id_of_mid   ####################################

sub get_id_of_mid()
{
   	my ($high, $mid) = @_ ;
	my @res = ();
	my $error;
	my $item;
	
	
   	my $query = "SELECT category_id FROM catalog WHERE high_category = \"$high\" AND category = \"$mid\"";
   	

	my $dbh = db_link::connect_db("naama","web_usr");
	#my $dbh = DBI->connect($DB, "naama", "naama1") || error($DBI::errstr);
	
	
	my $sth = $dbh->prepare($query); 
	unless($sth)
   	{
   		$error = $dbh->errstr;
		error("prepare :: $query : $error");
   	}
	
	
   	my $rv  = $sth->execute;
	unless($rv)
   	{
   		$error = $sth->errstr;
		error("Execute :: $query : $error");
   	}
	

	
	$item = $sth->fetchrow_array;
	
	
	$sth->finish;
	$rv = $dbh->disconnect;

	return $item;
	
	

}



############################################   get_high   #######################################

sub get_high()
{

	my($id) = @_;
	my $item;
	my @res = ();
	my $error;
	my $query;
	
	if ($id)
	{
   		$query = "SELECT high_category FROM high_catalog WHERE id = $id";
	}
	else
	{
   		$query = "SELECT high_category FROM high_catalog";
	}


	my $dbh = db_link::connect_db("naama","web_usr");
	#my $dbh = DBI->connect($DB, "naama", "naama1") || error($DBI::errstr);
	
	
	my $sth = $dbh->prepare($query); 
	unless($sth)
   	{
   		$error = $dbh->errstr;
		error("prepare :: $query : $error");
   	}
	
	
   	my $rv  = $sth->execute;
	unless($rv)
   	{
   		$error = $sth->errstr;
		error("Execute :: $query : $error");
   	}
	

	while($item = $sth->fetchrow_array)
	{
		push(@res, $item);
	}
	
	
	
	
	$sth->finish;
	$rv = $dbh->disconnect;

	if ($id)
	{
	
		return $res[0];
	}
	
	return @res;
	
}#get_persom



#####################################   get_mid_by_high   #####################################


sub get_mid_by_high()
{
	

   	my ($high, $id) = @_ ;
	my @res = ();
	my $error;
	my $item;
	my $query;
	
	if ($id)
	{
   		$query = "SELECT category FROM catalog WHERE high_category = \"$high\" AND category_id = $id";
	}
	else
	{
		$query = "SELECT category FROM catalog WHERE high_category = \"$high\"";
	}
   	

	my $dbh = db_link::connect_db("naama","web_usr");
	#my $dbh = DBI->connect($DB, "naama", "naama1") || error($DBI::errstr);
	
	
	my $sth = $dbh->prepare($query); 
	unless($sth)
   	{
   		$error = $dbh->errstr;
		error("prepare :: $query : $error");
   	}
	
	
   	my $rv  = $sth->execute;
	unless($rv)
   	{
   		$error = $sth->errstr;
		error("Execute :: $query : $error");
   	}
	

	#@res = $sth->fetchrow_array;
	while($item = $sth->fetchrow_array)
	{
		push(@res, $item);
	}
	
	
	$sth->finish;
	$rv = $dbh->disconnect;

	return @res;
	
}#get_mid_by_high





##################################   error   ##########################################

sub error()
{
	my $str ;
   	my $text = "";

   	($str) = @_ ;

   	$text .= h2_stat("ERROR !");
	$text .= $str;

	to_html("ERROR", $text);
   	
	exit;
}



#######################################   to_html   ##################################

sub to_html(){
   my $title;
   my $body;
   my $html;

   ($title, $body) = @_ ;

   #print "content-type: text/html\n\n";
   $html = head_stat(title_stat($title)) . body_stat($body);
   $html = html_stat($html);
   print $html ;

}



#######################################   form   ###########################################

sub form()
{
   my $page;
   my $body;
   my $form;

   ($body, $page) = @_ ;

   $body .= hidden_item("menu", $page);
   $form = form_stat($page, $body);
   return $form ;
}





############################################################################################
#######################################  HTML  #############################################

#all these simple subroutines return a string that matches a certain html tag.

###########################################################################################

sub html_stat(){
   my $text;
   ($text) = @_ ;
 
   return "<HTML>" . $text . "</HTML>";
}

sub head_stat(){
   my $text ;
   ($text) = @_ ;

   return "<HEAD>" . $text . "</HEAD>";
}

sub center_stat(){
   my $text ;
   ($text) = @_ ;

   return "<CENTER>" . $text . "</CENTER>";
}

sub title_stat(){
   my $title ;
   ($title) = @_ ;

   return "<TITLE> " . $title . "</TITLE>";
}

sub body_stat(){
   my $text ;
   ($text) = @_ ;

   return "<BODY BGCOLOR=\"#ffffee\">" . $text . "</BODY>";
}

sub h1_stat(){
   my $text ;
   ($text) = @_ ;
   
   return "<H1><FONT COLOR=\"#94081C\">" . $text . "</FONT></H1>";
}


sub h2_stat(){
   my $text ;
   ($text) = @_ ;
   
   return "<H2><FONT COLOR=\"#94081C\">" . $text . "</FONT></H2>";
}

sub h3_stat(){
   my $text ;
   ($text) = @_ ;
   
   return "<H3><FONT COLOR=\"#0000AF\">" . $text . "</FONT></H3>";
}

sub pre_stat(){
   my $text ;
   ($text) = @_ ;
   
   return "<pre>" . $text . "</pre>";
}


sub bold_stat(){
   my $text ;
   ($text) = @_ ;
   
   return "<B>" . $text . "</B>";
}

sub italic_stat(){
   my $text ;
   ($text) = @_ ;
   
   return "<I>" . $text . "</I>";
}

sub under_line_stat(){
   my $text ;
   ($text) = @_ ;
   
   return "<U>" . $text . "</U>";
}


sub a_stat(){
   my $url ;
   my $text ;
   ($url, $text) = @_ ;

   return "<A HREF=\"" . $url . "\">" . $text . "</A>";
}

sub ak_stat()
{
	my $url ;
   	my $text ;
   	($url, $text) = @_ ;

  	 return "<A HREF=\"" . $url . "\"target = \"_blank\">" . $text . "</A>";
}

sub form_stat(){
   my $name ;
   my $body ;
   ($name, $body) = @_ ;

   return "<FORM NAME=\"" . $name . "\" METHOD=\"POST\" ACTION=\"" . $MAIN_URL . "\">" . $body . "</FORM>";
}

sub submit_item(){
   my $value ;
   my $name ;
   my $ret ;

   ($value, $name) = @_ ;

   $ret = "<INPUT TYPE=submit ";
   $ret .= "NAME=\"" . $name . "\" " if ($name);
   $ret .= "VALUE=\"" . $value . "\">" ;
   return $ret;
}

sub reset_item(){
   my $value ;
   my $ret ;

   ($value) = @_ ;

   $ret = "<INPUT TYPE=reset ";
   $ret .= "VALUE=\"" . $value . "\">" ;
   return $ret;
}

sub checkbox_item(){
   my $name ;
   my $ret ;

   ($name, $is_checked) = @_ ;

   $ret = "<INPUT TYPE=checkbox NAME=\"" . $name . "\" ";
   $ret .= "CHECKED" if ($is_checked);
   $ret .= ">" ;
   return $ret;
}

sub radio_item(){
   my $name ;
   my $value ;
   my $ret ;
   my $act = "";

   ($name, $value, $act) = @_ ;

   $ret = "<INPUT TYPE=radio NAME=\"" . $name . "\" VALUE=\"" . $value . "\"$act>\n" ;
   return $ret;
}

sub text_item(){
   my $name ;
   my $size ;
   my $value ;
   my $ret ;

   ($name, $size, $value) = @_ ;

   $ret = "<INPUT TYPE=text NAME=\"" . $name . "\"";
   $ret .= " VALUE=\"" . $value . "\""; 
   $ret .= " SIZE=" . $size . ">";
   return $ret;
}

sub file_item(){
   my $name ;
   my $size ;
   my $ret ;

   ($name, $size) = @_ ;

   $ret = "<INPUT TYPE=file NAME=\"" . $name . "\" SIZE=" . $size . ">";
   return $ret;
}

sub textarea_item(){
   my $name ;
   my $rows, cols ;
   my $text;
   my $ret ;

   ($name, $rows, $cols, $text) = @_ ;

   $ret = "<TEXTAREA NAME=\"" . $name . "\" ROWS=$rows COLS=$cols>" ; 
   $ret .= $text . "</TEXTAREA>" ;
   return $ret;
}

sub hidden_item(){
   my $name ;
   my $value ;
   ($name, $value) = @_ ;

   return "<INPUT TYPE=hidden NAME=\"" . $name . "\" VALUE=\"" . $value . "\">" ;
}

sub select_item(){
   my $name ;
   my @values ;
   my $ret, $val;
   my $event;
   ($name, $event, @values) = @_ ;
   
   my $t = "c$event";
   

   $ret = "<SELECT NAME=\"" . $name . "\"" ;
   $ret .= "onChange = \"document.search_by_category.$t.checked = true;\">";
   
   $val = shift(@values);
   $ret .= "<OPTION VALUE=\"" . $val . "\" SELECTED>$val" ;
   foreach $val (@values){
      $ret .= "<OPTION VALUE=\"" . $val . "\">$val" ;
   }
   $ret .= "</SELECT>" ; 
   return $ret ;
}

sub table_element()
{
	my ($arg, $space) = @_;
	
	if ($space)
	{
		return "<table width = \"$space\" cellspacing=\"$space\"> $arg </table>";
	}
	
	return "<table> $arg </table>";
}

sub row_element()
{
	my @data = @_;
	my $text = "<tr>";
	
	foreach my $i (@data)
	{
		$text .= data_element($i);
	}
	$text .= "</tr>";
}

sub data_element()
{
	my ($arg) = @_;
	return "<td> $arg </td>";	
}









###########################################   exist   ##############################

sub exist()
{
	my ($item, $ref) = @_;
	
	my @arr = @{$ref};
	
	for (my $i=0; $i<@arr; $i++)
	{
		if ($arr[$i] eq $item)
		{
			return 1;
		}
	}
	
	return 0;

}


##################################   out   ####################################

sub out()
{
	
	
	open (OUT, ">>debug") or die "cannot open \"debug.txt\": $!";
	
	
	my $str;
	($str) = @_;
	
	
	print OUT $str;
	

	
	close(out);


}


#################################   get_pictures   ###############################

sub get_pictures()
{
	opendir (THUMB, "$PIC_DIR" . "thumbnails");
			#or print "can not open THUMBNAIL directory ($PIC_DIRthumbnails): $!<br>\n";
	opendir (HALF, "$PIC_DIRhalf_size");
			#or print "can not open HALFSIZE directory ($PIC_DIRhalf_size): $!<br>\n";	
		
		
	@thumbnail = readdir(THUMB);
	@halfsize  = readdir(HALF);
	
	closedir THUMB;
	closedir HALF;

}



##################################   check   #####################################

sub check()
{
	my ($param, $type) = @_;
	
	
	if ($type == 1)	
	{
		unless ($param =~ /^\S+/)
		{
			bad_format(1);
		}
	
	}
	else
	{
		unless ($param =~ /^[e|n|E|N]\d{4}$/)
		{
			bad_format(0);
		}
		
	}
}



#################################   bad_format   ##############################

sub bad_format()
{
	my ($type) = @_;
	my $text = "";
	
	
	
	
	if ($type == 1)
	{
		$text .= &bold_stat(&h1_stat("Error"));
		$text .= "<br>";
		$text .= &bold_stat("You must enter words in this option !");
		
		$text .= &bold_stat("<BR>Click here to go back");
		$text .= &submit_item("Back");
		$text .= "<BR>\n";
		$text  = &form($text, "get_search");
		
	}
	else
	{
		$text .= &bold_stat(&h1_stat("Error"));
		$text .= "<br>";
		$text .= &bold_stat("in order to search by a code you must enter one of the two letters ('e' or 'n') and then 4 digits !");
		$text .= &h3_stat("<br><br>for example \"e0240\"");	
		
		$text .= &bold_stat("<BR><BR>Click here to go back");
		$text .= &submit_item("Back");
		$text .= "<BR>\n";
		$text  = &form($text, "get_search");
	}
	
	&to_html("", $text);
	exit;
}
