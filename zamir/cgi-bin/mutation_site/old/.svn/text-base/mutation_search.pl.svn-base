#!/usr/bin/perl

use zamir::db_link;

print "content-type: text/html\n\n";
print "<HTML><HEAD><TITLE>Search SGN Tomato Mutation Database</TITLE></HEAD><BODY BGCOLOR=\"#FFFFFF\">";
print "<TABLE><TR><TD>";
&print_text();
print "</TD></TR></TABLE></BODY></HTML>";

sub print_text {

print <<MAIN_TEXT
<br>
<B>
<FORM action= "mutation_search_result.pl" method="post">
<INPUT TYPE="RADIO" NAME="search" VALUE="search_family" selected>
<FONT COLOR="#660099" size=+1>Search according to family ID:</FONT>
<BR><BR>
Insert a family ID: <INPUT NAME="family_id" TYPE="TEXT" VALUE="">
<BR>
<BR>
<BR>
<BR>

<INPUT TYPE="RADIO" NAME="search" VALUE="search_keyword" checked>
<FONT COLOR="#660099" size=+1>Search according to a keyword:</FONT>
<BR><BR>
Type a keyword: <INPUT NAME="key" TYPE="TEXT" VALUE=""></INPUT><BR><BR>
Limit the search to a specific category (optional):<BR>
<SELECT NAME="category">
	<OPTION value="all">All Categories
MAIN_TEXT
;
# Open database connection: database_name, hostname, user, passwd
my $dbh = db_link::connect_db("naama","web_usr");

my $stm = "select category, description from category_key";
my $sth = $dbh->prepare($stm)
  || die "Can't prepare statement: $DBI::errstr";
my $rv = $sth->execute
  || die "Can't execute statement: $DBI::errstr";
my $rc = $sth->bind_columns(\$category,\$description);

while($sth->fetch) {
  print "<OPTION value=\"$category\">$description\n";
}

print <<CONTENT
</SELECT><BR><BR>
<BR>

Limit the search to a mutagen:<br><SELECT NAME="mutagen">
	<OPTION value="all">All mutagens
	<OPTION value="n">fast neutron
	<OPTION value="e">EMS
</SELECT>
<br>
<br>
<INPUT TYPE="SUBMIT"><INPUT TYPE="RESET">

</FORM>
CONTENT
;
$dbh->disconnect();
}

