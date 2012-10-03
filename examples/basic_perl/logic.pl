#!/usr/bin/perl -w
use strict;
use warnings;

my $var = rand(10); # a RANDOM number generator
if( $var < 3 ) {
  print "Variable ($var) is less than 3\n";
} elsif( $var <= 5 ) {
  print "Variable ($var) is between 3 and 5\n";
} else {
  print "Variable ($var) is > 5\n";
}
