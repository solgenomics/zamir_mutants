#!/usr/bin/perl -w
#   ################################################!c:\Perl\bin\perl.exe
#   ################################### ############!/usr/bin/perl -w

use zamir::db_link;
use CGI qw(:standard);
use CGI::Carp qw(fatalsToBrowser);
#use DBI;
#use DBD::mysql;

use Html;
use Shared;

use strict;
use warnings;


&main();

####################################   MAIN   ###############################################


sub main()
{

	my $h = Html->new();
	my $s = Shared->new();
	
	my $URL = "/cgi-bin/mutation_site/IL/Qtl/traits.pl";
        #my $URL = "http://127.0.0.1/cgi-bin/traits.pl";
	
	
	print "content-type: text/html\n\n";



	my $menu = "a";
	$menu    = param("menu");

	

	if ($menu eq "results")
	{
			&results($h, $s, $URL);		
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
	my $temp1 = "";
	my ($i, $j);
	
	
	my $traits = $s->all_traits();
	my @traits_arr = @{$traits};
	my @trend = ("increase", "decrease", "increase or decrease");
	
	
	
	
	$text .= $h->center_stat($h->h1_stat("Search genotypes by traits"));
	
	
	
	$text .= "<BR><BR>";

	my @yld = ();
	my @mor = ();
	my @bio = ();
	
	foreach $i (@traits_arr)
	{
	 	$j = $s->f_translate_tr($i);		
			 
		if ($s->is_new_trait($i) == 1)	
		{ 
			 $t1 = $h->checkbox_item("c_$j", 0) . "  " . $h->write($s->translate($i), 100, "red") . " ";
			 
		}
		else
		{
		 		$t1 = $h->checkbox_item("c_$j", 0) . "  " . $h->write($s->translate($i), 100, "black") . " ";
				
		}		 
		
		$h->set_event("document.results.c_$j.checked=true;");
		
		$t2 = $h->select_item("s_$j", @trend);
		
		$h->clear_event();
		
		
		if ($s->trait_type($i) == 1)
		{
		 	 push(@yld, $h->data_element($t1));
			 push(@yld, $h->data_element($t2));
		}
		if ($s->trait_type($i) == 2)
		{
		 	 push(@mor, $h->data_element($t1));
			 push(@mor, $h->data_element($t2));
		}
		if ($s->trait_type($i) == 3)
		{
		 	 push(@bio, $h->data_element($t1));
			 push(@bio, $h->data_element($t2));
		}
	}
	
	my $max_len = $s->max($#yld+1, $#mor+1, $#bio+1);
	$max_len = $max_len/2;
	
	
	my $type1 = $h->center_stat($h->write("Yield", 115, "blue"));
	my $type2 = $h->center_stat($h->write("Fruit Morphology", 115, "blue"));
	my $type3 = $h->center_stat($h->write("Fruit Biochemistry", 115, "blue"));
	
	$temp1 .= $h->r_element($h->data_element($type1, "", "", 3) . $h->data_element($type2, "", "", 3) . $h->data_element($type3, "", "", 3));
	
	for ($i=0; $i<$max_len; $i++)
	{
	 		
	 		if (2*$i + 1 < @yld)
			{
				 	$temp .= $yld[2*$i] . $yld[2*$i+1] . $h->data_element("");
			} 
			else
			{
			 		$temp .= $h->data_element("") . $h->data_element("") . $h->data_element("");
			}		
			
			if (2*$i + 1 < @mor)
			{
			 	 			 
				 	$temp .= $mor[2*$i] . $mor[2*$i+1] . $h->data_element("");
					
			} 
			else
			{
			 		$temp .= $h->data_element("") . $h->data_element("") . $h->data_element("");
					
			}		
			if (2*$i + 1 < @bio)
			{
				 	$temp .= $bio[2*$i] . $bio[2*$i+1];
			} 
			else
			{
			 		$temp .= $h->data_element("") . $h->data_element("");
			}		
			
			$temp1 .= $h->r_element($temp);
			$temp = "";
	}
	
	
	
	$text .= $h->table_element($temp1, "0", 5);
	
	$text .= $h->write("<br>(red traits are not included in the statistical analysis)<br>", 100, "red");
	
	$text  .= $h->submit_item("Search") . $h->reset_item("Clear");
	$text .= "<BR><BR>";
	$text .= $h->button_item("Front page", "location='Qtl/Html/home.htm'");
		
	$text  = $h->form($text,"results", $URL);
	
	
	
	$h->to_html("search", \$text);
	
	
	
}	



###################################   results   #######################################

sub results()
{


	my ($h, $s, $URL) = @_;
	my ($i, $j);
	
	
	
	my $text = "";
	my $tempo = "";
	
	my $traits = $s->all_traits();
	my @traits_arr = @{$traits};
	
	my @request = ();
	my @struct;
	my @ans;
	my ($ref_ans, $ref_struct);
	my $length;
	
	
	
	
		
	foreach $i (@traits_arr)						#get user request
	{
	  
	  $j = $s->f_translate_tr($i, $h);
				
		
		
		
		if (param("c_$j") eq "on")
		{
		  
			if (param("s_$j") eq "increase")
			{
				push(@request, [$s->f_translate_tr($i), 1]);		
				
			}
			else
			{
			 	if (param("s_$j") eq "decrease")
				{
				 	 push(@request, [$s->f_translate_tr($i), 0]);
					 
				}
				else
				{
				 	push(@request, [$s->f_translate_tr($i), 2]);
				}			
			}		
			
		}	
		
		
	}
	#push(@request, ["BX", 1]);
	
	if (!(@request))
	{
	 	 
	 	 $text .=  $h->write("you didnt specify a trait !<BR><BR>", 175, "blue");
                 $text .= $h->button_item("Back to previous page", "location='/cgi-bin/mutation_site/IL/Qtl/traits.pl'");
		 $text .= $h->button_item("Back to front page", "location='Qtl/Html/home.htm'");

		 $h->to_html("results", \$text);
		 return;
	}
	
	
	
	
	my @init = ();
	my @rest = @request;
	
	shift(@rest);
	push(@init, $request[0]);
	
	
	
	$ref_ans = &get_genotype($h, [@init]);
	
	
	
	
	$ref_struct = &organize_data($h, $ref_ans);
	
	
	
	
	&exclude($h, $ref_struct, \@rest);
	@struct     = @{$ref_struct};
	
	
	
	
	#foreach $i (@struct)
	#{
	#	$text .= &print_entry($h, $i);
	#	$text .= "<HR>";
	#}
	#$h->to_html("res", \$text);
	#exit;
	
	$length     = &get_length($h, $ref_struct);
	my $act_length = @{$ref_struct};
	
	
	
	#$text .= $h->script_stat("", "Qtl/Html/functions.js");
	
	
	$text .= $h->center_stat($h->write("Search results", 250, "brown"));
	$text .= "<BR>";	
	
	
	$text .= $h->write("You searched for genotypes which show :<BR><BR>", 120, "blue");
	foreach $i (@request)
	{
		if ($i->[1] == 1)
		{
			$text .= $h->write("Significant " . $h->write("increase", 120, "brown") . " in " . $h->write($s->translate($s->b_translate_tr($i->[0])), 120, "brown"), 120, "blue");
		}
		else
		{
		 	if ($i->[1] == 0)
			{
			 	 $text .= $h->write("Significant " . $h->write("decrease", 120, "brown") . " in " . $h->write($s->translate($s->b_translate_tr($i->[0])), 120, "brown"), 120, "blue");
			}
			else
			{
			 	 $text .= $h->write("Significant " . $h->write("increase or decrease", 120, "brown") . " in " . $h->write($s->translate($s->b_translate_tr($i->[0])), 120, "brown"), 120, "blue");
			}
		}
		$text .= "<BR>";
	}
	$text .= "<BR>";
	$text .= $h->button_item("Back to previous page", "location='/cgi-bin/mutation_site/IL/Qtl/traits.pl'");
	$text .= $h->button_item("Back to front page", "location='Qtl/Html/home.htm'");
	$text .= "<BR><BR>";
	$text .= $h->write("$length genotypes found !", 150, "brown");
	$text .= "<BR><HR><BR>";
	my $c = 1;
	my $t="";
	
	
		
	for ($i=0; $i<$act_length; $i++)
	{
	 	$t = $struct[$i]->{'genotype'};
		
	 	if ($t)
		{
		 	 $tempo .= $h->r_element($h->data_element(&format_il($h, $s, $struct[$i], \@request, $c)));
			 $c++;
		}
	}
		
	$text .= $h->table_element($tempo);
	
	$h->to_html("results", \$text);

}

#######################################   get_length   ####################################

sub get_length()
{
 		my ($h, $ref_struct) = @_;
		my $i;
		my $c = 0;
		my $t = "";
				
		for ($i=0; $i<@{$ref_struct}; $i++)
		{		 		
				$t = $ref_struct->[$i]->{'genotype'};
				
				if ($t)
				{
				 	 $c++;
					 
				}
		}
		
		
		
		return $c;

}


#######################################   exclude   ####################################


sub exclude()
{
 		my ($h, $struct_ref, $request) = @_;
		my @data;
		my ($i, $j);
		
		
		
FIRST :		
		foreach $i (@{$struct_ref})
		{		 		
		 		@data = @{$i->{'data'}};				
				
ENTRY:	foreach $j (@{$request})
				{
				 		
				 		if (&check_condition($h, \@data, $j) == 1)
						{						   
						 	 next ENTRY;
						}
						else
						{						   
						   $i->{'genotype'} = "";
						   next FIRST;
						}
				}
		}
		
		

}

#######################################   check_condition   ####################################

sub check_condition()
{
 		my ($h, $data_ref, $req) = @_;
		my $i;
		
		my $trait = $req->[0];
		my $sig   = $req->[1];		
		
		foreach $i (@{$data_ref})
		{
		 		if ($sig == 1  &&  $i->{$trait} > 0  &&  $i->{$trait . "_sig"} > 0)
				{				   
				 	 return 1;
				}
				if ($sig == 0  &&  $i->{$trait} < 0  &&  $i->{$trait . "_sig"} > 0)
				{				   
				 	 return 1;
				}
				if ($sig == 2  &&  $i->{$trait . "_sig"} > 0)
				{				  
				 	 return 1;
				}
				
		}	
		
		return 0;
		
		
		

}



#######################################   format_il   ####################################

sub format_il()
{
	my $IL_CARD = "/cgi-bin/mutation_site/IL/qtl.cgi?menu=il_card&il=";

	my ($h, $s, $hash_ref, $request, $num) = @_;
	my ($length, $req_length, $experiment, $m_experiment, $i, $j);
	my ($genotype, $gen_temp, $matches, $trait, $u_trait, $m_trait, $sig, $value, $color, $chr);
	my $text  = "";
	my $tempo = "";
	my $t1    = "";
	my $t2    = "";
	my (@id, @data);	
	
	
	
	$req_length = @{$request};	
	
	$genotype = $hash_ref->{'genotype'};
	$matches  = $hash_ref->{'length'};
	@id = @{$hash_ref->{'id'}};
	@data = @{$hash_ref->{'data'}};
	
	
	
	if ($genotype =~ /(.*)H(.*)/)
	{
		$gen_temp = "$1$2";
	}
	else
	{
		$gen_temp = $genotype;
	}
	$chr = $gen_temp =~/IL(\d+)\-/;
	
	$t1 .= $h->write($num.")  ". $h->ac_stat("$IL_CARD$gen_temp", $genotype), 150, "brown");
	$t1 .= $h->ak_stat("Qtl/Html/experiment_per_trait.htm?page_type=1&tr=undef&ex=Global&ch=$chr&il=$gen_temp", "Global experiment");
	#$t1 .= $h->button_item("Global experiment", "window.open('Qtl/Html/experiment_per_trait.htm?page_type=1&tr=undef&ex=Global&ch=$chr&il=$gen_temp')");

	$t1 = $h->data_element($t1, "", "", 6); 													 	 		 							 				
	
	my $first = "";
	my $count1 = 0;
	my $count2 = 0;
	
	
	foreach $i (@data)        #foreach experiment
	{
		$experiment = $i->{'experiment'};
		#$chr        = $i->{'chr'};
		$m_experiment = $s->b_translate_ex($experiment);
		
		
		
		$tempo .= $h->write($h->ac_stat("Qtl/experiment_card.htm?page_type=1&experiment=" . $s->b_translate_ex($experiment), $experiment), 120, "blue") . "<BR><BR>";
		
		
		for ($j=0; $j<$req_length; $j++)        #foreach trait request
		{		
		 	$trait = $request->[$j]->[0];		
			$m_trait = $s->b_translate_tr($trait);			
			$u_trait = $s->translate($m_trait);			
			$sig   = $i->{$trait . "_sig"};			
			
		 	if ($count1 < $req_length)
			{
			 	 if ($s->get_ex_by_tr($trait) == 1)
				 {
			 	 	#$first .= $h->button_item("$u_trait - all experiments", "window.open('Qtl/Html/trait_per_experiments.htm?page_type=1&tr=$m_trait&ex=undef&ch=$chr&il=$gen_temp')") . "<BR>";
					$first .= $h->ak_stat("Qtl/Html/trait_per_experiments.htm?page_type=1&tr=$m_trait&ex=undef&ch=$chr&il=$gen_temp", "$u_trait - all experiments") . "<br>";
				 }
				 else
				 {
				 	#$first .= $h->write("$u_trait measured only in 1 experiment", 100, "black");
				 }
				 $count1++;
			}			
			
			$value = $i->{$trait};
			if ($value)
			{
				if ($value > 0)
				{
					$color = "red";
				}
				else
				{
					$color = "blue";
				}
				if ($sig < 0)
				{
					$color = "black";
				}
				$tempo .= $h->bold_stat($u_trait . " : " . $h->write(int($value)."%",100,$color) . "<BR>");
			}
			else
			{
				$tempo .= $h->bold_stat($u_trait . " : " . "N.T" . "<BR>");
			}
		}
		
		$tempo .= $h->ak_stat("Qtl/Html/experiment_per_trait.htm?page_type=1&tr=undef&ex=$m_experiment&ch=$chr&il=$gen_temp", "all traits in this experiment");
		#$tempo .= $h->button_item("all traits in this experiment", "window.open('Qtl/Html/experiment_per_trait.htm?page_type=1&tr=undef&ex=$m_experiment&ch=$chr&il=$gen_temp')");
		$tempo  = $h->form($tempo, "fff", "");
		
		if ($count2 == 0)
		{
		 	 #$first .= $h->button_item("Global experiment", "window.open('Qtl/Html/experiment_per_trait.htm?page_type=1&tr=undef&ex=Global&ch=$chr&il=$gen_temp')");

		 	 $t2 .= $h->data_element($first) . $h->data_element($tempo);
			 $count2 = 1;
		}
		else
		{
		 	 $t2 .= $h->data_element($tempo);
		}
		
		$tempo = "";
		
	}
	
	$t2 = $h->r_element($t2);
	$text .= $h->table_element("$t1$t2",3, 0);	
	
	return $text;

}



########################################   organize_data   ################################

sub organize_data()
{
	my ($h, $results) = @_;
	my $i;
	my $length = @{$results};
	my ($genotype, $id, $counter);
	my @cache = ();
	
	my $hash_ref = {};
	my @struct   = ();
	$counter = 0;
	
	
	
	foreach $i (@{$results})
	{
		$genotype   = $i->{'genotype'};
		$id = $i->{'id'};
		
		
		
		$hash_ref = &find(\@struct, $genotype);		
		
		
		
		if (!($hash_ref))									# new genotype
		{
			$hash_ref = {};
			$hash_ref->{'genotype'} = $genotype;
			$hash_ref->{'id'}       = [$id];
			$hash_ref->{'data'}     = [\%{$i}];
			$hash_ref->{'length'}   = 1;		
			
			push(@struct, {%{$hash_ref}});
			
			
		}
		else											# already exist genotype
		{
			push(@{$hash_ref->{'id'}}, $id);
			push(@{$hash_ref->{'data'}}, {%{$i}});
			$hash_ref->{'length'} ++;
		}	
		
		
		$counter ++;
		
	}
	
	
	
	return &add_non_sig($h, \@struct);
	
	

}


#######################################   add_non_sig   ########################################

sub add_non_sig()
{
	my ($h, $ref_struct) = @_;
	my ($i, $j);
	my @struct = @{$ref_struct};
	
	my $genotype;
	my @ids;
	my $add_ref;
	my @add;


	foreach $i (@struct)
	{
		$genotype = $i->{'genotype'};
		@ids = @{$i->{'id'}};
	
		$add_ref = &get_all_genotype($h, $genotype, @ids);
		@add = (@{$add_ref});
		
		foreach $j (@add)
		{
			push(@{$i->{'id'}}, $j->{'id'});
			push(@{$i->{'data'}}, {%{$j}});
			
		}
		
	}
	
	return \@struct;

}


############################################   get_genotype   ##################################

sub get_genotype()
{
   	my ($h, $req) = @_ ;
	my @request = @{$req};
	
	
	
	my @res = ();
	my @items;
	
	my $error;
	my ($query, $where, $trait, $sig, $counter);
	
	
	
	$query = "SELECT * FROM traits_mean WHERE";
	$counter = 0;
	$where = "";
	
	foreach my $i (@request)
	{
		$trait = $i->[0];	#trait
		$sig   = $i->[1];	# sig:  1 - increase	0 - decrease
		
		
		
		if ($sig == 1)
		{
			$where .= "$trait > 0 AND $trait" . "_sig > 0";
		}
		else
		{
		 	if ($sig == 0)
			{
			 	 $where .= "$trait < 0 AND $trait" . "_sig > 0";
			}
			else
			{
			 	 $where .= "$trait" . "_sig > 0";			 		
			}
		}
		
		if ($counter < (@request - 1))
		{
			$where .= " AND ";
		}
		
		$counter ++;
				
	}
	
	$query .= " " . $where;
	
   	
	

	my $dbh = db_link::connect_db("naama","web_usr");
	#my $dbh = DBI->connect($DB, "naama", "naama1") || error($DBI::errstr);
	
	
	
	my $sth = $dbh->prepare($query); 
	unless($sth)
   	{
   		$error = $dbh->errstr;
		&error($h, "prepare :: $query : $error");
   	}
	
	
   	my $rv  = $sth->execute;
	unless($rv)
   	{
   		$error = $sth->errstr;
		&error($h, "Execute :: $query : $error");
   	}
	
	$counter = 0;
	
	while(@items = $sth->fetchrow_array)
	{
			push(@res, &make_hash(\@items));
			$counter ++;
	}	
	
	$sth->finish;
	$rv = $dbh->disconnect;
	
	return \@res;	

}


############################################   get_all_genotype   ##################################

sub get_all_genotype()
{
   	my ($h, $gen, @ids) = @_ ;

	my @res = ();
	my @items;
	
	my ($error, $counter);
	my ($query, $where);
	
	
	$query = "SELECT * FROM traits_mean WHERE genotype = '$gen' AND ";
	$counter = 0;
	$where = "";
	
	foreach my $i (@ids)
	{
		$where .= "id != $i";
		
		if ($counter < (@ids - 1))
		{
			$where .= " AND ";
		}
		
		$counter ++;
	}
	
	$query .= " " . $where;
	
   	#&error($h, "query is $query");
	

	my $dbh = db_link::connect_db("naama","web_usr");
	#my $dbh = DBI->connect($DB, "naama", "naama1") || error($DBI::errstr);
	
	
	my $sth = $dbh->prepare($query); 
	unless($sth)
   	{
   		$error = $dbh->errstr;
		&error($h, "prepare :: $query : $error");
   	}
	
	
   	my $rv  = $sth->execute;
	unless($rv)
   	{
   		$error = $sth->errstr;
		&error($h, "Execute :: $query : $error");
   	}
	
	$counter = 0;
	
	while(@items = $sth->fetchrow_array)
	{
			push(@res, &make_hash(\@items));
			$counter ++;
	}
	
	#&error($h, "counter is $counter --- and query is $query");
	
	$sth->finish;
	$rv = $dbh->disconnect;
	
	return \@res;	

}


##########################################    make_hash   ################################

sub make_hash()
{
	my ($row) = @_;
	
	#my %hash = ();		
	my $hash_ref = {};
	
	$hash_ref->{'id'}         = $row->[0];
	$hash_ref->{'genotype'}   = $row->[1];
	$hash_ref->{'chr'}        = $row->[2];
	$hash_ref->{'background'} = $row->[3];
	$hash_ref->{'experiment'} = $row->[4];
	$hash_ref->{'PW'}         = $row->[5];
	$hash_ref->{'PW_sig'}     = $row->[6];
	$hash_ref->{'FW'}         = $row->[7];
	$hash_ref->{'FW_sig'}     = $row->[8];
	$hash_ref->{'BX'}         = $row->[9];
	$hash_ref->{'BX_sig'}     = $row->[10];
	$hash_ref->{'TY'}         = $row->[11];
	$hash_ref->{'TY_sig'}     = $row->[12];
	$hash_ref->{'BM'}         = $row->[13];
	$hash_ref->{'BM_sig'}     = $row->[14];
	$hash_ref->{'RED'}        = $row->[15];
	$hash_ref->{'RED_sig'}    = $row->[16];
	$hash_ref->{'HI'}         = $row->[17];
	$hash_ref->{'HI_sig'}     = $row->[18];
	$hash_ref->{'BXY'}        = $row->[19];
	$hash_ref->{'BXY_sig'}    = $row->[20];
	$hash_ref->{'EC'}         = $row->[21];
	$hash_ref->{'EC_sig'}     = $row->[22];
	$hash_ref->{'IC'}         = $row->[23];
	$hash_ref->{'IC_sig'}     = $row->[24];
	$hash_ref->{'LEN'}        = $row->[25];
	$hash_ref->{'LEN_sig'}    = $row->[26];
	$hash_ref->{'WID'}        = $row->[27];
	$hash_ref->{'WID_sig'}    = $row->[28];
	$hash_ref->{'LEN_WID'}    = $row->[29];
	$hash_ref->{'LEN_WID_sig'}= $row->[30];
	$hash_ref->{'PER'}        = $row->[31];
	$hash_ref->{'PER_sig'}    = $row->[32];
	$hash_ref->{'SW'}         = $row->[33];
	$hash_ref->{'SW_sig'}     = $row->[34];
	$hash_ref->{'L'}          = $row->[35];
	$hash_ref->{'L_sig'}      = $row->[36];
	$hash_ref->{'A'}          = $row->[37];
	$hash_ref->{'A_sig'}      = $row->[38];
	$hash_ref->{'B'}          = $row->[39];
	$hash_ref->{'B_sig'}      = $row->[40];
	$hash_ref->{'CAR'}        = $row->[41];
	$hash_ref->{'CAR_sig'}    = $row->[42];
	$hash_ref->{'LYC'}        = $row->[43];
	$hash_ref->{'LYC_sig'}    = $row->[44];
		
	$hash_ref->{'FIRM'}        = $row->[45];
	$hash_ref->{'FIRM_sig'}    = $row->[46];
	$hash_ref->{'AT'}        = $row->[47];
	$hash_ref->{'AT_SIG'}    = $row->[48];
	$hash_ref->{'PH'}        = $row->[49];
	$hash_ref->{'PH_sig'}    = $row->[50];
	$hash_ref->{'MS'}        = $row->[51];
	$hash_ref->{'MS_sig'}    = $row->[52];
	$hash_ref->{'SUC'}        = $row->[53];
	$hash_ref->{'SUC_sig'}    = $row->[54];
	$hash_ref->{'GLU'}        = $row->[55];
	$hash_ref->{'GLU_sig'}    = $row->[56];
	$hash_ref->{'FRU'}        = $row->[57];
	$hash_ref->{'FRU_sig'}    = $row->[58];
	$hash_ref->{'MAA'}        = $row->[59];
	$hash_ref->{'MAA_sig'}    = $row->[60];
	$hash_ref->{'CIA'}        = $row->[61];
	$hash_ref->{'CIA_sig'}    = $row->[62];
	$hash_ref->{'LON'}        = $row->[63];
	$hash_ref->{'LON_sig'}    = $row->[64];
	$hash_ref->{'FN'}        = $row->[65];
	$hash_ref->{'FN_sig'}    = $row->[66];
	$hash_ref->{'SHN'}        = $row->[67];
	$hash_ref->{'SHN_sig'}    = $row->[68];
	$hash_ref->{'VEIN'}        = $row->[69];
	$hash_ref->{'VEIN_sig'}    = $row->[70];
	$hash_ref->{'SHLD'}        = $row->[71];
	$hash_ref->{'SHLD_sig'}    = $row->[72];
	$hash_ref->{'PLCT'}        = $row->[73];
	$hash_ref->{'PLCT_sig'}    = $row->[74];
	$hash_ref->{'PUFF'}        = $row->[75];
	$hash_ref->{'PUFF_sig'}    = $row->[76];
	
	
	return $hash_ref;

}




##################################   error   ##########################################

sub error()
{
	my $str;
	my $h;
   	my $text = "";

   	($h, $str) = @_ ;

   	$text .= $h->h2_stat("ERROR !");
	$text .= $str;

	$h->to_html("ERROR", \$text);
   	
	exit;
}


########################################   isExist   ############################################

sub isExist()
{
	my ($arr, $val) = @_;
	
	foreach my $i (@{$arr})
	{
		if ($i eq $val)
		{
			return 1;
		}
		
	}
	return 0;
}


######################################   find   #############################################

sub find()
{
	my ($struct, $gen) = @_;
	my $i;
	my $length = @{$struct};
	my $hash_ref;
	
	foreach my $i (@{$struct})
	{
		
		if ($i->{'genotype'} eq $gen)
		{
			return $i;
		}		
	}
	
	return 0;
	


}


####################################   print_entry   ##########################################

sub print_entry()
{
	my ($h, $hash_ref) = @_;
	my $text = "";
	
	my ($gen, $length, $key);
	my @id;
	my @data;
	
	$gen = $hash_ref->{'genotype'};	
	$length = $hash_ref->{'length'};
	
	@id = @{$hash_ref->{'id'}};
	@data = @{$hash_ref->{'data'}};
	
	
	$text .= "genotype is $gen -- length is $length --- ids are @id <BR>";
	$text .= "data is :<BR>";
	
	my $c = 0;
	
	foreach my $d (@data)
	{
		$text .= &print_hash($h, $d);
		$text .= "----------------------------<BR>";
		
		$text .= "<BR>";
		$c++;
	}
	
	
	
	return $text;
	
}



####################################   print_hash   ##########################################

sub print_hash()
{


	my ($h, $hash_ref) = @_;
	my ($text, $key);
	my %hash = %{$hash_ref};
	
	$text = "";
	
	
	foreach $key (keys %hash)
	{
		$text .= "$key -> " . $hash{$key};
		
		
	}
	
	
	return $text;

		
}
