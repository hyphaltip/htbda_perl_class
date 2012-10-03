#!/usr/bin/perl
use warnings;

$x = 10;
$y = 2.2;
$z = 1/3;
print "$x is x, z is $z\n";
$sum = $x + $y;
print "sum = $sum\n";
$string = "12";
$sum = $string + $x;
print "sum = $sum\n";
$sum += 5; # can add to an existing in one line
$sum /= 5; # or divide by
print "sum is $sum\n";
