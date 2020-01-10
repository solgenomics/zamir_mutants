#!/usr/bin/perl

use zamir::db_link;

my $r = Apache->request();
my %params = $r->content;

#SGN_template::print_blast_header("SGN Tomato Mutation Database Search Result");

 
print "content-type: text/html\n\n";
print "<HTML><HEAD><TITLE>Search SGN Tomato Mutation Database</TITLE></HEAD><BODY BGCOLOR=\"#FFFFFF\">";

&execute_search();
print "</BODY></HTML>";


#SGN_template::print_footer();

sub execute_search {

    print "<TABLE CELLSPACING=5 CELLPADDING=0 BORDER=0>";

  opendir THUMBNAIL,"/soldb/website/sgn/html/mutation_images/thumbnails"
    or print "Can't open THUMBNAIL directory. $!<br>\n";
  opendir HALFSIZE,"/soldb/website/sgn/html/mutation_images/half_size"
    or print "Can't open HALFSIZE directory. $!<br>\n";

  print THUMBNAIL;
  rewinddir THUMBNAIL;
  @thumbnails = readdir(THUMBNAIL);
  @halfsize = readdir HALFSIZE;

  closedir THUMBNAIL;
  closedir HALFSIZE;

  my $dbh = db_link::connect_db("naama","web_usr");

  my $category_clause;
  if ($params{"category"} ne "all") {
    $category_clause = "AND m.category=\"$params{category}\"";
  } else {
    $category_clause = "";
  }
  
my $mutagen_clause;
  if ($params{"mutagen"} ne "all") {
    $mutagen_clause = "AND m.fam_id like \"$params{mutagen}%\"";
  } else {
    $mutagen_clause = "";
  }
  
  my ($code,$details,$habit,$leaves,$flower,$stem,$fruit,$similar_to,$details,$comments,$category);
  my $stm;
  if ($params{"search"} eq "search_family") {
    $stm = "SELECT m.code, m.details, m.habit, m.leaves, m.flowers, m.stems, m.fruit, m.similar_to, m.details, m.comments, c.description FROM mutations as m, category_key as c WHERE fam_id = \"$params{family_id}\" AND c.category = m.category $category_clause";
  } elsif ($params{"search"} eq "search_keyword") {
    $stm = "SELECT m.code, m.details, m.habit, m.leaves, m.flowers, m.stems, m.fruit, m.similar_to, m.details, m.comments, c.description FROM mutations as m, category_key as c WHERE details like \"%$params{key}%\" AND c.category = m.category $category_clause $mutagen_clause";
  } else {
    die "Unknown search command: \"$params{search}\"\n";
  }

  my $sth = $dbh->prepare($stm)
    || die "Can't prepare statement: $DBI::errstr";
  my $rv = $sth->execute
    || die "Can't execute statement: $DBI::errstr";
  my $rc = $sth->bind_columns(\$code,\$details,\$habit,\$leaves,\$stem,\$flower,\$fruit,\$similar_to,\$details,\$comments,\$category);

#  print "Executing Search.... $stm<br>\n";

  while($sth->fetch) {
    $thumbnail_images = "<table cellspacing=5 border=0><tr>";
    foreach $thumbnail ( @thumbnails ) {
	if ( $thumbnail =~ m/$code.*\.jpg/ ) {
	    $thumbnail_images .= "<td><a href=/mutation_images/half_size/$thumbnail TARGET=\"_blanc\"><img src=/mutation_images/thumbnails/$thumbnail></a></td>";
	}
    }
    $thumbnail_images .= "</tr></table>";

    print <<CONTENT
<tr><td>
<TR><TD>code</TD><TD>$code</TD><TD rowspan="6">$thumbnail_images</TD></TR>
CONTENT
;
    foreach $x ( habit, leaves, stem, flower, fruit ) {
      print "<TR><TD>$x</TD>";
      eval "\$value = \$$x";
      if ($value == "1") {
	print "<td>Yes</td></tr>";
      } else {
	print "<td>No</td></tr>";
      }
    }
    print "<TR><TD>Details</TD><TD>$details</TD></TR>\n";
    print "<TR><TD>Category</TD><TD>$category</TD></TR>\n";

    if ($similar_to) {
      print "<TR><TD>Similar to (<A HREF=\"http://tgrc.ucdavis.edu/\">TGRC gene</A>)&nbsp&nbsp<A HREF=\"http://tgrc.ucdavis.edu/data/acc/GenDetail.CFM?GENES.Gene=$similar_to\"TARGET=\"_blank\">$similar_to</TD></TR>";
    }
    print "<tr><td colspan=3><hr></td></tr>";
    print "</td></tr>";
  }

  print "</table>";
  $dbh->disconnect();
}

