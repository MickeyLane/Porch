#!/usr/bin/perl
use strict;
use warnings;

#
# This script is for a "Reolink RL-410"
#

use LWP::Simple;
use DateTime::Duration;
use Cwd;
use File::Basename;

# use lib $ENV{'VIEWS_ROOT'};
# use viewspkg_time;
# use viewspkg_lock;

my $show_debug_strings = 0;
my $ip = "192.168.0.148";
my $name = "porch";

my @debug_strings;

# push (@debug_strings, $name);
push (@debug_strings, $ip);

#
# Exit value must be 25 to indicate pass
# Exit value of 30 means it never got set in the code below (software bug)
#      31 means no argument supplied
#      35 means the getstore() routine failed
#      39 means retries exhausted
#
my $exit_value = 30;
my $success_exit_value = 25;

#
# Process command line arguments
#
my $pic_number = $ARGV[0];
if ((!defined $pic_number) || (length ($pic_number) == 0)) {
    push (@debug_strings, "Picture number is missing");
    $exit_value = 31;
    goto end;
}
else {
    push (@debug_strings, "First arg is \"$pic_number\"");
}

my $dto;

my $file = $name . "_" . $pic_number . ".jpg";
my $out_dir = $ARGV[1];
if (defined ($out_dir)) {
    $file = "$out_dir/$name" . "_" . $pic_number . ".jpg";
}

push (@debug_strings, "\$file = $file");

my $url = "http://$ip/cgi-bin/api.cgi?cmd=Snap&channel=0&rs=wuuPhkmUCeI9WG7C&user=admin&password=campw801";

push (@debug_strings, $url);

#
# Stall this instance of the script if there is another instance running
#
# my $cwd = getcwd();
my $dirname = dirname (__FILE__);

# my $lock_file_handle = viewspkg_lock::views_get_script_lock ($dirname);

my $retry = 3;
while ($retry) {
    unlink $file;

    my $http_response = getstore ($url, $file);
    # print ("$http_response\n");
    if ($http_response ne "200") {
        push (@debug_strings, "\$$http_response = $http_response");
        next;
    }

    if (-e $file) {
        my $fil_siz = -s $file;
        push (@debug_strings, "Size is $fil_siz");
        
        if ($fil_siz > 28000) {

            $exit_value = $success_exit_value;
            goto end;
        }
        else {
            unlink $file;
        }
    }

    $retry--;
}

#
# Retries exhausted
#
$exit_value = 39;
push (@debug_strings, "Retries exhausted");

end:

# viewspkg_lock::views_discard_script_lock_with_handle ($lock_file_handle);
# close ($lock_file_handle);

if ($show_debug_strings || $exit_value != $success_exit_value) {
    print ("Camera $name:\n");
    foreach my $s (@debug_strings) {
        print ("  $s\n");
    }
}

exit ($exit_value);


