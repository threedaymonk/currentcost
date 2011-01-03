#!/usr/bin/env perl

use strict;
use Device::SerialPort qw( :PARAM :STAT 0.07 );

my $PORT = "/dev/serial/by-id/usb-Prolific_Technology_Inc._USB-Serial_Controller-if00-port0";

my $ob = Device::SerialPort->new($PORT);
$ob->baudrate(2400);
$ob->write_settings;

open(SERIAL, "+>$PORT");
while (my $line = <SERIAL>) {
  if ($line =~ m!<ch1><watts>0*(\d+)</watts></ch1>.*<tmpr> *([\-\d.]+)</tmpr>!) {
    my $ch1 = $1;
    my $ch2 = 0; # Until I get a second clip.
    my $temp = $2;
    `rrdtool update powertemp.rrd N:$ch1:$ch2:$temp`;
    print "${ch1}W ${ch2}W ${temp}C\n";
  }
}
