#!/usr/bin/perl

use db_link;
use CGI qw(:standard);
use CGI::Carp qw(fatalsToBrowser);
use DBI;
use DBD::mysql;


$FILENAME  = "update_db.pl";

$DIR       = "/cgi-bin/";
$PIC_DIR   = "/data/local/website/zamir/html/mutation_images/";
$MAIN_URL  = "/cgi-bin/$FILENAME";
$DAVIS_DIR = "http://tgrc.ucdavis.edu/data/acc/GenDetail.CFM?GENES.gene=";
$HOME	=	"http://zamir.sgn.cornell.edu/mutants/2004/";
$graphics = "http://zamir.sgn.cornell.edu/mutants/graphics/mytomato.gif";

my $menu;
my (@insert, @update, @load_update) = ();

####################################   MAIN   ###############################################

print "content-type: text/html\n\n";

print "<html>
<head>
	<title>Insert a new entry to the database</title>
</head>

<body BGCOLOR=\"#ffffcc\">


<TABLE width=\"100%\" cellpading=\"10\" cellspacing =\"10\" border=\"0\">";
print "<TR>
       <TD colspan =\"2\"><h1><center>Update your database entries</center></h1><BR><HR></TD>
	   </TR><TR><TD>";

$menu = param("menu");
#######insert new entry - prints the entry and sends to "confirm"
if ($menu eq "insert") {
	
	@insert= get_update($menu);
	print_query($menu,@insert);
	print "<TR><TD><TABLE><TR><TD><FORM NAME= \"confirm\" ACTION=\"update_db.pl\" method = \"post\">
	<INPUT TYPE=\"submit\"  VALUE=\"confirm\">
	<INPUT TYPE=\"hidden\"  NAME=\"menu\" VALUE=\"@insert\">
	</FORM></TD>";

	print "<TD><FORM NAME= \"get_search\" ACTION=\"inside_search.pl\" method =\"POST\">
	<INPUT TYPE=\"submit\" VALUE=\"Deny\"></FORM></TD></TR></TABLE></TD></TR>";


#######update an existing entry
}elsif ($menu eq "update") {

       print "<FORM NAME= \"update\" ACTION=\"update_db.pl\" method = \"post\">";
	   @update= get_update();
	   print_update($menu,@update);
	   print "<TR><TD><TABLE><TR><TD> SENDING UPDATES WILL BE AVAILABLE SOON";
	   #<INPUT TYPE=\"submit\"  VALUE=\"Send update\">
	  print "<INPUT TYPE=\"hidden\"  NAME=\"menu\" VALUE=\"load_update\">
	   </FORM></TD>";
########load the update to DB
}elsif ($menu eq "load_update") {
	   
	   @load_update = get_update();
	   my $table= "shared_mutants";
	   update_query($table, @load_update);
	   
	   #my $table= "web_updates";
	   #update_query($table, @load_update);
	   
	   print_query ($menu, @load_update);
	   
	   print "<TR><TD><TABLE><TR><TD><FORM NAME= \"get_search\" ACTION=\"inside_search.pl\" method = \"post\">
	   <INPUT TYPE=\"submit\"  VALUE=\"Go back to the search and update page\">
	   </FORM></TD>";	  
#######confirm insert new entry
}elsif ($menu =~ /^\S+.*\d{4}.*/) {
	   
	   @insert = split(/\s/, $menu);
	   print_query($dummy, @insert);
	   my $table= "shared_mutants";
	   insert_query($table, @insert);
	   
	   my $table= "web_updates";
	   insert_query($table, @insert);
	   
	   print "<TR><TD><TABLE><TR><TD><FORM NAME= \"get_search\" ACTION=\"inside_search.pl\" method = \"post\">
	   <INPUT TYPE=\"submit\"  VALUE=\"Go back to the search and update page\">
	   </FORM></TD>";	   

#########if $menu is null - like when loading this script w/o sending var   
}else {
	bad_format();	
}


print "</TABLE></BODY></HTML>";

###################################   get_update   #######################################

sub get_update()
{
	my $menu = @_;
	my @query= ();
	my $person=param("person");
	my $code = param("code");
	my $cross= param("cross_code"); 
	my $name = param("name");
	my $generation = param("generation");
	my $comments = param("comments");
	
	
	if (param("person")) {
	   	push(@query, $person);	
	}else { 
		bad_format (1); 
	}	
	if (param("code")) {
	   push(@query, $code);	
	}else { 
		bad_format (2); 
	}	
	
	my $radio= param("Radio2");
	if ($radio eq "code") {
	   check($cross);
	   push(@query, $cross);	
	}else{
		$cross = param("cross_misc");
		push(@query, $cross);	
	}
	if ($menu) {
	   check($code, $cross);
	}
	

	push(@query, $name, $generation, $comments);
		
	return (@query);
}	

###########################################  print_query  ###################################

sub print_query()
{
	my ($type, @insert) = @_;
	print "<TR><TD><TABLE><TR><TD colspan = \"2\"><U><B>";
	if ($type eq "insert") {
	   print "Please confirm inserting the following entry:";
	}elsif ($type eq "load_update") {
		print "Your entry has been updated to:";
	} else {
		print "You inserted the following entry to the database:";
	}	    	  
	print "</B></U></TD></TR>";
	print "<TR><TD>Your name:</TD><TD>@insert[0]</TD></TR>";
	print "<TR><TD>Mutant code:</TD><TD>@insert[1]</TD></TR>";
	if (@insert[2]) {
	   print "<TR><TD>Cross to:</TD><TD>@insert[2]</TD></TR>";
	}
	if (@insert[3]) {
	   print "<TR><TD>Accession name:</TD><TD>@insert[3]</TD></TR>";
	}
	if (@insert[4]) {
	   print "<TR><TD>Generation:</TD><TD>@insert[4]</TD></TR>";
	}
	if (@insert[5]) {
	   print "<TR><TD>Comments:</TD><TD>@insert[5]</TD></TR>";
	}
	print "</TABLE></TD></TR>";
	
	
}#print_query


###########################################   insert_query  ###################################

sub insert_query()
{
	my ($table, @vals) = @_;
	my $error;
	my $query;
	
   	$query = "INSERT INTO $table VALUES ('@vals[0]\',\'@vals[1]\',\'@vals[2]\',\'@vals[3]\',\'@vals[4]\',\'@vals[5]\', NOW())";	
	
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
	
	$sth->finish;
	$rv = $dbh->disconnect;

}#insert_query

###########################################   update_query  ###################################

sub update_query()
{
	my ($table, @vals) = @_;
	my $error;
	my $query;
	
   	$query = "UPDATE $table SET name=\'@vals[3]\' , generation=\'@vals[4]\' ,  comments=\'@vals[5]\' WHERE person=\'@vals[0]\' AND code=\'@vals[1]\'  AND cross_to=\'@vals[2]\'";	
	
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
	
	$sth->finish;
	$rv = $dbh->disconnect;

}#update_query

###########################################  print_update  ###################################

sub print_update()
{
	my ($type, @update) = @_;
	
	print "<TR><TD><TABLE><TR><TD colspan = \"2\"><U><B>";
	if ($type) {
	   print "Please update the following entry:";
	} else {
		print "Your entry has been updated";
	}	    	  
	print "</B></U></TD></TR>";
	print "<TR><TD>Your name:</TD><TD>@update[0]<INPUT TYPE=\"hidden\"  NAME=\"person\" VALUE=\"@update[0]\"></TD></TR>";
	print "<TR><TD>Mutant code:</TD><TD>@update[1]<INPUT TYPE=\"hidden\"  NAME=\"code\" VALUE=\"@update[1]\"></TD></TR>";
	
	  print "<TR><TD>Cross to:</TD><TD>@update[2]<INPUT TYPE=\"hidden\"  NAME=\"cross_misc\" VALUE=\"@update[2]\"></TD></TR>";

	   print "<TR><TD>Accession name:</TD><TD><INPUT TYPE =\"text\" name =\"name\" value=\"@update[3]\"></TD></TR>";
	
	   print "<TR><TD>Generation:</TD><TD><SELECT NAME=\"generation\" value=\"@update[4]\">";
	   my @options= ("","F1","F2","F3","BC1","BC2","BC3","BC4","BC5");
	   $selected= @update[4];
	   print_options($selected, @options);
	   print "</SELECT></TD></TR>";
	   print "<TR><TD>Comments:</TD><TD><TEXTAREA rows=\"4\"  cols=\"20\" name=\"comments\">@update[5]</TEXTAREA></TD></TR>";

	print "</TABLE></TD></TR>";
	
	
}#print_update

################################print_options##############################3

sub print_options()
{
 	my ($selected, @options)= @_;
	foreach $op(@options) {	 
			print "<OPTION VALUE=$op"; 
			if ($selected eq $op) { print " SELECTED"; 
			} 
			print ">$op\n";
		}   
}
##################################   check   #####################################

sub check()
{
	my ($param, $param2) = @_;
	my $table= "mutant04";
	
	 unless ($param =~ /^[e|n|E|N]\d{4}m\d$/)
		{
	 	  bad_format(2);
		}
	my $code = check_code($param, $table);
	 unless ($code) {
			 bad_format(3, $param);
		}
	if ($param eq $param2) {
	   bad_format(4, $param);
	 }
	 
	#if ($param2) {
	   my $code = check_exists($param,$param2);
	   if ($code) {
	   print "$param  X  $param2";
		 bad_format(5, $param);
		 
	   }
	  my $code = check_exists($param2,$param);
	   if ($code) {
	   print "$param  X  $param2";
		 bad_format(5, $param);
		 
	   } 
	#}
}

#################################   bad_format   ##############################

sub bad_format()
{
	my ($type, $code) = @_;
	my $text = "";
	$text .= "<B><H1>Error</H1>";
	$text .= "<br>";
	
	if ($type == 1) {
	   $text .= "You must select an person name !<BR>";
	   $text .= "If your name is not on the list please send mail to <A HREF=\"MAILTO:shaham@agri.huji.ac.il\">Naama</A><BR>";
	}
	if ($type == 2) {
	   $text .= "You must type a correct code !<BR>";
	   $text .= "A mutant code should begin with an \"e\" (EMS mutant) or an \"n\" (Fast-neutron)<BR>";
	   $text .="followed by 4 digits, and end with the mutation number (\"m#\")<BR>";
	   $text .="for example \"n0030m1\"";
	}
	if ($type == 3) {
	   $text .= "mutant # $code does not exist in the database !<BR>";
	}
	if ($type == 4) {
	   $text .= "you must type in different accessions for code and cross_to !<BR>";
	}
	if ($type == 5) {
	   $text .= "This record already exists in the database! !<BR>";
	}
	
	$text .= "<BR><BR>Click here to go back";
	
	$text .= "<FORM NAME= \"get_search\" ACTION=\"inside_search.pl\" method =\"POST\">
		  	 <INPUT TYPE=\"submit\" VALUE=\"back\"></FORM>";
	$text .= "<BR>\n";
	
	&to_html("error", $text);
	exit;
	
}#bad_format

##################################   page_error   ##########################################

sub page_error()
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

#######################################check_code################################

sub check_code ()
{
 	my ($code, $table)= @_;
	my @res= ();
	
	my $query = "SELECT code FROM mutant04 WHERE code = \"$code\"";
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
	
		
	$res = $sth->fetchrow_array;
	$sth->finish;
	$rv = $dbh->disconnect;
	return $res;
}

#######################################check_exists################################

sub check_exists ()
{
 	my ($code, $cross_to)= @_;
	my @res= ();
	
	  	my $query = "SELECT code FROM shared_mutants WHERE code = \"$code\" and cross_to= \"$cross_to\"";	

  
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
	
		
	$res = $sth->fetchrow_array;
	$sth->finish;
	$rv = $dbh->disconnect;
	return $res;
}
