#!/usr/bin/perl 
use strict;
use warnings;

my @array1 = qw(A B C D);
my @array2 = qw(W X Y Z);
my @array3 = (@array1, @array2);

print join(",", @array3), "\n";

@array3 = (\@array1, \@array2);

print join(",", @array3), "\n";

# get them back off the array
my $array1ref = $array3[0];
my $array2ref = $array3[1];

# de-reference the arrays to print them

print join(",", @{$array1ref}), "\n";
print join(",", @{$array2ref}), "\n";

# can also do this all in one 

print join(",", @{$array3[0]}), "\n";
print join(",", @{$array3[1]}), "\n";


