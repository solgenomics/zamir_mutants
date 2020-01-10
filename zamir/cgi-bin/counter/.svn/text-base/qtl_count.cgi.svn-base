#! /usr/bin/perl





&main();	

###########################################   main   #########################################

sub main()
{
 		my $counter_file = "/data/prod/public/zamir/qtl/my_number.txt";
			
		&process($counter_file);
		
		print "Location: ". "http://zamir.sgn.cornell.edu/Qtl/General/mailbox_1.jpg";

}

###########################################   process   #########################################


sub process()
{
 		
 		my ($file) = @_; 
		
 		open(COUNT,$file) || die "Can't Open Count File $file, Error : $!\n"; 

 		my $count = <COUNT>;
 		
		chomp ($count);
		unless ($count)
		{
		 	$count = 0;
		}
		close(COUNT);	
		
		$count++;

 		open(COUNT,">$file") || die "Can't Open Count File $file, Error : $!\n"; 
		
		print COUNT "$count";

   	close(COUNT);			
		
}

