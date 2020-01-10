
package Html;





use lib '/usr/lib/perl5/site_perl/5.005/i386-linux';


use CGI qw(:standard);
use CGI::Carp qw(fatalsToBrowser);

use strict;
use warnings;



#########################################   new   ######################################


	sub new {
    	my $self  = {};
        $self->{event_flag}  = 0;
        $self->{event} = "";
        
        bless($self);      
		    
        return $self;
   	}
	
	
	
	
########################################   object methods   ##################################
##############################################################################################
	
	
########################################   set_event   ######################################

	
sub set_event() 
{
   	my $self  = shift;		
		my ($event) = @_;
		
		$self->{event_flag} = 1;		
		$self->{event} = $event;		
}
	
	
	
#######################################   clear_event   ####################################

sub clear_event()
{
	my $self = shift;
	
	$self->{event_flag}  = 0;
	$self->{event}       = "";
	
}


#######################################   write   ################################

sub write()
{
	shift;

	my ($arg, $size, $color) = @_;
	my $text;
	
	$text = "<b style=font-size:$size%;color:$color> $arg </b>";
	
	return $text;
	
}







#######################################  HTML  #############################################

#all these simple subroutines return a string that matches a certain html tag.

###########################################################################################



#######################################   to_html   ##################################

sub to_html(){
   my $ref;
   my $title;
   my $body;
   my $html;

	shift if (@_ > 2);

   ($title, $ref) = @_ ;
    
	$body = ${$ref};

   #print "content-type: text/html\n\n";
   $html = head_stat(title_stat($title)) . body_stat($body);
   $html = html_stat($html);
   print $html ;

}



#######################################   form   ###########################################

sub form()
{
   my $page;
   my $body;
   my $form;
   my $main_url;
   
   shift if (@_ > 3);

   ($body, $page, $main_url) = @_ ;

   $body .= hidden_item("menu", $page);
   $form = form_stat($page, $body, $main_url);
   return $form ;
}




sub html_stat(){
   my $text;
   shift if (@_ > 1);
   
   ($text) = @_ ;
 
   return "<HTML>" . $text . "</HTML>";
}

sub head_stat(){
   my $text ;
   shift if (@_ > 1);
   
   ($text) = @_ ;

   return "<HEAD>" . $text . "</HEAD>";
}

sub center_stat(){
   my $text ;
   shift if (@_ > 1);
   
   ($text) = @_ ;

   return "<CENTER>" . $text . "</CENTER>";
}

sub title_stat(){
   my $title ;
   
   shift if (@_ > 1);
   
   ($title) = @_ ;

   return "<TITLE> " . $title . "</TITLE>";
}

sub body_stat(){
   my $text ;
   shift if (@_ > 1);
   
   ($text) = @_ ;

   return "<BODY BGCOLOR=\"#ffffcc\">" . $text . "</BODY>";
}

sub h1_stat(){
   my $text ;
   shift if (@_ > 1);
   
   ($text) = @_ ;
   
   return "<H1><FONT COLOR=\"#94081C\">" . $text . "</FONT></H1>";
}


sub h2_stat(){
   my $text ;
   shift if (@_ > 1);
   
   ($text) = @_ ;
   
   return "<H2><FONT COLOR=\"#94081C\">" . $text . "</FONT></H2>";
}

sub h3_stat(){
   my $text ;
   shift if (@_ > 1);
   
   ($text) = @_ ;
   
   return "<H3><FONT COLOR=\"#0000AF\">" . $text . "</FONT></H3>";
}

sub pre_stat(){
   my $text ;
   shift if (@_ > 1);
   
   ($text) = @_ ;
   
   return "<pre>" . $text . "</pre>";
}


sub bold_stat(){
   my $text ;
   shift if (@_ > 1);
   
   ($text) = @_ ;
   
   return "<B>" . $text . "</B>";
}

sub italic_stat(){
   my $text ;
   shift if (@_ > 1);
   
   ($text) = @_ ;
   
   return "<I>" . $text . "</I>";
}

sub under_line_stat(){

	shift;

   my ($text, $type) ;
   ($text, $type) = @_ ;
   
   if ($type)
   {
   	return "<U><FONT COLOR=\"#0000AF\">" . $text . "</FONT></U>";
   }
   return "<U>" . $text . "</U>";
}



sub a_stat(){
   my $url ;
   my $text ;
   shift;
   
   ($url, $text) = @_ ;

   return "<A HREF=\"" . $url . "\">" . $text . "</A>";
}

sub ak_stat()
{
	my $url ;
   	my $text ;
   	shift;
	
   	($url, $text) = @_ ;

  	 return "<A HREF=\"" . $url . "\"target = \"_blank\">" . $text . "</A>";
}

sub ac_stat()
{
	my $url ;
   	my $text ;
   	shift;
	
   	($url, $text) = @_ ;

  	 return "<A HREF=\"" . $url . "\"target = \"_blanc\">" . $text . "</A>";
}


sub image_stat()
{
	shift;
	
	my ($url, $width, $height) = @_;
	
	return "<IMG SRC= $url width=\"$width\" height=\"$height\">";
}

sub form_stat(){
   my $name ;
   my $body ;
   my $main_url;
   shift if (@_ > 3);
   
   ($name, $body, $main_url) = @_ ;

   return "<FORM NAME=\"" . $name . "\" METHOD=\"POST\" ACTION=\"" . $main_url . "\">" . $body . "</FORM>";
}

sub form_tag()
{
	shift;
	my ($name, $body) = @_;
	
	return "<FORM NAME=\"" . $name . "\">" . $body . "</FORM>";
}

sub submit_item(){
   my $value ;
   my $name ;
   my $ret ;
   my $event;

   shift;

   ($value, $event, $name) = @_ ;

   $ret = "<INPUT TYPE=submit ";
   $ret .= "onClick=\"" . $event . "\" " if ($event);
   $ret .= "NAME=\"" . $name . "\" " if ($name);
   $ret .= "VALUE=\"" . $value . "\">" ;
   return $ret;
}


sub button_item(){
   my $value ;
   my $name ;
   my $ret ;
   my $event;

   shift;

   ($value, $event, $name) = @_ ;

   $ret = "<INPUT TYPE=button ";
   $ret .= "onClick=\"" . $event . "\" " if ($event);
   $ret .= "NAME=\"" . $name . "\" " if ($name);
   $ret .= "VALUE=\"" . $value . "\">" ;
   return $ret;
}



sub reset_item(){
   my $value ;
   my $ret ;

   shift;

   ($value) = @_ ;

   $ret = "<INPUT TYPE=reset ";
   $ret .= "VALUE=\"" . $value . "\">" ;
   return $ret;
}

sub checkbox_item(){
   my $name ;
   my $ret ;
	my $is_checked;
	
	shift;
	
   ($name, $is_checked) = @_ ;

   $ret = "<INPUT TYPE=checkbox NAME=\"" . $name . "\" ";
   $ret .= "CHECKED" if ($is_checked);
   $ret .= ">" ;
   return $ret;
}

sub radio_item(){
   my $name ;
   my $value ;
   my $ret ;
   my $act = "";

   shift;

   ($name, $value, $act) = @_ ;

   $ret = "<INPUT TYPE=radio NAME=\"" . $name . "\" VALUE=\"" . $value . "\"$act>\n" ;
   return $ret;
}

sub text_item(){
   my $name ;
   my $size ;
   my $value ;
   my $ret ;

   shift;

   ($name, $size, $value) = @_ ;

   $ret = "<INPUT TYPE=text NAME=\"" . $name . "\"";
   $ret .= " VALUE=\"" . $value . "\""; 
   $ret .= " SIZE=" . $size . ">";
   return $ret;
}

sub file_item(){
   my $name ;
   my $size ;
   my $ret ;
   shift;

   ($name, $size) = @_ ;

   $ret = "<INPUT TYPE=file NAME=\"" . $name . "\" SIZE=" . $size . ">";
   return $ret;
}

sub textarea_item(){
   my $name ;
   my ($rows, $cols);
   my $text;
   my $ret ;

   shift;

   ($name, $rows, $cols, $text) = @_ ;

   $ret = "<TEXTAREA NAME=\"" . $name . "\" ROWS=$rows COLS=$cols>" ; 
   $ret .= $text . "</TEXTAREA>" ;
   return $ret;
}

sub hidden_item(){
   my $name ;
   my $value ;
   shift if (@_ > 2);
   
   ($name, $value) = @_ ;

   return "<INPUT TYPE=hidden NAME=\"" . $name . "\" VALUE=\"" . $value . "\">" ;
}

sub select_item(){
   my $name ;
   my @values ;
   my ($ret, $val);
   my $event;
   my $self = shift;
   
   ($name, @values) = @_ ;
   
   

   $ret = "<SELECT NAME=\"" . $name . "\"" ;
	 
	 if ($self->{event_flag})
	 {
	 
   		$ret .= "onClick = \"" . $self->{event} . "\">";
	 }
	 else
	 {
	 	  $ret .= ">";
	 }
   
   $val = shift(@values);
   $ret .= "<OPTION VALUE=\"" . $val . "\" SELECTED>$val" ;
   foreach $val (@values){
      $ret .= "<OPTION VALUE=\"" . $val . "\">$val" ;
   }
   $ret .= "</SELECT>" ; 
   return $ret ;
}

sub table_element()
{
	shift;

	my ($arg, $border, $space) = @_;


	if ($border && $space)
	{
		return "<table border = \"$border\" cellspacing=\"$space\"  > $arg </table>";
	}
	
	if ($space)
	{
		return "<table cellspacing=\"$space\"  > $arg </table>";
	}
	if ($border)
	{
		return "<table border = \"$border\"> $arg </table>";
	}
	
	return "<table> $arg </table>";
}

sub row_element()
{
	shift;

	my @data = @_;
	my $text = "<tr>";
	
	foreach my $i (@data)
	{
		$text .= data_element($i);
	}
	$text .= "</tr>";
}

sub r_element()
{
	shift;

	my ($arg) = @_;
	
	return "<tr> $arg </tr>";
}

sub data_element()
{
	shift;

	my ($arg, $align, $row_span, $col_span, $type, $color) = @_;
	my $t = "td";
	
	
	if ($type)
	{
		$t = "th";
	}
	else
	{
		$t = "td";
	}
	
	if ($align && $row_span)
	{
		return "<$t align=\"$align\" rowspan = \"$row_span\"> $arg </$t>";
	}
	if ($align)
	{
		return "<$t align=\"$align\"> $arg </$t>";	
	}
	if ($row_span)
	{
		return "<$t rowspan=\"$row_span\"> $arg </$t>";
	}
	if ($col_span)
	{
		return "<$t colspan=\"$col_span\"> $arg </$t>";
	}
	if ($color)
	{
		return "<$t bgColor=\"$color\"> $arg </$t>";	
	}
	
	return "<$t> $arg </$t>";	
}

sub li_stat()
{
	shift;

	my ($arg) = @_;
	
	return "<li> $arg </li>";
}

sub ul_stat()
{
	shift;

	my ($arg) = @_;
	
	return "<ul> $arg </ul>";
}


sub script_stat()
{
	shift;
	my ($stat, $src) = @_;
	
	if ($src)
	{
		return "<SCRIPT language=\"javascript\" SRC=\"$src\"> <!--// document.write(\"can not find function\") //--></SCRIPT>";
	}
	else
	{
		return "<SCRIPT> $stat </SCRIPT>";
	}
}  



return 1;


