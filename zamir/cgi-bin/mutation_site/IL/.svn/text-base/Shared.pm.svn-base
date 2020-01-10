


package Shared;





use lib '/usr/lib/perl5/site_perl/5.005/i386-linux';


use CGI qw(:standard);
use CGI::Carp qw(fatalsToBrowser);

use strict;
use warnings;



#########################################   new   ######################################


	sub new {
    	my $self  = {};
        
		bless($self);      
		    
        return $self;
   	}
	
	
###################################   all_traits   ####################################	
	
sub all_traits()
{
	my @res = ();
	
	$res[0]  = "Plant_Weight";
	$res[1]  = "Total_Yield";
	$res[2]  = "Bio_Mass";
	$res[3]  = "Brix_*_Yield";
	$res[4]  = "%_Red_Yield";
	$res[5]  = "Harvest_Index";
	$res[6]  = "Brix";
	$res[7]  = "Fruit_Weight";
#	res[8]  = "Fruit_Length";
#	res[9]  = "Fruit_Width";
#	res[10]  = "Length_/_Width";
#	res[11]  = "Seed_Weight";
#	res[12]  = "Internal_Color";
#	res[13]  = "External_Color";
#	res[14]  = "A_*";
#	res[15]  = "B_*";
#	res[16]  = "L_*";
#	res[17]  = "Lycopene";
#	res[18]  = "Carotene";


	return \@res;


}
		

#########################################   translate   ################################	
	
sub translate()
{
	my $st;
	my @arr;
	my $res = "";
	my $i;
	
	
	shift;
	
	($st) = @_;
	
	@arr = split(/_/, $st);
	
	
	
	for ($i=0; $i<@arr; $i++)
	{
		$res .=  $arr[$i] . " ";
	
	}

	return $res;

}



######################################   f_translate_tr   ##############################


sub f_translate_tr()
{
	my $trait;
	
	shift;
	
	($trait) = @_;
	
	if ($trait eq "Plant_Weight")
	{
		return "PW";
	}
	if ($trait eq "Total_Yield")
	{
		return "TY";
	}
	if ($trait eq "Bio_Mass")
	{
		return "BM";
	}

	if ($trait eq "%_Red_Yield")
	{
		return "RED";
	}
	
	if ($trait eq "Harvest_Index")
	{
		return "HI";
	}
	
	if ($trait eq "Brix_Yield")
	{
		return "BXY";
	}
	
	if ($trait eq "Brix")
	{
		return "BX";
	}
	
	if ($trait eq "Fruit_Weight")
	{
		return "FW";
	}
	if ($trait eq "Fruit_Length")
	{
		return "IC";
	}
	if ($trait eq "Fruit_Width")
	{
		return "FW";
	}
	if ($trait eq "Length_/_Width")
	{
		return "FW";
	}
	if ($trait eq "Internal_Color")
	{
		return "FW";
	}
	if ($trait eq "Seed_Weight")
	{
		return "FW";
	}
	if ($trait eq "A_*")
	{
		return "FW";
	}
	if ($trait eq "B_*")
	{
		return "FW";
	}
	if ($trait eq "L_*")
	{
		return "FW";
	}
	if ($trait eq "Lycopene")
	{
		return "FW";
	}
	if ($trait eq "Carotene")
	{
		return "FW";
	}
	
	
	return "my_undefined";
	
	
}#end of translate_tr()





return 1;
