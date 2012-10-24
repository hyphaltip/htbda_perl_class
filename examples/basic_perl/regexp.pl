#!/usr/bin/perl
use strict;
use warnings;

my $string1 = 'The quick brown fox';
# \w - A-Za-z
# \d - 0-9
# [ABC] - A,B,C
if( $string1 =~ /(o[wxn]+)/ ) {
	my $match = $1;
 print "yes it matched $match\n";
} else {
	print "no it didn't\n";
	
}