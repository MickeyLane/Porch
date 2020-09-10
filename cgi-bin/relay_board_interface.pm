#!/usr/bin/perl
package relay_board_interface;
use warnings FATAL => 'all';
use strict;

#
# This software is provided as is, where is, etc with no guarantee that it is
# fit for any purpose whatsoever. Use at your own risk. Mileage may vary.
#

use IO::Socket qw(AF_INET AF_UNIX);

#
# The address and port of the device
#
my $ip_address = '192.168.0.254';
my $port = '6722';

#
# Given a relay number, 1 or 2, turn the relay on
#
sub set {
    my $relay_number = shift;
    my $verbose = shift // 0;

    my $cmd = sprintf ("%c%c", '1', $relay_number);

    my ($status, $lights, $sign) = transact ($cmd);

    return ($status, $lights, $sign);
}

#
# Given a relay number, 1 or 2, turn the relay off
#
sub clear {
    my $relay_number = shift;
    my $verbose = shift // 0;

    my $cmd = sprintf ("%c%c", '2', $relay_number);

    my ($status, $lights, $sign) = transact ($cmd);

    return ($status, $lights, $sign);
}

sub get_current_state {

    my ($status, $lights, $sign) = transact ('00');

    return ($status, $lights, $sign);
}

#
# Given a command, return status, light state and sign state
#
sub transact {
    my $cmd = shift;

    #
    # Creating socket...
    #
    # print ("Creating socket...\n");
    my $sock = IO::Socket->new (
        Domain => IO::Socket::AF_INET,
        Blocking => 1,
        Proto => 'tcp',
        PeerPort => $port,
        PeerHost => $ip_address) || die "Can't open socket: $@";

    # print ("Sending \"$cmd\" command...\n");
    my $size = $sock->send ($cmd);

    # print ("Waiting for response...\n");
    my $buffer;
    $sock->recv($buffer, 1024);
    my $len = length ($buffer);
    # print ("Got back $len characters");
    # print ("\"$buffer\"\n");

    $sock->close();
}

sub translate_response {
    my $resp = shift;

    my $lights = substr ($resp, 0, 1);
    my $sign = substr ($resp, 1, 1);

    return ($lights, $sign);
}

1;
