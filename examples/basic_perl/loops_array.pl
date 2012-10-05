#!/usr/bin/perl
use strict;
use warnings;

# calculate a sum of an array

my @nums = (5,20,1,17,3,41);
my $sum = 0;

print "The list is @nums\n";
print @nums, "\n";
my $n;
foreach $n ( @nums ) {
 print "n is $n\n";
 $sum += $n; # $sum = $sum + $n;
}

print "sum is $sum\n";

# one other way to iterate through list
$sum = 0;
for( my $i = 0; $i < scalar @nums; $i++) {
 $sum += $nums[$i];
}

# hashes
my %months = ('Jan' => 'Winter', 
              'Feb' => 'Winter', 
              'Jun' => 'Summer', 
              'Jul' => 'Summer');

# $months{'Jul'} = 'Spring';

my @keys = keys %months;

print "Months names are @keys\n";
print "Months names are ",join("\t",@keys),"\n";

my $m;
foreach $m ( @keys ) {
 print "Month is $m; Season is $months{$m}\n";
 print "The season is ", length $months{$m}, " letters long\n";
}

my @values = values %months;
my $val;
foreach $val ( @values ) {
 print "Val is $val\n";
}









