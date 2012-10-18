#!/usr/bin/perl 
# calculate the sum of an array
use strict; use warnings;

my @data = (1..100);
my $sum = 0;
foreach my $i(1..100){
   $sum = $data[$i];
}
print "Sum is $sum\n";
