#!/usr/bin/perl



#use lib '/usr/lib/perl5/site_perl/5.005/i386-linux';

use zamir::db_link;

use CGI qw(:standard);
use CGI::Carp qw(fatalsToBrowser);
#use DBI;
#use DBD::mysql;

use strict;
use warnings;

use Html;
use JS;


my ($MAIN_URL, $FILENAME, $DIR, $DAVIS_DIR, $PIC_DIR, $PIC_URL, $IL_NUM, $MAP_URL);
my $menu;

$FILENAME  = "test.cgi";
$IL_NUM    =  76;

$DIR       = "/cgi-bin/mutation_site/";
$PIC_DIR = "/soldb/website/sgn/html/mutation_images/IL/";
$PIC_URL = "mutation_images/IL/";
$MAP_URL = "http://www.sgn.cornell.edu/maps/pennellii_il/";

$MAIN_URL  = "/cgi-bin/mutation_site/IL/$FILENAME";
$DAVIS_DIR = "http://tgrc.ucdavis.edu/Data/Acc/AccDetail.CFM?ACCESSIONS.AccessionNum=";




####################################   MAIN   ###############################################

print "content-type: text/html\n\n";


#my $page = param("menu");


my $h = Html->new();

my $j = JS->new();


&display();


sub display()
{
	my $text;
		
	$text .= $j->convert_src("home.htm");
		
	
	print $text;		
	#$h->to_html("test", \$text);

}

