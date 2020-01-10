


package Shared;





use lib '/usr/lib/perl5/site_perl/5.005/i386-linux';


use CGI qw(:standard);
use CGI::Carp qw(fatalsToBrowser);

use strict;
use warnings;

use Html;



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
	
	$res[0]   = "Plant_Weight";
	$res[1]   = "Total_Yield";
	$res[2]   = "Bio_Mass";
	$res[3]   = "Brix_*_Yield";
	$res[4]   = "%_Red_Yield";
	$res[5]   = "Harvest_Index";
	$res[6]   = "Brix";
	$res[7]   = "Fruit_Weight";
	$res[8]   = "Fruit_Length";
	$res[9]   = "Fruit_Width";
	$res[10]  = "Length_/_Width";
	$res[11]  = "Seed_Weight";
	$res[12]  = "Pericarp";
	$res[13]  = "Internal_Color";
	$res[14]  = "External_Color";
	$res[15]  = "A_*";
	$res[16]  = "B_*";
	$res[17]  = "L_*";
	$res[18]  = "Lycopene";
	$res[19]  = "Carotene";
	$res[20]  = "Firmness";
	#$res[21]  = "AT";
	$res[21]  = "PH";
	#$res[23]  = "MS";
	$res[22]  = "Sucrose";
	$res[23]  = "Glucose";
	$res[24]  = "Fructose";
	$res[25]  = "Malic_acid";
	$res[26]  = "Citric_acid";
	$res[27]  = "Locule_Number";
	$res[28]  = "Fruit_Number";
	$res[29]  = "Shine";
	$res[30]  = "Veins";
	$res[31]  = "Shoulders";
	$res[32]  = "Placenta";
	$res[33]  = "Puffiness";

	return \@res;
}

###################################   is_new_trait   ####################################	


sub is_new_trait()
{
 	my $i;
	my $all_traits = &all_traits();
				
	shift;
	
	my ($trait) = @_;
	
	for ($i=0; $i<@{$all_traits}; $i++)
	{
	   if ($trait eq $all_traits->[$i])
		 {
		 		if ($i >= 20)
				{
				 	 return 1;
				}
				
				return 0;
		 }
	}
	
	return "undefined";

}


###################################   all_traits_details   ####################################	
	
sub all_traits_details()
{
	my @res = ();
	my @temp = ();
	
	$res[0]   = ["Plant_Weight", "PW", 1, 1];
	$res[1]   = ["Total_Yield", "TY", 1, 1];
	$res[2]   = ["Bio_Mass", "BM", 1, 1];
	$res[3]   = ["Brix_*_Yield", "BXY", 1, 1];
	$res[4]   = ["%_Red_Yield", "RED", 1, 1];
	$res[5]   = ["Harvest_Index", "HI", 1, 1];
	$res[6]   = ["Brix", "BX", 1, 1];
	$res[7]   = ["Fruit_Weight", "FW", 2, 1];
	$res[8]   = ["Fruit_Length", "LEN", 2, 1];
	$res[9]   = ["Fruit_Width", "WID", 2, 1];
	$res[10]  = ["Length_/_Width", "LEN_WID", 2, 1];
	$res[11]  = ["Seed_Weight", "SW", 2, 0];
	$res[12]  = ["Pericarp", "PER", 2, 1];
	$res[13]  = ["Internal_Color", "IC", 2, 1];
	$res[14]  = ["External_Color", "EC", 2, 1];
	$res[15]  = ["A_*", "A", 2, 0];
	$res[16]  = ["B_*", "B", 2, 0];
	$res[17]  = ["L_*", "L", 2, 0];
	$res[18]  = ["Lycopene", "LYC", 3, 0];
	$res[19]  = ["Carotene", "CAR", 3, 0];
	$res[20]  = ["Firmness", "FIRM", 2, 0];
	$res[21]  = ["AT", "AT", 2, 0];
	$res[22]  = ["PH", "PH", 3, 0];
	$res[23]  = ["MS", "MS", 2, 0];
	$res[24]  = ["Sucrose", "SUC", 3, 0];
	$res[25]  = ["Glucose", "GLU", 3, 0];
	$res[26]  = ["Fructose", "FRU", 3, 0];
	$res[27]  = ["Malic_acid", "MAA", 3, 0];
	$res[28]  = ["Citric_acid", "CIA", 3, 0];
	$res[29]  = ["Locule_Number", "LON", 2, 0];
	$res[30]  = ["Fruit_Number", "FN", 1, 0];
	$res[31]  = ["Shine", "SHN", 2, 0];
	$res[32]  = ["Veins", "VEIN", 2, 0];
	$res[33]  = ["Shoulders", "SHLD", 2, 0];
	$res[34]  = ["Placenta", "PLCT", 2, 0];
	$res[35]  = ["Puffiness", "PUFF", 2, 0];
	
	
	

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
	
	shift;
	
	my ($trait, $h) = @_;
	
	#$h->out("  transfer $trait ...  ") if ($h);
	
	
	my $ref_ar = all_traits_details();
	my @ar = @{$ref_ar};
	
	
	foreach my $i (@ar)
	{
	 	 if ($trait eq $i->[0])
		 {
		 		return $i->[1];
		 }	
	}	
		
	return "my_undef";	
	
}#end of translate_tr()










######################################   b_translate_tr   ##############################


sub b_translate_tr()
{
		
	shift;
	
	my ($trait) = @_;
	
	
	
	my $ref_ar = all_traits_details();
	my @ar = @{$ref_ar};
	
	
	
	foreach my $i (@ar)
	{
	 	 if ($trait eq $i->[1])
		 {
		 		return $i->[0];
		 }	
	}	
	
	return "my_undef";
	
	
}#end of translate_tr()



######################################   b_translate_ex   ##############################



sub b_translate_ex()
{
	my $experiment;
	
	shift;
	
	($experiment) = @_;
	
	if ($experiment eq "1993")
	{
		return "Akko_-_1993_-_Wet";
	}
	if ($experiment eq "2000-dry")
	{
		return "Akko_-_2000_-_Dry";
	}
	if ($experiment eq "2000-wet")
	{
		return "Akko_-_2000_-_Wet";
	}
	if ($experiment eq "france-2000" ||  $experiment eq "2000-france")
	{
		return "France_-_2000_-_plots_-_Wet";
	}
	if ($experiment eq "2001-wet")
	{
		return "Akko_-_2001_-_Wet";
	}
	if ($experiment eq "2002-wet")
	{
		return "Akko_-_2002_-_Wet";
	}
	if ($experiment eq "combined")
	{
		return "Combined";
	}
}

####################################   trait_type   #############################

sub trait_type()
{
 	my ($trait);
	
	shift;
	
	($trait) = @_;

	my $ref_ar = all_traits_details();
	my @ar = @{$ref_ar};
	
	
	foreach my $i (@ar)
	{
	 	 if ($trait eq $i->[0])
		 {
		 		return $i->[2];
		 }	
	}	
		
	return 0;	
}

##########################################   max   ##################################

sub max()
{
 	my @values;
	my $max = 0;
	
	shift;
	
	@values = @_;
	foreach my $i (@values)
	{
	 		if ($i > $max)
			{
			 	 $max  = $i;
			}
	}
	
	return $max;
}

######################################   get_ex_by_tr   ########################################

sub get_ex_by_tr()
{
  my $trait;
		
	shift;
	
	($trait) = @_;
	
	my $ref_ar = all_traits_details();
	my @ar = @{$ref_ar};
	
	
	foreach my $i (@ar)
	{
	 	 if ($trait eq $i->[1])
		 {
		 		return $i->[3];
		 }	
	}	
	return 0;

}



############################
return 1;    #return 1   !!
