#!/usr/bin/perl

use db_link;
use CGI qw(:standard);
use CGI::Carp qw(fatalsToBrowser);
use DBI;
use DBD::mysql;

$FILENAME  = "inside_search_res.pl";

$DIR       = "/cgi-bin/";
$PIC_DIR   = "/data/local/website/zamir/html/mutation_images/";
$MAIN_URL  = "/cgi-bin/$FILENAME";
$DAVIS_DIR = "http://tgrc.ucdavis.edu/data/acc/GenDetail.CFM?GENES.gene=";
$HOME	=	"http://zamir.sgn.cornell.edu/mutants/2004/";
$graphics = "http://zamir.sgn.cornell.edu/mutants/graphics/mytomato.gif";

@thumbnail = ();
@halfsize  = ();


####################################   MAIN   ###############################################

print "content-type: text/html\n\n";

print "<html>
<head>
	<title>Tomato mutant population Search Results</title>
</head>

<body BGCOLOR=\"#ffffcc\">


<TABLE width=\"100%\" cellpading=\"10\" cellspacing =\"20\" border=\"0\">

<TR>
       <TD colspan =\"3\"><h1><center><A NAME=\"top\">Search Results</A></center></h1><BR><HR></TD>
</TR>

<TR><TD>";

$menu = param("menu");

if ($menu eq "search_by_code")
{
	results(1);
}
elsif ($menu eq "search_by_mutant_name")
{
	results(2);
}
elsif ($menu eq "search_by_person")
{
	results(3);
}

print "</TD></TR></TABLE></BODY></HTML>";

############################################   results   #####################################

sub results()
{
	get_pictures();

	my ($type) = @_;
	my $text = "";	
	my (@arg, @rows, @request, @shared, $high, $mid);
	my ($temp, $items, $i, $j);	
	
	
	@arg     = &get_search($type);		###
	@rows    = @{$arg[0]};
	@request = @{$arg[1]};
	@shared = @{$arg[2]};  ###############################
	
	$items = @rows; 
	$share = @shared;	
	
	$text .= "<U><H3>you searched for:</U> ";
	

		my $req = $request[0];
	
		if ($type == 1)
		{
			$text .= "  code = $req </h3>";
		}
		elsif ($type == 2)
		{
			$text .= "  mutant name = $req </h3>";
		}
		elsif ($type == 3)
		{
			$text .= "  person = $req </h3>";		
		}
	
	
	if (@rows) {
	   	$text .= "<h4><A HREF=\"#mutants\">$items entries</A> found in the mutant database</h4>";
	}
	$text .= "<h4><A HREF=\"#shared\">$share entries</A> found in the shared database</h4>";

	$text .= "<FORM NAME= \"get_search\" ACTION=\"inside_search.pl\" method =\"POST\">
	<INPUT TYPE=\"submit\" VALUE=\"back to the search page\"></FORM>";

	$text .= "<A NAME=\"mutants\"></A>";
	for ($i=0; $i<@rows; $i++)
	{
		$j = $i+1;
		$text .= "<HR>";
		$text .= "<H2>$j</H2>";
		$text .= "<BR>";		
		$text .= format_result($rows[$i]);
	}

	$text .="</TD></TR></TABLE><HR>"; 
	$text .="<BR><BR><H4><FONT COLOR=\"#0099CC\"><A NAME=\"shared\">Shared data and crosses available for your search criteria:</A></H4>";
	if (@shared) {  
	   $text .="<TABLE border =0 cellpadding=0 cellspacing = 10>";
	   $text .="<TR><TD colspan=7 bgcolor=\"#000000\"></TD></TR>";
	   $text .="<TH>Person</TH><TH>Code</TH><TH>Cross to</TH><TH>Name</TH><TH>Generation</TH><TH>Comments</TH>";
	   $text .="<TR><TD colspan=7 bgcolor=\"#000000\"></TD></TR>";
	   for ($i=0; $i<@shared; $i++)
	   {
		   $j = $i+1;
		   
		   $text .= "<TR>";

		   $text .= format_shared($shared[$i]);   ################
		}
		$text .= "</TABLE><BR>";
	}else { 
		  $text .= "<h3><font color = #CC3300>None available</h3><BR>";
	}	
	$text .= "<BR><BR><BR><A HREF=\"#top\">Return to top</A>";  
	to_html("search results", "$text");

}#results

###################################   get_search   #######################################

sub get_search()
{
	my ($type) = @_;
	my @request = ();
	my $ref;
	my $shared;
	my $param;

	
	if ($type == 1)
	{
	   $radio= param("theRadio");
	   if ($radio eq "acc") {
		  $param = param("code");
		  $ref = get_rows_by_description($param, 1);
		}elsif ($radio eq "misc") {
		  $param = param("misc_code");
		}
		
		$shared = get_shared_mutants($param, 1);
		
		check($param, 1);
		push (@request, $param);
	}
	elsif($type == 2)
	{
		$param = param("mutant_name");
		$ref = get_rows_by_description($param, 2);
		$shared = get_shared_mutants($param, 2);
		
		check($param, 2);
		push (@request, $param);
	}
	
	elsif($type == 3)
	{
		$param = param("person");
		#$ref = get_rows_by_description($param, 3);
		$shared = get_shared_mutants($param, 3);
		
		check($param, 3);
		push (@request, $param);
		
	}
	
	return ($ref, \@request, $shared);
	
}#get_search	


############################################   get_rows_by_description   ##################################

sub get_rows_by_description()
{
    my ($param, $type) = @_;
	my @res = ();
	my @items;
	my $error;
	my $query;
	
	if ($type == 1)
	{ 
   		$query = "SELECT * from mutant04 WHERE mutant04.code like \"%$param%\"";
		#$query_shared = "SELECT * from shared_mutants WHERE code= \"$param\" OR cross_to= \"$param\"";
	}
	elsif ($type == 2)
	{
   		$query = "SELECT * FROM mutant04 WHERE allelic_to_gmt=\"$param\"";
		#and (mutant04.code=shared_mutants.code or  mutant04.code=shared_mutants.cross_to)";
	}
	
	my $dbh = db_link::connect_db("naama","web_usr");
	#my $dbh = DBI->connect($DB, "naama", "naama1") || error($DBI::errstr);
	
	#my $sth_shared = $dbh->prepare($query_shared); 
	my $sth = $dbh->prepare($query); 
	unless($sth)
   	{
   		$error = $dbh->errstr;
		error("prepare :: $query : $error");
   	}
	
	#my $rv_shared  = $sth_shared->execute;
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
	

}#get_rows_by_description

############################################   get_shared_mutants   ##################################

sub get_shared_mutants()
{
    my ($param, $type) = @_;
	my @res = ();
	my @items;
	my $error;
	my $query;
	
	if ($type == 1)
	{ 
		$query = "SELECT * from shared_mutants WHERE code= \"$param\" OR cross_to= \"$param\"";
	}
	elsif ($type == 2)
	{
   		$query = "SELECT * FROM shared_mutants, mutant04 WHERE allelic_to_gmt=\"$param\" and (mutant04.code=shared_mutants.code or  mutant04.code=shared_mutants.cross_to)";
	}
	elsif ($type == 3)
	{
	 	  $query = "SELECT * FROM shared_mutants, mutant04 WHERE person=\"$param\" and mutant04.code=shared_mutants.code";
	}
	
	
	my $dbh = db_link::connect_db("naama","web_usr");
	
	#my $sth_shared = $dbh->prepare($query_shared); 
	my $sth = $dbh->prepare($query); 
	unless($sth)
   	{
   		$error = $dbh->errstr;
		error("prepare :: $query : $error");
   	}
	
	#my $rv_shared  = $sth_shared->execute;
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
	
	
	#while(@items_shared = $sth_shared->fetchrow_array)
	#{
	#		push(@res_shared, [@items_shared]);
	#}
	
	
	$sth->finish;
	$rv = $dbh->disconnect;

	return \@res;

}#get_shared_mutants


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
	$allelic_to_tgrc = $row[20];
	$allelic_to_gmt = $row[21];
		
	
	$text .= "<B>code : 	    $code<BR>";
	
	if ($details)
	{
		$text .= "details : 	$details<BR>";
	}
	if ($verified eq 'y')
	{
		$text .= "verified : 	YES<BR>";
	}
	else
	{
		$text .= "verified : 	NO<BR>";
	}
	if ($gene)
	{
		$text .= "gene : 	    $gene<BR>";
	}
	if ($similar_to)
	{
		if ($allelic_to_tgrc eq 'y')
		{
		   $text .= ak_stat("$DAVIS_DIR$similar_to", "$similar_to allele (TGRC gene)<BR><BR>");
		}
		else
		{
		 	$text .= ak_stat("$DAVIS_DIR$similar_to", "similar to $similar_to (TGRC gene)<BR><BR>");
		}	
	}
	
	if ($allelic_to_gmt)
	{
 	 $text .="<U>Known alleles: </U><BR>";   
	  @alleles= get_alleles($allelic_to_gmt,$code);
	  foreach $a (@alleles)
	  {
	  $text .= "<B> 	   $a </B><BR>";   
	  }
	}
	  
	$text .= "<H3>categories : </H3>";
	
	for ($i=1; $i<=15; $i++)
	{
		$item = $row[$i];
		if ($item)
		{
			$high = get_high($i);
			($mid)  = get_mid_by_high($high, $item);
			$text .= "$high (sub category : $mid)<BR>";
		}
	}
	
	$text .= "<table><tr>";
	foreach $thumb (@thumbnail)
	{
		if ($thumb =~ /($code.*\.jpg)/)
		{
			$text .= "<td><a href=/mutation_images/half_size/$1 TARGET=\"_blanc\"><img src=/mutation_images/thumbnails/$thumb></a></td>";
		}
	}
	
	$text .= "</tr></table>";
	
	return $text;
}#format_results

###########################################   format_shared  ###################################

sub format_shared()
{
	my ($arg) = @_;
	
	my @row = @{$arg};

	my $text = "";
	my $item;
	my $i;
	my ($person, $code, $cross_to, $name, $generation, $comments);
	
	$person     = $row[0];
	$code       = $row[1];
	$cross_to   = $row[2];
	$name       = $row[3];
	$generation = $row[4];
	$comments   = $row[5];
		
	$text .="<FORM NAME= \"update\" ACTION=\"update_db.pl\"  method =\"POST\">";
	$text .= "<TD><input type=\"hidden\" name=\"person\" value=$person>$person</TD>";
	$text .= "<TD><input type=\"hidden\" name=\"code\" value=$code>$code</TD>";
	$text .= "<TD><input type=\"hidden\" name=\"cross_misc\" value=$cross_to>$cross_to</TD>";
	$text .= "<TD><input type=\"hidden\" name=\"name\" value=\"$name\">$name</TD>";
	$text .= "<TD><input type=\"hidden\" name=\"generation\" value=$generation>$generation</TD>";
	$text .= "<TD><input type=\"hidden\" name=\"comments\" value=\"$comments\">$comments</TD>";
	
	$text .= "<TD><INPUT TYPE=\"submit\" VALUE=\"Update\">";
	$text .="<input type=\"hidden\" name=\"menu\" value=\"update\"></FORM></TD></TR>";
	
	
	$text .="<TR><TD colspan=7 bgcolor=\"#cccccc\"></TD></TR>";
	$text .="</TR>";
	
	return $text;
}#format_shared

#####################################   get_alleles   #####################################

sub get_alleles()
{
	my ($group, $code) = @_ ;
	my @res = ();
	my @items;
	my $error;
	my $item;
	my $query;
	
   		$query = "SELECT code FROM mutant04 where allelic_to_gmt=\"$group\" and code!=\"$code\"";
	 	
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
	
	while($item = $sth->fetchrow_array) 
	{	
			push(@res, $item); 
	}
	
	$sth->finish;
	$rv = $dbh->disconnect;

	return @res;
}#get_alleles

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
	
}#get_high


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
	
	 unless ($param =~ /^\S+/)
		{
	 	  bad_format(2);
		}
}

#################################   bad_format   ##############################

sub bad_format()
{
	my ($type) = @_;
	my $text = "";

	$text .= "<B><H1>Error</H1>";
	$text .= "<br>";

	$text .= "You must select an option !";
	
	$text .= "<BR><BR>Click here to go back";
	
	$text .= "<FORM NAME= \"get_search\" ACTION=\"inside_search.pl\" method =\"POST\">
		  	 <INPUT TYPE=\"submit\" VALUE=\"back\"></FORM>";
	$text .= "<BR>\n";
	
	&to_html("error", $text);
	exit;
	
}#bad_format

##################################   error   ##########################################

sub error()
{
	my $str ;
   	my $text = "";

   	($str) = @_ ;

   	$text .= "<h2>ERROR !</h2>";
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
   $html = "<html><head><title>$title</title><head><body>$body</body></html>";
   print $html ;
}



sub ak_stat()
{
	my $url ;
   	my $text ;
   	($url, $text) = @_ ;

  	 return "<A HREF=\"" . $url . "\"target = \"_blank\">" . $text . "</A>";
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
