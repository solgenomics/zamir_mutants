#!/usr/bin/perl

use db_link;
use CGI qw(:standard);
use CGI::Carp qw(fatalsToBrowser);
use DBI;
use DBD::mysql;


$FILENAME  = "inside_search.pl";

$DIR       = "/cgi-bin/";
$MAIN_URL  = "/cgi-bin/$FILENAME";

$HOME	=	"http://zamir.sgn.cornell.edu/mutants/2004/";
$graphics = "http://zamir.sgn.cornell.edu/mutants/graphics/mytomato.gif";


print "content-type: text/html\n\n 
<html>
<head>
	<title>Tomato mutant population Search </title>
</head>

<body BGCOLOR=\"#ffffcc\">";

print "<TABLE width=\"100%\" cellpading=\"10\" cellspacing =\"10\" border=\"0\">

<TR>
    <TD colspan =\"3\"><h1><center>Search and update the tomato mutant database</center></h1><BR></TD>
<TR><TD colspan=2 bgcolor=\"#cccccc\"></TD></TR>
</TR>
<TR>
	<TD><B><U>search by code:</U></B>";
	print "<FORM NAME= \"search_by_code\" ACTION=\"inside_search_res.pl\" method = \"get\">
	<INPUT TYPE=\"RADIO\" NAME=\"theRadio\" value=\"acc\">
	Select a mutant code:
	<SELECT onchange=\"search_by_code.theRadio[0].checked=true\;\"  NAME=\"code\">
	<OPTION></OPTION>";
	
	$search = "code_name";
	$table="shared_mutants";
	
	my @names = get_names($search, $table);
	my @sorted_names= sort { lc $a cmp lc $b } @names;
	foreach $val (@sorted_names){
		if ($val =~ /^[e|n|E|N]\d{4}m\d$/) {
    	   print "<OPTION VALUE=\"$val\">$val</OPTION>" ;
		}else{ 
			push (@misc, $val);
		}
   	}
	print "</SELECT><BR><B>Or</B><BR>
	<INPUT TYPE=\"RADIO\" NAME=\"theRadio\" value=\"misc\">
	Select an accession:
	<SELECT  onchange=\"search_by_code.theRadio[1].checked=true\;\" NAME=\"misc_code\">";
	print "<OPTION>$test</OPTION>";
	foreach $val (@misc){
    	print "<OPTION VALUE=\"$val\">$val</OPTION>" ;
		}
	print "</SELECT><BR>
	<INPUT TYPE=\"submit\" VALUE=\"submit\">
	<INPUT TYPE=\"reset\" VALUE=\"clear\">
	<input type=\"hidden\" name=\"menu\" value=\"search_by_code\">
	</FORM></TD>
</TR>
<TR>
	<TD><BR></TD>
</TR>
<TR>
	<TD><B><U>search by mutant name:</B></U>
	<FORM NAME= \"search_by_mutant_name\" ACTION=\"inside_search_res.pl\" method = \"get\">
	<SELECT NAME=\"mutant_name\">
	<OPTION>$test</OPTION>";
	
	$search = "mutant_name";
	$table="mutant04";
	@names = get_names($search, $table);
	@sorted_names= sort { lc $a cmp lc $b } @names;
	foreach $val (@sorted_names){
    	print "<OPTION VALUE=\"$val\">$val</OPTION>" ;
   	}
	print "</SELECT>
	<INPUT TYPE=\"submit\" VALUE=\"submit\">
	<INPUT TYPE=\"reset\" VALUE=\"clear\">
	<input type=\"hidden\" name=\"menu\" value=\"search_by_mutant_name\">
	</FORM></TD>
</TR>
<TR>
	<TD><BR></TD>
</TR>
<TR>
	<TD><B><U>Search by person:</B></U><BR>
	<FORM NAME= \"search_by_person\" ACTION=\"inside_search_res.pl\" method = \"get\">
	<SELECT NAME=\"person\">
	<OPTION>$test</OPTION>";
	
	$search = "person";
	$table= "shared_mutants";
	@people = get_names($search, $table);
	@sorted_people= sort { lc $a cmp lc $b } @people;
	foreach $val (@sorted_people){
    	print "<OPTION VALUE=\"$val\">$val</OPTION>" ;
   	}
	print "</SELECT>
	<INPUT TYPE=\"submit\" VALUE=\"submit\">
	<INPUT TYPE=\"reset\" VALUE=\"clear\">
	<input type=\"hidden\" name=\"menu\" value=\"search_by_person\">
	</FORM></TD>
</TR>
<TR><TD><BR></TD></TR>
<TR><TD colspan=2 bgcolor=\"#cccccc\"></TD></TR></TABLE>";

print "<TABLE>";
##########################insert############
print "<TR><TD colspan=2><B><U>Insert a new entry to the database: THIS OPTION WILL BE AVAILABLE SOON</B></U></TD></TR>
	<FORM NAME= \"insert\" ACTION=\"update_db.pl\" method = \"post\">
	<TR><TD>Your name:</TD><TD>
	<SELECT NAME=\"person\">
	<OPTION>$test</OPTION>";
	foreach $val (@sorted_people){
    	print "<OPTION VALUE=\"$val\">$val</OPTION>" ;
   	}
	print "</SELECT>
	</TD></TR>
	<TR><TD>Mutant code:</TD>
	<TD><INPUT TYPE= \"text\"  name=\"code\" size =\"7\" maxlength =\"7\"></TD></TR>
	<TR><TD>Cross to (optional):</TD><TD>

	<INPUT TYPE=\"RADIO\" NAME=\"Radio2\" value=\"code\">
	Select a mutant code:
	<INPUT TYPE= \"text\"  onfocus=\"insert.Radio2[0].checked=true\;\"  name=\"cross_code\" size =\"7\" maxlength =\"7\">
	<B><U>Or</U></B>
	<INPUT TYPE=\"RADIO\" NAME=\"Radio2\" value=\"acc\">
	Select an accession:
	<SELECT  onchange=\"insert.Radio2[1].checked=true\;\" NAME=\"cross_misc\">
	
	<OPTION>$test</OPTION>";
	foreach $val (@misc){
    	print "<OPTION VALUE=\"$val\">$val</OPTION>" ;
   	}
	
	print "</SELECT>";
	print "<TR><TD>Accession name (optional):</TD><TD><INPUT TYPE= \"text\" name=\"name\"></TD></TR>
	<TR><TD>Generation (optional):</TD><TD><SELECT NAME=\"generation\">
	<OPTION>
	<OPTION VALUE=F1>F1
	<OPTION VALUE=F2>F2
	<OPTION VALUE=F3>F3
	<OPTION VALUE=BC1>BC1
	<OPTION VALUE=BC2>BC2
	<OPTION VALUE=BC3>BC3
	<OPTION VALUE=BC4>BC4
	<OPTION VALUE=BC5>BC5
	</SELECT>
	</TD></TR>
	<TR><TD>Comments:</TD><TD><TEXTAREA rows=\"4\"  cols=\"20\" name=\"comments\"></TEXTAREA></TD></TR>
	<TR><TD>";
#	<INPUT TYPE=\"submit\" VALUE=\"submit\">
	print "<INPUT TYPE=\"reset\" VALUE=\"clear\"></TD></TR>
	<input type=\"hidden\" name=\"menu\" value=\"insert\">
	</FORM>";
	
print "</TABLE></BODY></HTML>";
	

#####################################   get_names   #####################################

sub get_names()
{
	my ($name, $table_name) = @_ ;
	my @res = ();
	my @codes = ();
	my $error;
	my $item;
	my ($query, $query_code)="";
	
	if ($name eq "mutant_name") {
   		$query = "SELECT allelic_to_gmt FROM $table_name WHERE allelic_to_gmt not like \"\"";
	}elsif ($name eq "person")  {
		 $query = "SELECT person FROM $table_name";	
	}elsif ($name eq "code_name")  {
		 $query = "SELECT cross_to FROM $table where cross_to!=\"\"";
		 $query_code= "SELECT code FROM $table_name";	
	     @codes=get_code_names($query_code);
	}elsif ($name eq "code") {
		   $query = "SELECT code from $table_name";
	}
	
	my $dbh = db_link::connect_db("naama","web_usr");
	#my $dbh = db_link::connect_db("naama","naama1");
	
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
	
	#foreach ($item = $sth->fetchrow_array) {
			
	while ($item = $sth->fetchrow_array) {
			if ($name eq "code") {
			   push(@res, $item); 
			}else {
			if (exist ($item, \@res) == 0)  {
				push(@res, $item); 
			}
		}
	}
	$sth->finish;
	$rv = $dbh->disconnect;
	foreach $code(@codes) {
			if (exist ($code, \@res) == 0)  {
				push(@res, $code); 
			}
	}
	
	return @res;
}#get_names

#######################################get_code_names################################

sub get_code_names ()
{
 	my ($query)= @_;
	my @res= ();
	
   	my $dbh = db_link::connect_db("naama","web_usr");
	#	my $dbh = db_link::connect_db("naama","naama1");
	
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
	@res = $sth->fetchrow_array;
	while($item = $sth->fetchrow_array) {
			if (exist ($item, \@res) == 0)  {
				push(@res, $item); 
			}
		}
	$sth->finish;
	$rv = $dbh->disconnect;
	return @res;
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