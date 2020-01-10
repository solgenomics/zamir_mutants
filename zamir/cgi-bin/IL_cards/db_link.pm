package db_link;

use lib '/usr/lib/perl5/site_perl/5.005/i386-linux';

#global packages to use
use DBI;
use DBD::mysql ();

sub connect_db {
    my ($db) = @_;
    # try to open the database
    my ($dsn, $usr, $pwd) = ("dbi:mysql:$db", 'username', 'password');
    
    my $dbh = DBI->connect($dsn, $usr, $pwd, { RaiseError => 1})
        || die "Can't connect to $dsn: $DBI::errstr";
    
    # Set larger max buffer size so that long sequences don't get truncated on retrieval
    my  $newsize = 20480;
    ($rc = $dbh->{LongReadLen} = $newsize) 
        || die "Error setting LongReadLen to $newsize: $DBI::errstr";
    
    return $dbh;
}

sub disconnect_db {
    my ($dbh) = @_;
    $rc = $dbh->disconnect || warn DBI::errstr;
}

return 1;
