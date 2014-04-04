#!/usr/bin/perl
use strict;
use warnings;

my @array = (10,33,16,17,21,40,3);

my $sum;

# print out the total sum of the array @array
foreach my $item ( @array ) {
 print "$item\n";
 $sum = $item + $sum;
 # $sum += $item;
 # add to get the sum here
}
print "Sum is ", $sum, "\n";
# extra credit: print out the average of the array
my $avg = $sum / scalar @array; # calculate average here 
print "Average is ", $avg, "\n";
