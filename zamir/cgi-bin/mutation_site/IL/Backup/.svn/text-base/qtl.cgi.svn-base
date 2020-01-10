#!/usr/bin/perl



use zamir::db_link;
use CGI qw(:standard);
use CGI::Carp qw(fatalsToBrowser);
#use DBI;
#use DBD::mysql;

use strict;
use warnings;





my ($MAIN_URL, $FILENAME, $DIR, $DAVIS_DIR, $PIC_DIR, $PIC_URL, $IL_NUM, $MAP_URL);
my $menu;

$FILENAME  = "qtl.cgi";
$IL_NUM    =  76;

$DIR       = "/cgi-bin/mutation_site/";
$PIC_DIR = "/soldb/website/sgn/html/mutation_images/IL/";
$PIC_URL = "mutation_images/IL/";
$MAP_URL = "http://www.sgn.cornell.edu/maps/pennellii_il/";

$MAIN_URL  = "/cgi-bin/mutation_site/IL/$FILENAME";
$DAVIS_DIR = "http://tgrc.ucdavis.edu/Data/Acc/AccDetail.CFM?ACCESSIONS.AccessionNum=";




####################################   MAIN   ###############################################

print "content-type: text/html\n\n";



$menu = param("menu");



if ($menu eq "il_card")
{
	&display_il_card();
}
elsif ($menu eq "display_first")
{
	&display_first();
}
elsif ($menu eq "debug")
{
	&debug();
	
}
else
{
	&display_first();
}


############################################   format_il   ######################################

sub format_il()
{
	my $text = "";
	my ($temp, $pic, $ref, $var, $line, $cells, $hash_ref, $title, $table, $list, $l_item);
	my ($arg) = @_;
	my $rows  = "";
	my @table;
	my @element = ();
	my @pictures;
	my %hash;
	
	
	my ($id, $genotype, $number, $accession, $chromosome, $north, $south, $genes, $observation, $fine_mapping, $publication, $allozymes);
	
	$id           = &map($arg, "id");
	$genotype     = &map($arg, "genotype");
	$number       = &map($arg, "number");
	$accession    = &map($arg, "accession");
	$chromosome   = &map($arg, "chromosome");
	$north        = &map($arg, "north");
	$south        = &map($arg, "south");
	$genes        = &map($arg, "genes");
	$observation  = &map($arg, "observation");
	$fine_mapping = &map($arg, "fine_mapping");
	$publication  = &map($arg, "publication");
	$allozymes    = &map($arg, "allozymes");
	
	
	$text = bold_stat(&style_stat($genotype, 170, "brown", 1));
	
	$hash_ref  = &get_hash_pictures("$genotype");	
	%hash      = %{$hash_ref};
	
	
	if (!($genotype eq "IL9-3-1"))
	{
		$cells = &data_element("field", "center", "", "", 1) . &data_element("scan", "center", "", "", 1);
		$line  = &data_element($hash_ref->{"field"} . &data_element($hash_ref->{"scan"}));
	}
	else
	{
		$cells = &data_element("field", "center", "", "", 1);
		$line  = &data_element($hash_ref->{"field"});
	
		
	}
	
	while (($title, $pic) = each(%hash))
	{
		if (!($title eq "chromosome_chart") && !($title eq "field") && !($title eq "scan"))
		{
			$cells .= &data_element("$title", "center", "", "", 1);
			$line  .= &data_element("$pic" , "left");
		}
		
	}
	
	
	$table[0] = &table_element(&r_element($cells) . &r_element($line));
	
	$cells = &r_element(&data_element("chromosome_chart", "center", "", "", 1));
	$line  = &r_element(&data_element($hash_ref->{"chromosome_chart"}, "center"));
	
		
	$table[1] = &table_element($cells . $line);
	
	
	$line = "";
	
	
	
	$line .= &row_element(&bold_stat(&style_stat("Map Location : ", 125, "blue", 1) . "chromosome $chromosome, north - $north, south - $south"));
	
	if ($genes)	
	{
		$var = $genes;	
	}
	else
	{
		$var = "none";
	}	
	
	$line .= &row_element(&bold_stat(&style_stat("known mendelian genes : ", 125, "blue", 1)  . "$var"));
	
	if ($observation)
	{
		$var = 	$observation;
	}
	else
	{
		$var = "none";
	}
	
	$line .= &row_element(&bold_stat(&style_stat("Observations : ", 125, "blue", 1) . "$var"));
	
	if ($publication)
	{
		$var = $publication;
	}
	else
	{
		$var = "none";
	}
	
	$line .= &row_element(&bold_stat(&style_stat("publication : ", 125, "blue", 1) . "$var"));
	
	$line .= &row_element(&bold_stat(&style_stat("PCR Primers For IL Border Marker :", 125, "blue", 1)));
	
	
	my (@cols, @cols1);
	$cols[0] = &bold_stat(&under_line_stat("North - $north", 1));
	$cols[1] = &bold_stat(" FW - 5' : ");
	$cols[2] = &bold_stat("aaaaaaaaaaaaaaaaaaaaa");
	$cols[3] = &bold_stat(" REV - 5' : ");
	$cols[4] = &bold_stat("aaaaaaaaaaaaaaaaaaaaa");
	
	$temp = &li_stat(join("", @cols));
	
	$cols1[0] = &bold_stat(under_line_stat("South - $south", 1));
	$cols1[1] = &bold_stat(" FW - 5' : ");
	$cols1[2] = &bold_stat("aaaaaaaaaaaaaaaaaaaaa");
	$cols1[3] = &bold_stat(" REV - 5' :");
	$cols1[4] = &bold_stat("aaaaaaaaaaaaaaaaaaaaa");
	
	$temp .= &li_stat(join("", @cols1));
	
	$line .= &row_element(&ul_stat($temp));
	

	$line .= &row_element(&bold_stat(&style_stat("Links :", 125, "blue", 1)));
	
	$l_item = &li_stat(&a_stat("$MAP_URL" . "chr$chromosome.html", &bold_stat(&under_line_stat("SGN : Chromosome$chromosome", 1))));	
	
	if ($accession)
	{
		$l_item .= &li_stat(&a_stat("$DAVIS_DIR$accession" , &bold_stat(&under_line_stat("TGRC accession # : $accession", 1))));
	}
	
	$line .= &row_element(&ul_stat($l_item));
	
	$table[2] = &table_element($line);
	
	
	
	
	
	#$rows .= r_element(data_element($table, "", "", 3));
	
	
	
	$text .= &table_element(&r_element(&data_element($table[0]) . &data_element($table[1], "", 2)) . &row_element($table[2]));
	
	#$text .= row_element($rows, $space);
	
	
	$text .= "<input type=\"button\" value=\"Close window\"  onClick=\"self.close()\"><br>";
	$text  = &form($text, "display_first");
	
	
	
	
	to_html("il_card", \$text);
	

}


##################################   display_il_card   #################################

sub display_il_card()
{
	my $text = "";
	my $gen  = param("il");
	
	
	&format_il(&get_row($gen, 2));
	

}

	
	
	
###################################   display_first   ###################################

sub display_first()
{
	my $text = "";
	my (@row, @ils);
	my $ref;
	
	$text .= &h2_stat(&under_line_stat("IL SEARCH"));
	
	$text .= "<br>";
	
	$text .= &h3_stat("please choose one of these lines :");
	
	
	for (my $i = 1; $i <= $IL_NUM; $i++)
	{
		$ref = &get_row($i, 1);
		@row = @{$ref};
		
		
		push(@ils, $row[1]);
	}
	
	$text .=  &select_item("il", @ils);
	$text .= "<br>";
	$text .= &submit_item("Submit") . &reset_item("reset");
	$text  = &form($text, "il_card");
	
	to_html("", \$text);

}








############################################   get_row   ##################################

sub get_row()
{
   	my ($param, $type) = @_ ;
	my @res = ();
	my $error;
	my @items;
	my $query;
	
	
	if ($type == 1)
	{
   		$query = "SELECT * FROM il_cards WHERE id = $param";
	}
	else
	{
		$query = "SELECT * FROM il_cards WHERE genotype = \"$param\"";
	}
   	
	

	my $dbh = db_link::connect_db("naama","web_usr");
	
	
	my $sth = $dbh->prepare($query); 
	unless($sth)
   	{
   		$error = $dbh->errstr;
		&error("prepare :: $query : $error");
   	}
	
	
   	my $rv  = $sth->execute;
	unless($rv)
   	{
   		$error = $sth->errstr;
		&error("Execute :: $query : $error");
   	}
	

	
	@items = $sth->fetchrow_array;
	#push(@res, [@items]);
	
	
	$sth->finish;
	$rv = $dbh->disconnect;

	return \@items;
	

}













##################################   error   ##########################################

sub error()
{
	my $str ;
   	my $text = "";

   	($str) = @_ ;

   	$text .= h2_stat("ERROR !");
	$text .= $str;

	&to_html("ERROR", \$text);
   	
	exit;
}



#######################################   to_html   ##################################

sub to_html(){
   my $ref;
   my $title;
   my $body;
   my $html;

   ($title, $ref) = @_ ;
    
	$body = ${$ref};

   #print "content-type: text/html\n\n";
   $html = &head_stat(&title_stat($title)) . &body_stat($body);
   $html = &html_stat($html);
   print $html ;

}



#######################################   form   ###########################################

sub form()
{
   my $page;
   my $body;
   my $form;

   ($body, $page) = @_ ;

   $body .= &hidden_item("menu", $page);
   $form = &form_stat($page, $body);
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

   my ($text, $type) ;
   ($text, $type) = @_ ;
   
   if ($type)
   {
   	return "<U><FONT COLOR=\"#0000AF\">" . $text . "</FONT></U>";
   }
   return "<U>" . $text . "</U>";
}

sub style_stat()
{
	my ($arg, $size, $color, $u) = @_;
	my $text;
	
	if ($u)
	{
		$text = "<u style=font-size:$size%;color:$color> $arg </u>";
	}
	else
	{	
		$text = "<p style=font-size:$size%;color:$color> $arg </p>";
	}
	
	return $text;
	
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

sub ac_stat()
{
	my $url ;
   	my $text ;
   	($url, $text) = @_ ;

  	 return "<A HREF=\"" . $url . "\"target = \"_blanc\">" . $text . "</A>";
}


sub image_stat()
{
	
	my ($url, $width, $height) = @_;
	
	return "<IMG SRC= $url width=\"$width\" height=\"$height\">";
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
	my $is_checked;
	
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
   my ($rows, $cols);
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
   my ($ret, $val);
   my $event;
   ($name, @values) = @_ ;
   
   

   $ret = "<SELECT NAME=\"" . $name . "\">" ;
   #$ret .= "onChange = \"document.search_by_category.$t.checked = true;\">";
   
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
	my $border = 0;
	
	if ($space)
	{
		return "<table width = \"$space\" cellspacing=\"$space\"  border = \"$border\"> $arg </table>";
	}
	
	return "<table border = \"$border\"> $arg </table>";
}

sub row_element()
{
	my @data = @_;
	my $text = "<tr>";
	
	foreach my $i (@data)
	{
		$text .= &data_element($i);
	}
	$text .= "</tr>";
}

sub r_element()
{
	my ($arg) = @_;
	
	return "<tr> $arg </tr>";
}

sub data_element()
{
	my ($arg, $align, $row_span, $col_span, $type) = @_;
	my $t;
	
	if ($type)
	{
		$t = "th";
	}
	else
	{
		$t = "td";
	}
	
	if ($align && $row_span)
	{
		return "<$t align=\"$align\" rowspan = \"$row_span\"> $arg </$t>";
	}
	if ($align)
	{
		return "<$t align=\"$align\"> $arg </$t>";	
	}
	if ($row_span)
	{
		return "<$t rowspan=\"$row_span\"> $arg </$t>";
	}
	if ($col_span)
	{
		return "<$t colspan=\"$col_span\"> $arg </$t>";
	}
	
	return "<$t> $arg </$t>";	
}

sub li_stat()
{
	my ($arg) = @_;
	
	return "<li> $arg </li>";
}

sub ul_stat()
{
	my ($arg) = @_;
	
	return "<ul> $arg </ul>";
}


###################################   get_hash_pictures   ###################################

sub get_hash_pictures()
{
	my ($genotype) = @_;
	my $pic;
	my $ref = &get_folder($genotype);
	my @pictures = @{$ref};
	my @others;
	my $num = @pictures;

	
	my %hash = ();
	
	foreach $pic (@pictures)
	{
		
		$pic =~ /.*?_(.*)\.jpg/;
		
		
		
		$hash{"$1"} = &ac_stat("$PIC_URL$genotype/$pic" , &image_stat("$PIC_URL$genotype/$pic", 120, 120));
	
	}
	
	
	
	
	
	my $chart = "Chart/";
	
	$ref = get_folder($chart);
	@pictures = @{$ref};
	
	my @arr = split(/-/, $genotype);
	my $f_genotype = join("/-", @arr);	
	
	
	foreach $pic (@pictures)
	{
		
		if ($pic =~ /$genotype[_]/)
		{
			$hash{"chromosome_chart"} = &ac_stat("$PIC_URL$chart$pic" , &image_stat("$PIC_URL$chart$pic", 175, 440));
		}
	}
	
	
	return \%hash;
	
	
	
}



###################################   get_folder   ###################################

sub get_folder()
{
	my ($r_folder) = @_;
	my $folder = "$PIC_DIR$r_folder";
	my @thumb;
	
	
	
	opendir (THUMB, "$folder")	or print "can not open THUMBNAIL directory ($folder): $!<br>\n";
		
		
	@thumb = readdir(THUMB);
	
	
	
	shift(@thumb);
	shift(@thumb);
	
	
	closedir THUMB;
	
	return \@thumb;

}



##################################   map   #################################

sub map()
{
	my ($ref, $key) = @_;
	
	my @row = @{$ref};
	my $item;
	
	
	if ($key eq "id")
	{
		$item = 0;
	}
	elsif ($key eq "genotype")
	{	
		$item = 1;
	}
	elsif ($key eq "number")
	{
		$item = 2;
	}
	elsif ($key eq "accession")
	{
		$item = 3;	
	}
	elsif ($key eq "chromosome")
	{
		$item = 4;
	}
	elsif ($key eq "north")
	{
		$item = 5;
	}
	elsif ($key eq "south")
	{
		$item = 6;
	}
	elsif ($key eq "genes")
	{
		$item = 7;
	}
	elsif ($key eq "observation")
	{
		$item = 8;
	}
	elsif ($key eq "fine_mapping")
	{
		$item = 9;
	}
	elsif ($key eq "publication")
	{
		$item = 10;
	}
	elsif ($key eq "allozymes")
	{
		$item = 11;
	}
	
	return $row[$item];
	

}



####################################  debug   ############################

sub debug()
{
	&error("Debugging ..... !");

}

