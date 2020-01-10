#!/usr/bin/perl -w


print "Content-type: text/html\n\n";

use Html;

use CGI qw(:standard);
use CGI::Carp qw(fatalsToBrowser);

my $H   = Html->new();
my $main_dir = "/cgi-bin/Leaf/";
my $debug_file = "debug.txt";

my @all_data;
my %table;
my @titles=("Name of Mutant");

&main();


#&display_form();


####################################   main   ###############################################

sub main()
{
    my @args_names = param();
    
    if (@args_names == 0)
    {
        &display_form();
    }
    else
    {
        &results();
    }
}

#####################################   results   ###################################

sub results()
{
    
    my $ref = &get_folder($main_dir);
    my $ref1;
    
    my @files = @{$ref};
    my @leafs = ();
    
    foreach my $key (@files)
    {
        if ($key =~ /.txt/)
        {
            push(@leafs, $key);
        }
        
    } 
    
    my $text = "";
    
    my @all_data = ();
    my $remain_data = \@all_data;    
    my %temp;
    my $name;
    my $criteria;
    
    # calculating all_data :
    
    for ($i=0; $i<@leafs; $i++)
    {
        %temp = &get_all_data($main_dir . $leafs[$i]);
        push(@all_data, {%temp});
        # initializing %table variable :
        $name = $temp{"name"};
        $table{$name} = [];
    }    
    
    my ($i, $j, %mutant, $leaflets_num, $side);
    ($ref, $criteria) = &get_search();
    
    my @all_requests = @{$ref};
    for ($i=0; $i<@all_requests; $i++)
    {
        %request = %{$all_requests[$i]};
        
        if ($request{"to_do1"} == 1)    
        {
            $ref = &check_leaflets_num(\@all_data, \%request, 1);            
            $remain_data = &intersection($remain_data, $ref);
        }
        
        if ($request{"to_do2"} == 1)    
        {
            $ref = &check_leaflets_num(\@all_data, \%request, 2);           
            $remain_data = &intersection($remain_data, $ref);
        }
        
        if ($request{"to_do3"} == 1)    
        {
            $ref = &check_leaf_ratio(\@all_data, \%request, 1);        
            $remain_data = &intersection($remain_data, $ref);
        }
        if ($request{"to_do4"} == 1)    
        {
            $ref = &check_lobing(\@all_data, \%request);        
            $remain_data = &intersection($remain_data, $ref);
        }
        if ($request{"to_do5"} == 1)    
        {
            $ref = &check_margins(\@all_data, \%request, 1);        
            $remain_data = &intersection($remain_data, $ref);
        }
        if ($request{"to_do6"} == 1)    
        {
            $ref = &check_margins(\@all_data, \%request, 2);        
            $remain_data = &intersection($remain_data, $ref);
        }
        if ($request{"to_do7"} == 1)    
        {
            $ref = &check_tiny_leafs(\@all_data, \%request);        
            $remain_data = &intersection($remain_data, $ref);
        }
        if ($request{"to_do8"} == 1)    
        {
            $ref = &check_leaf_ratio(\@all_data, \%request, 2);        
            $remain_data = &intersection($remain_data, $ref);
        }
        if ($request{"to_do9"} == 1)    
        {
            $ref = &check_secondary(\@all_data, \%request);        
            $remain_data = &intersection($remain_data, $ref);
        }
        if ($request{"to_do10"} == 1)    
        {
            $ref = &check_leaflet_ratio(\@all_data, \%request);        
            $remain_data = &intersection($remain_data, $ref);
        }
    }
    # extracting names of found mutants :
    my @found_mutants = ();
    for ($i=0; $i<@{$remain_data}; $i++)
    {
        push(@found_mutants, $remain_data->[$i]->{"name"});
    }
    
    my $length = @{$remain_data};
    my $add = "";
    
    my $num;
    $add .= "<h3>$length items found</h3><br>";
    for ($i=0; $i<@{$remain_data}; $i++)
    {
        $num = $i+1;
        $add .= "$num) " . $remain_data->[$i]->{"name"} . "<br>";
    }
    $add .= "<hr>";
    
    
    # generate table output :
    my @cells;
    my $key;
    
    $text .= "<table border='3'><tr>";    #first comes the title of the table :
    for ($i=0; $i<@titles; $i++)
    {
        $text .= "<td><b> $titles[$i] </b></td>";
    }
    $text .= "</tr>";
    # next is the body of the table :
    foreach $key (keys(%table))    # iterating over all mutants
    {
        @cells = @{$table{"$key"}};
        $text .= "<tr>";
        if (is_exist($key, @found_mutants))
        {
            $text .= "<td><b>$key</b></td>";
        }
        else
        {
            $text .= "<td>$key</td>";
        }
        
        for($i=0; $i<@cells; $i++)
        {            
            $text .= "<td> $cells[$i] </td>";           
        }
        $text .= "</tr>\n";
    }
    $text .= "</table>";
    
    
    print <<EOF;
    
    <html>
    <head>
    <title>Leaf mutations</title>
    
    </head>
    <body>
    
    <h2>Results </h2>
    <br>
    You serached for mutants that show : <br>
    <b>
    $criteria
    </b>
    $add
    
    $text   
    </body>
    </html>
    
EOF
    
}

####################################   get_search   ###############################################

sub get_search()
{
    my @all_requests = ();
    my %request;
    my $text = "";
    my ($side, $condition, $value);
    
    if (param("check1") eq "on")
    {
        $all_requests[0] = {};
        $all_requests[0]->{"to_do1"} = 1;
        $all_requests[0]->{"condition"} = param("select11");
        $all_requests[0]->{"value"} = param("text1");
        $all_requests[0]->{"side"} = param("select12");
        
        $side = "both sides" if (param("select12") == 1);
        $side = "right side" if (param("select12") == 2);
        $side = "left side"  if (param("select12") == 3);
        
        $condition = "more than" if (param("select11") == 1);
        $condition = "less than" if (param("select11") == -1);
        $condition = "equal to"  if (param("select11") == 0);
        
        $value = param("text1");
        
        $text .= "Number of leaflets in $side is $condition $value <br>";
        
    }
    
    if (param("check2") eq "on")
    {
        $all_requests[1] = {};
        $all_requests[1]->{"to_do2"} = 1;
        $all_requests[1]->{"condition"} = param("select21");
        $all_requests[1]->{"value"} = param("text2");
        $all_requests[1]->{"side"} = param("select22");
        
        $side = "both sides" if (param("select22") == 1);
        $side = "right side" if (param("select22") == 2);
        $side = "left side"  if (param("select22") == 3);
        
        $condition = "more than" if (param("select21") == 1);
        $condition = "less than" if (param("select21") == -1);
        $condition = "equal to"  if (param("select21") == 0);
        
        $value = param("text2");
        
        $text .= "Number of Intercalary in $side is $condition $value <br>";
        
    }
    
    if (param("check3") eq "on")
    {
        $all_requests[2] = {};
        $all_requests[2]->{"to_do3"} = 1;
        $all_requests[2]->{"condition"} = param("select3");
        $all_requests[2]->{"value"} = param("text3");
        
        $condition = "more than" if (param("select3") eq "more");
        $condition = "less than" if (param("select3") eq "less");        
        
        $value = param("text3");
        
        $text .= "ratio between leaf length and width is $condition  $value<br>";
        
    }
    if (param("check4") eq "on")
    {
        $all_requests[3] = {};
        $all_requests[3]->{"to_do4"} = 1;
        $all_requests[3]->{"condition"} = param("select4");
        $all_requests[3]->{"value"} = param("text4");
        
        $condition = "more than" if (param("select4") eq "more");
        $condition = "less than" if (param("select4") eq "less");        
        
        $value = param("text4");
        
        $text .= "Lobing of leaf is $condition  $value<br>";
        
    }
    if (param("check5") eq "on")
    {
        $all_requests[4] = {};
        $all_requests[4]->{"to_do5"} = 1;
        $all_requests[4]->{"value"} = param("select5");        
        
        $value = param("select5");
        
        $text .= "Margins of leaf is $value<br>";
        
    }
    if (param("check6") eq "on")
    {
        $all_requests[5] = {};
        $all_requests[5]->{"to_do6"} = 1;
        $all_requests[5]->{"value"} = param("select6");        
        
        $value = param("select6");
        
        $text .= "Epidermis of leaf is $value<br>";        
    }
    if (param("check7") eq "on")
    {
        $all_requests[6] = {};
        $all_requests[6]->{"to_do7"} = 1;
        $all_requests[6]->{"condition"} = param("select7");
        $all_requests[6]->{"value"} = param("text7");
        
        $condition = "more than" if (param("select7") eq "more");
        $condition = "less than" if (param("select7") eq "less");        
        
        $value = param("text7");
        
        $text .= "Number of tiny leafs is $condition $value<br>";
        
    }
    if (param("check8") eq "on")
    {
        $all_requests[7] = {};
        $all_requests[7]->{"to_do8"} = 1;
        $all_requests[7]->{"condition"} = param("select8");
        $all_requests[7]->{"value"} = param("text8");
        
        $condition = "more than" if (param("select8") eq "more");
        $condition = "less than" if (param("select8") eq "less");        
        
        $value = param("text8");
        
        $text .= "ratio between leaf area and perimeter is $condition  $value<br>";
        
    }
    if (param("check9") eq "on")
    {
        $all_requests[8] = {};
        $all_requests[8]->{"to_do9"} = 1;
        $all_requests[8]->{"condition"} = param("select9");
        $all_requests[8]->{"value"} = param("text9");
        
        $condition = "more than" if (param("select9") eq "more");
        $condition = "less than" if (param("select9") eq "less");        
        
        $value = param("text9");
        
        $text .= "Mean of secondary leaflets in primary leaflets is $condition  $value<br>";
        
    }
    if (param("check10") eq "on")
    {
        $all_requests[9] = {};
        $all_requests[9]->{"to_do10"} = 1;
        $all_requests[9]->{"condition"} = param("select10");
        $all_requests[9]->{"value"} = param("text10");
        
        $condition = "more than" if (param("select10") eq "more");
        $condition = "less than" if (param("select10") eq "less");        
        
        $value = param("text10");
        
        $text .= "Mean of length/width ratio of leaflets is $condition  $value<br>";
        
    }
    
    return (\@all_requests, $text);
    
    
    
}


####################################   display_form   ###############################################


sub display_form()
{   
    print <<EOF;
    
    <html>
    <head>
    <title>Leaf mutations</title>
    
    </head>
    <body>
    
    <h2>Leaf mutants search page </h2>
    <br><br>
    
    
<form action="leaf.pl?menu=result" name="form1">
<input type="checkbox" name="check1"/> Number of leaflets
<select name=select11>
<option value="1">more than</option>
<option value="-1">less than</option>
<option value="0">equal</option>
</select>


<input type="text" name = "text1" size="5"/>
in &nbsp;
<select name=select12>
<option value="1">both sides</option>
<option value="2">right side</option>
<option value="3">left side</option>
</select>
<br><br>

<input type="checkbox" name="check2"/> Number of intercalary

<select name=select21>
<option value="1">more than</option>
<option value="-1">less than</option>
<option value="0">equal</option>
</select>


<input type="text" name = "text2" size="5"/>
in &nbsp;
<select name=select22>
<option value="1">both sides</option>
<option value="2">right side</option>
<option value="3">left side</option>
</select>

<br><br>

<input type="checkbox" name="check3"/> Leaf length/width is
<select name=select3>
<option value="more">more than</option>
<option value="less">less than</option>
</select>
&nbsp;
<input type="text" name = "text3" size="5"/>

<br><br>

<input type="checkbox" name="check4"/> Lobing of leaf is
<select name=select4>
<option value="more">more than</option>
<option value="less">less than</option>
</select>
&nbsp;
<input type="text" name = "text4" size="5"/>
(enter a value from 1 to 10)

<br><br>

<input type="checkbox" name="check5"/> Margins of leaf is
<select name=select5>
<option value="1">weak</option>
<option value="2">like m82</option>
<option value="3">visible</option>
<option value="4">acute</option>
</select>

<br><br>


<input type="checkbox" name="check6"/> Epidermis of leaf is
<select name=select6>
<option value="1">Smooth</option>
<option value="2">like m82</option>
<option value="3">rougher</option>
<option value="4">visible leaf epidermis</option>
</select>

<br><br>


<input type="checkbox" name="check7"/> Number of tiny leafs is
<select name=select7>
<option value="more">more than</option>
<option value="less">less than</option>
</select>
&nbsp;
<input type="text" name = "text7" size="5"/>

<br><br>

<input type="checkbox" name="check8"/> Leaf area/perimeter is
<select name=select8>
<option value="more">more than</option>
<option value="less">less than</option>
</select>
&nbsp;
<input type="text" name = "text8" size="5"/>

<br><br>

<input type="checkbox" name="check9"/> Mean of secondary leaflets in primary leaflets is
<select name=select9>
<option value="more">more than</option>
<option value="less">less than</option>
</select>
&nbsp;
<input type="text" name = "text9" size="5"/>

<br><br>

<input type="checkbox" name="check10"/> Mean of length/width ratio of leaflets is
<select name=select10>
<option value="more">more than</option>
<option value="less">less than</option>
</select>
&nbsp;
<input type="text" name = "text10" size="5"/>

<br><br>

<button type="submit" >Submit</button>
<button type="reset" >Reset</button>


</form>
  
  
  
    </body>
    </html>
    
EOF
        
}

###################################   check_leaflet_ratio   ####################################

sub check_leaflet_ratio()
{
    my ($data, $req) = @_;
    my @found_keys = ();
    my @temp;
    my ($i, $j);
    my ($leaflet_length, $leaflet_width, %mutant);
    my $count_leaflets = 0;
    my $ratio = 0;
    
    push(@titles, ("Mean length/width ratio of leaflet"));
    
    for ($i=0; $i<@{$data}; $i++)                        #iterating over all mutants
    {
        %mutant = %{$data->[$i]};
        
        $leaflet_length  = 0;
        $leaflet_width   = 0;
        $count_leaflets  = 0;
        $ratio           = 0;
        
        @temp = @{$mutant{"leaflets"}};
        for ($j=0; $j<@temp; $j++)      #iterating over all leaflets
        {
            $count_leaflets ++;
            $leaflet_length = $data->[$i]->{"leaflets"}->[$j]->{"length"};
            $leaflet_width = $data->[$i]->{"leaflets"}->[$j]->{"width"};
            
            $ratio += $leaflet_length/$leaflet_width;
        }        
        
        if ($count_leaflets > 0)
        {
            $ratio = $ratio/$count_leaflets;
        }
        else
        {
            $ratio = 0;
        }
        
        if ($req->{"condition"} eq "more")
        {
            push(@found_keys, $data->[$i]->{"name"}) if ($ratio > $req->{"value"});
        }
        if ($req->{"condition"} eq "less")
        {
            push(@found_keys, $data->[$i]->{"name"}) if ($ratio < $req->{"value"});
        }
        
        
        push(@{$table{$data->[$i]->{"name"}}}, $ratio);
    }    
    return \@found_keys;    
}




###################################   check_secondary   ####################################

sub check_secondary()
{
    my ($data, $req) = @_;
    my @found_keys = ();
    my @temp;
    my ($i, $j);
    my ($leaflets_count, $secondary_count, $ratio, %mutant);
    
    push(@titles, ("mean of secondary leaflets in primary leaflets"));
    
    for ($i=0; $i<@{$data}; $i++)                        #iterating over all mutants
    {
        %mutant = %{$data->[$i]};
        $leaflets_count  = 0;
        $secondary_count = 0;
        @temp = @{$mutant{"leaflets"}};
        for ($j=0; $j<@temp; $j++)      #iterating over all leaflets
        {
            $leaflets_count ++;
            $secondary_count += $data->[$i]->{"leaflets"}->[$j]->{"l2"};
        }
        
        if ($leaflets_count > 0)
        {
            $ratio = $secondary_count/$leaflets_count;
        }
        else
        {
            $ratio = 0;
        }
        
        if ($req->{"condition"} eq "more")
        {
            push(@found_keys, $data->[$i]->{"name"}) if ($ratio > $req->{"value"});
        }
        if ($req->{"condition"} eq "less")
        {
            push(@found_keys, $data->[$i]->{"name"}) if ($ratio < $req->{"value"});
        }
        
        
        push(@{$table{$data->[$i]->{"name"}}}, $ratio);
    }    
    return \@found_keys;    
}


###################################   check_tiny_leafs   ####################################

sub check_tiny_leafs()
{
    my ($data, $req) = @_;
    my @found_keys = ();
    my $i;
    my ($tiny);
    
    push(@titles, ("Tiny leafs"));
    
    for ($i=0; $i<@{$data}; $i++)
    {
        $tiny = $data->[$i]->{"features"}->{"tiny"};
        
        
        if ($req->{"condition"} eq "more")
        {
            push(@found_keys, $data->[$i]->{"name"}) if ($tiny > $req->{"value"});
        }
        if ($req->{"condition"} eq "less")
        {
            push(@found_keys, $data->[$i]->{"name"}) if ($tiny < $req->{"value"});
        }
        push(@{$table{$data->[$i]->{"name"}}}, $tiny);
        
    }
    return \@found_keys;    
    
}

###################################   check_lobing   ####################################

sub check_lobing()
{
    my ($data, $req) = @_;
    my @found_keys = ();
    my $i;
    my ($lobing);
    
    push(@titles, ("Leaf lobing"));
    
    for ($i=0; $i<@{$data}; $i++)
    {
        $lobing = $data->[$i]->{"features"}->{"lobing"};        
        
        if ($req->{"condition"} eq "more")
        {
            push(@found_keys, $data->[$i]->{"name"}) if ($lobing > $req->{"value"});
        }
        if ($req->{"condition"} eq "less")
        {
            push(@found_keys, $data->[$i]->{"name"}) if ($lobing < $req->{"value"});
        }
        push(@{$table{$data->[$i]->{"name"}}}, $lobing);
        
    }
    return \@found_keys;    
}

###################################   check_margins   ####################################

sub check_margins()
{
    my ($data, $req, $type) = @_;
    my @found_keys = ();
    my $i;
    my $margin;
    
    push(@titles, ("Leaf margins")) if ($type == 1);
    push(@titles, ("Leaf epidermis")) if ($type == 2);
    
    for ($i=0; $i<@{$data}; $i++)
    {
        $margin = $data->[$i]->{"features"}->{"margins"} if ($type == 1);
        $margin = $data->[$i]->{"features"}->{"epidermis"} if ($type == 2); 
        
        push(@found_keys, $data->[$i]->{"name"}) if ($margin == $req->{"value"});
        
        push(@{$table{$data->[$i]->{"name"}}}, $margin);
        
    }
    return \@found_keys;    
}


###################################   check_leaf_ratio   ####################################

sub check_leaf_ratio()
{
    my ($data, $req, $type) = @_;
    my @found_keys = ();
    my $i;
    my ($length, $width);
    
    push(@titles, ("Leaf length/width")) if ($type == 1);
    push(@titles, ("Leaf area/perimeter")) if ($type == 2);
    
    for ($i=0; $i<@{$data}; $i++)
    {
        if ($type == 1)
        {
            $length = $data->[$i]->{"features"}->{"length"};
            $width = $data->[$i]->{"features"}->{"width"};
        }
        else
        {
            $length = $data->[$i]->{"features"}->{"area"};
            $width = $data->[$i]->{"features"}->{"perimeter"};
        }
        
        if ($req->{"condition"} eq "more")
        {
            push(@found_keys, $data->[$i]->{"name"}) if ($length/$width > $req->{"value"});
        }
        if ($req->{"condition"} eq "less")
        {
            push(@found_keys, $data->[$i]->{"name"}) if ($length/$width < $req->{"value"});
        }
        push(@{$table{$data->[$i]->{"name"}}}, $length/$width);
        
    }
    return \@found_keys;    
}


###################################   check_leaflets_num   ####################################

sub check_leaflets_num()
{
    my ($ref1, $ref2, $type) = @_;
    my @all_data = @{$ref1};
    my %request = %{$ref2};
    
    my $leaflets_num = 0;
    my $criteria;
    my %mutant;
    
    my ($i, $j);
    my @temp;
    my %leaflet;
    my @found_keys;
    my $condition;
    my $side;
    
    $side = $request{"side"};        #which side    
    $criteria  = $request{"value"};      #which number
    if (!is_interger($criteria)) {return ();}
    $condition = $request{"condition"};    #which condition
    
    my ($left, $right, $total);    
    
    push(@titles, ("Leaflets on right", "Leaflets on left")) if ($type == 1);
    push(@titles, ("Intercalary on right", "Intercalary on left")) if ($type == 2);
    
    #my $text = "<table border='3'><tr><td>Mutant name</td> <td>Leaflets on right</td><td>Leaflets on left</td> <td>Leaflets on both</td></tr>\n";
    
    for ($i=0; $i<@all_data; $i++)
    {
        %mutant = %{$all_data[$i]};
        $left = 0;
        $right = 0;
        $total = 0;
        
        if ($type == 1)
        {
            @temp = @{$mutant{"leaflets"}};
        }
        else
        {
            @temp = @{$mutant{"intercalary"}};
        }
        
        for ($j=0; $j<@temp; $j++)
        {        
            %leaflet = %{$temp[$j]};
            if ($leaflet{"align"} eq "right")
            {
                $right ++;
            }
            elsif ($leaflet{"align"} eq "left")
            {
                $left ++;
            }
        }
        
        if ($condition == 1)    #more than
        {
            if ($side == 1)    #both sides
            {
                
                push(@found_keys, $mutant{"name"}) if ($left + $right > $criteria);
            }
            elsif ($side == 2)    #right
            {
                
                push(@found_keys, $mutant{"name"}) if ($right > $criteria);
            }
            elsif ($side == 3)    #left
            {
                
                push(@found_keys, $mutant{"name"}) if ($right > $criteria);
            }
        }
        elsif ($condition == -1)    #less than
        {
            if ($side == 1)    #both sides
            {
                
                push(@found_keys, $mutant{"name"}) if ($left + $right < $criteria);
            }
            elsif ($side == 2)    #right
            {
                
                push(@found_keys, $mutant{"name"}) if ($right < $criteria);
            }
            elsif ($side == 3)    #left
            {
                
                push(@found_keys, $mutant{"name"}) if ($left < $criteria);
            }
        }
        elsif ($condition == 0)    #equal
        {
            if ($side == 1)    #both sides
            {
                
                push(@found_keys, $mutant{"name"}) if ($left + $right == $criteria);
            }
            elsif ($side == 2)    #right
            {
                
                push(@found_keys, $mutant{"name"}) if ($right == $criteria);
            }
            elsif ($side == 3)    #left
            {
                
                push(@found_keys, $mutant{"name"}) if ($left == $criteria);
            }
        }
        $total = $left+$right;
        
        #$text .= "<tr><td>" . $mutant{"name"} . "</td> <td> $right </td> <td> $left </td> <td> $total </td></tr>\n";
        push(@{$table{$mutant{"name"}}}, $right);
        push(@{$table{$mutant{"name"}}}, $left);   
    }
    #$text .= "</table>";    
        
    
    
    return \@found_keys;
    
}

###################################   get_folder   ###################################

sub get_folder()
{           
    my ($folder) = @_;        
    my @thumb;
	
    opendir (THUMB, "$folder") or print "can not open directory ($folder): $!<br>\n";	
    @thumb = readdir(THUMB);
	
    shift(@thumb);
    shift(@thumb);	
	
    closedir THUMB;	
    return \@thumb;

}


#############################################   get_all_data   #####################################


sub get_all_data()
{
    
    my ($file) = @_;
    
    my %leaf;
    
    $leaf{"name"} = "";
    $leaf{"leaflets"} = [];
    $leaf{"terminal"} = "";
    $leaf{"intercalary"} = [];
    $leaf{"features"} = &get_leaf_features($file);
    
    
    open (F, "$file");
    
    my @lines = <F>;
    my ($line, $type);
    my @temp;
    my %leaflet;
    my %terminal;
    my @leaflets = ();
    my $i;
    
    $line = $lines[0];
    $line =~ /(.+?)\s/;
    my $name = $1;
    
    $leaf{"name"} = $name;
    
  
    for ($i=1; $i<@lines; $i++)
    {
        $line = $lines[$i];
        $line =~ /(\d)/;
        $type = $1;
        
        %leaflet = ();
       
        #$line =~ /\d[\s+](.+?)[\s+]([.+?])[\s+]([.+?])[\s+]([.+?])[\s+]([.+?])[\s+]([.+?])[\s+]/;
        $line =~  /\d[\s+](.+?)[\s+](.+?)[\s+](.+?)[\s+](.+?)[\s+](.+?)[\s+](.+?)[\s+]/;
            
        $leaflet{"align"} = $1;
        $leaflet{"rachis"} = $2;
        $leaflet{"length"} = $3;
        $leaflet{"width"} = $4;            
        if ($leaflet{"align"} ne "terminal" & $type == 1)    #only if terminal and not intercalary
        {
            $leaflet{"l2"} = $5;
            $leaflet{"l3"} = $6;
        }
        
        #&output("type is $type and align is " . $leaflet{"align"} . " ___ ");
        
        if ($type == 0)    #for intercalary
        {
            #&output("intercalary !\n");
            push(@{$leaf{"intercalary"}}, {%leaflet});
        }
        elsif ($leaflet{"align"} ne "terminal" && $type == 1)    #for not terminal leaflets
        {
            #&output("leaflet !\n");
            push(@{$leaf{"leaflets"}}, {%leaflet});  
        }
        elsif ($leaflet{"align"} eq "terminal" && $type == 1)    #for terminal leaflets
        {
            #&output("terminal !\n");
            $leaf{"terminal"} = {%leaflet};
        }   
            
    }
    
      
    close(F);
    
    return %leaf;
    
}


##########################################   intersection   ############################

sub intersection()
{
    my ($data_ref, $keys_ref) = @_;
    my $i;
    my @subset = ();
    
    for ($i=0; $i<@{$data_ref}; $i++)
    {
        if (is_exist($data_ref->[$i]->{"name"}, @{$keys_ref}))
        {
            push(@subset, $data_ref->[$i]);
        }   
        
    }
    return \@subset;
    
    
    
}



##########################################   get_leaf_features   ############################

sub get_leaf_features()
{
    my ($file) = @_;    
    open (F, "$file");
    
    my @lines = <F>;    
    
    my ($i, $line);
    
    $line = $lines[@lines-1];
    
    $line =~ /\d[\s+](.+?)[\s+](.+?)[\s+](.+?)[\s+](.+?)[\s+](.+?)[\s+](.+?)[\s+](.+?)[\s+](.+?)[\s+](.+?)[\s+]/;
    
    my %features;
    $features{"length"} = $1;
    $features{"width"} = $2;
    $features{"lobing"} = $3;
    $features{"margins"} = $4;
    $features{"epidermis"} = $5;
    $features{"tiny"} = $6;
    $features{"area"} = $7;
    $features{"perimeter"} = $8;
    $features{"area/perimenter"} = $9;
    
    close(F);
    
    return \%features;
    
}





#########################################   output   ######################################

sub output()
{
    
    my ($str) = @_;    
    open (OUT_FILE, ">>$debug_file");    
    print OUT_FILE $str;    
    close(OUT_FILE);

}

#######################################   is_interger   #######################################

sub is_interger()
{
    my ($value) = @_;   
    
    if ($value =~ /\D/)
    {
        return 0;
    }
    return 1;
}



#######################################   is_exist   #######################################

sub is_exist()
{
    my ($value, @arr) = @_;
    my $i;
    
    for ($i=0; $i<@arr; $i++)
    {
        if ($value eq $arr[$i])
        {
            return 1;
        }
    }
    return 0;
    
}

