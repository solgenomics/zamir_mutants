package db_link;


#global packages to use
use DBI;

sub connect_db {
    my ($db, $usr) = @_;

#default user
    $usr ||= 'web_usr';


#known user/password hash
    my %pwd=();
    $pwd{'web_usr'}='sol@ley!';
    $pwd{'cgn_editor'}='coffee';
    $pwd{'fgp_editor'}='flower';
    $pwd{'cgn_annotator'}='coffee_writer';
    $pwd{'fgn_annotator'}='flower_writer';
    $pwd{'koni'}='bitchbadass';

    my $dsn= "dbi:mysql:$db;host=localhost";

    # try to open the database    
    my $dbh = DBI->connect($dsn, $usr, $pwd{$usr}, { RaiseError => 1})
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
