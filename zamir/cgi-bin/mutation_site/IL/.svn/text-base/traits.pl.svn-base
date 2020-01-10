#!/usr/bin/perl



use zamir::db_link;
use CGI qw(:standard);
use CGI::Carp qw(fatalsToBrowser);
use DBI;
use DBD::mysql;

use Html;
use Shared;

#use strict;
#use warnings;


main();

####################################   MAIN   ###############################################


sub main()
{

	my $h = Html->new();
	my $s = Shared->new();
	
	my $URL = "/cgi-bin/mutation_site/IL/traits.pl";

	print "content-type: text/html\n\n";



	my $menu = param("menu");



	if ($menu eq "results")
	{
		results($h, $s, $URL);
	}
	else
	{
		&display_search($h, $s, $URL);
	}	
	
}



	
	
	
	




###################################   display_search   #######################################

sub display_search()
{
	my ($h, $s, $URL) = @_;
	my $text = "";
	my $t1 = "";
	my $t2 = "";
	my $temp = "";
	
	
	my $traits = $s->all_traits();
	my @traits_arr = @{$traits};
	my @trend = ("increase", "decrease");
	
	
	
	$text .= $h->center_stat($h->h1_stat("Pleiotrophy - search engine")) . "<HR>";
	
	
	$text  .= $h->under_line_stat($h->h3_stat("Search genotypes by traits"));
	$text .= "<BR>";
#	my $sss = $s->translate("fff");
#	$text .= "<BR> arr[0] is " . $sss . "<BR>";
	
	foreach my $i (@traits_arr)
	{
	
		$t1 = $h->checkbox_item("c~$i", 0) . "  " . $h->bold_stat($s->translate($i)) . " ";
		$t2 = $h->select_item("s~$i", @trend);
		
		$temp .= $h->r_element($h->data_element($t1) . $h->data_element($t2));
	}
	
	$text .= $h->table_element($temp);
	
	$text  .= $h->submit_item("Search") . $h->reset_item("Clear");	
	
	$text  = $h->form($text,"results", $URL);
	
	
	$h->to_html("search", \$text);
	
	
	
}	



###################################   results   #######################################


sub results()
{
	my ($h, $s, $URL) = @_;
	my $i;
	
	my $text = "";
	
	my $traits = $s->all_traits();
	my @traits_arr = @{$traits};
	
	my @reauest;
	
	foreach $i (@traits_arr)						#get user request
	{
		if (param("c~$i") eq "on")
		{
			if (param("s~$i") eq "increase")
			{
				push(@request, [$s->f_translate_tr($i), 1]);			
			}
			else
			{
				push(@request, [$i, 0]);			
			}		
		}	
	}
	
	foreach $i (@request)
	{
		$text .= $i->[0] . "  " . $i->[1] . "<BR>";
	}
	
	
	
	
	$h->to_html("results", \$text);

	$text = "";

}

