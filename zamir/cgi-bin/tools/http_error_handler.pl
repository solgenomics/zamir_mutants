use strict;
use Apache;
use CXGN::Page;
use CXGN::Apache::Request;
use CXGN::Apache::Error;
my $refer=$ENV{'HTTP_REFERER'};
$refer||='the referring site';
my $request=$ENV{'REQUEST_URI'};
$request||='(page request not found)';
my $agent=$ENV{'HTTP_USER_AGENT'};
my($page_name)=CXGN::Apache::Request::page_name($request);
our $page=CXGN::Page->new("404 - File not found","john");
our $client_message="$page_name does not exist on this server.";
our $client_message_body='';
our $client_instructions="You may wish to contact the referring site and inform them of this error.\n";



#some spam spiders try to submit spam to sites by forging referers and submitting requests to standard "contact us" pages. we don't use these pages, so these requests show up as 404s refered by sgn.
if($request=~m|formmail|i or $request=~m|/form.pl|i or $request=~m|/mail.pl|i or $request=~m|ezforml|i or $request=~m|/library/comments/comments.pl|i or $request=~m|fmail.pl|i or $request=~m|cgiemail|i or $request=~m|mailform.pl|i or $request=~m|\.cgi|i or $request=~m|nether-mail|i or $request=~m|/feedback|i or $request=~m|/contact|i)
{
    &no_action_just_message;
}
#no one knows the cause of these, but some dutch web client or bot is submitting malformed requests
elsif($request=~/bestanden/)
{
    &no_action_just_message;
}
#add elsifs here for your removed pages. you can just check $page_name if it's an unusual name. use $request and a pattern match if it's something like "index.html".



#if none of the above cases are true, we have a real 404. if we care about the referer, then send an email.
elsif(defined($refer)&&(($refer=~/cornell\.edu/)||($refer=~/google\.com/)))
{
    my $error_verb="not found - 404";
    my $developer_message=<<END_HEREDOC;
404 - File not found:
$request 
referred by $refer

END_HEREDOC
    $page->error_page($client_message,$client_message_body,$error_verb,$developer_message);
}
else
{
    &no_action_just_message;
}
sub no_action_just_message
{
    $page->message_page($client_message,$client_instructions);
}
