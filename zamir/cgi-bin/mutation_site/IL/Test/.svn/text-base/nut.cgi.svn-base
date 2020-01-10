#!/usr/bin/perl



use Getopt::Long;

use CGI qw(:standard);
use CGI::Carp qw(fatalsToBrowser);

use strict;
use warnings;

use Html;
#use JS;


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

my ($tr, $ex, $type);


my $h = Html->new();

my @array;

#my $j = JS->new();


&display();


sub display()
{
	my $text;
	my $c;
	

		
	$c = convert_src("test.txt");
	
	#$text .= $h->select_item("s1", @array);
	
	#$text .= "array is @array";
	
	$text .= "count is $c<BR>";
	
	for (my $i=0; $i<@array; $i++)
	{
		$text .= $array[$i] . "--------------------- <BR>";
	}
	
	
		
			
	$h->to_html("test", \$c);

}






sub convert_src()
{
		my $file_name = shift;
		
		my $text = "";
		
		
		open (JS, $file_name) ||  die "cannot open file $file_name: $!";
		
		my @lines = <JS>;
		#chomp (@lines);
		
		close (JS);
		
		my $il;
		my $i;
		my $count;
		$count = 0;
				
		#foreach my $line (@lines)
		#{
		for ($i=0; $i<@lines; $i++)
		{
			$text .= $lines[$i];
			#$text = "skgdjklkfdsvsdIL";
			
			#($il) = $text =~ /(IL[H?]\d\-\d)/;
			
			if ($text =~ /IL/)
			{
			
			}
			
			#if ($1)
			#{	
			#	$count ++;
			#	push(@array, $1);
			#}
			
			$il = 1;
			
		
		}
		
		return $text;

	
	
}





sub translate()
{
	my ($st) = @_;
	my @arr;
	my $res = "";
	
	@arr = split(/_/, $st);
	
	
	for (my $i=0; $i<@arr; $i++)
	{
		$res .=  $arr[$i] . " ";
		
	}
	
	return $res;

}
