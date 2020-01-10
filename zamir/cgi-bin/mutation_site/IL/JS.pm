


package JS;





use lib '/usr/lib/perl5/site_perl/5.005/i386-linux';


use CGI qw(:standard);
use CGI::Carp qw(fatalsToBrowser);

#use strict;
use warnings;




#global packages to use

my $MAIN_URL  = "/cgi-bin/mutation_site/IL/";




#########################################   new   ######################################


	sub new {
    	my $self  = {};
        
		bless($self);      
		    
        return $self;
   	}
	
	
	
	
	
	
	
	
	
	sub convert_src()
	{
		shift;
		my $file_name = shift;
		
		my $text = "";
		
		open (JS, $file_name) ||  die "cannot open file $file_name: $!";
		
		my @lines = <JS>;
		#chomp (@lines);
		
		close (JS);
		
		
		foreach my $line (@lines)
		{
			$text .= $line;		
		}
		
		
		
		return $text;

	
	
	}
	
