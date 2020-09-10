#!C:/Strawberry/perl/bin/perl.exe
#!/usr/bin/perl
use warnings;
use strict;

#
# This software is provided as is, where is, etc with no guarantee that it is
# fit for any purpose whatsoever. Use at your own risk. Mileage may vary.
#

use Cwd;

use lib '.';
use relay_board_interface;


my $name;
my $gnam;
my $exac;
my $line_display_limit = 100;
my $screen_format = 'desktop';
my $screen_width;
my $data;
my $sign_command = '?';
my $lights_command = '?';

my $invoked_by_console_flag = 0;
my $invoked_by_post_message_flag = 0;
my $invoked_by_html_a_link_flag = 0;
my $invoked_by_unknown_flag = 0;

#
# Adjust cwd
#
my $cwd = Cwd::cwd();
my $i = rindex ($cwd, '/');
my $cur_dir = substr ($cwd, $i + 1);
# if ($cur_dir eq 'cgi-bin') {
#     #
#     # Go up one level from cgi-bin so lookup and data are subdirectories
#     #
#     chdir ('..');
#     $cwd = Cwd::cwd();
#     $cur_dir = substr ($cwd, $i + 1);
# }

#
# Get input
#
my $content_length = $ENV{'CONTENT_LENGTH'};
if (defined ($content_length)) {
    my $content_type = $ENV{'CONTENT_TYPE'};   # not really needed
    my $request_method = $ENV{'REQUEST_METHOD'};   # not really needed
    read (STDIN, $data, $content_length);
    $invoked_by_post_message_flag = 1;
}
else {
    $data = $ENV{'QUERY_STRING'};
    if (defined ($data)) {
        $content_length = length ($data);
        $invoked_by_html_a_link_flag = 1;
    }
    else {
        $data = shift @ARGV;
        if (defined ($data)) {
            $content_length = length ($data);
            $invoked_by_console_flag = 1;
        }
        else {
            $invoked_by_unknown_flag = 1;
        }
    }
}

#
# Isolate keys and values
#
if ($invoked_by_unknown_flag == 0) {
    my @pairs = split (/&/, $data); 
    foreach my $pair (@pairs) { 
        my ($key, $value) = split (/=/, $pair);

        if ($key eq 'sign') {
            $sign_command = uc $value;
        }
        elsif ($key eq 'lights') {
            $lights_command = uc $value;
        }
        # elsif ($key eq 'exac') {
        #     #
        #     # Values are "" and "on"
        #     #
        #     $exact_first_name_match_specified = ($value eq 'on');
        # }
        # elsif ($key eq 'format') {
        #     $screen_format = $value;
        #     if ($screen_format ne 'mobile' && $screen_format ne 'desktop') {
        #         $screen_format = 'desktop';
        #     }
        # }
        # elsif ($key eq 'max') {
        #     #
        #     # Values are numbers. Zero is infinite
        #     #
        #     # if ($value eq 'on') {
        #     #     $no_limit_specified = 1;
        #     #     $limit_output = 0;
        #     # }
        #     $line_display_limit = $value;
        # }
    }
}

#
# Return page header. Note double <carriage return>
#
print ("Content-type: text/html\n\n");
print ("<html>\n");
print ("<head>\n");
print ("<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\n");
print ("<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n");

print ("<title>The Porch</title>\n");

if ($screen_format eq 'mobile') {
    print ("<style>\n");
    print ("    p {\n");
    print ("        font-size: 3vw;\n");
    print ("    }\n");
    print ("    pre {\n");
    print ("        font-size: 2vw;\n");
    print ("    }\n");
    print ("</style>\n");
}

print ("</head>\n");
print ("<body>\n");


if ($invoked_by_unknown_flag) {
    print ("<pre>\n");
    print ("   Failure to open get input data<br>\n");
    print ("</pre>\n");
    print ("</body>\n");
    print ("</html>\n\n\n");
    exit (0);
}

my $status;
my $lightstate;
my $signstate;

($status, $lightstate, $signstate) = relay_board_interface::get_current_state ();

if (!$status) {
    print ("<pre>\n");
    print ("   Failure to get relay status\n");
    print ("</pre>\n");
    print ("</body>\n");
    print ("</html>\n\n\n");
    exit (0);
}

print ("<pre>\n");

print ("\n");

if ($screen_format eq 'mobile') {
    print ("   Dates may be machine generated guesses<br> so use them as suggestions only\n");
}
else {
    print ("   Dates may be machine generated guesses so use them as suggestions only\n");
}


print ("</p>\n");


print ("</pre>\n");
# print ("</div>\n");
print ("</body>\n");
print ("</html>\n\n\n");
exit (0);



