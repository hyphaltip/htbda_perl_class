#!/usr/bin/perl
use warnings;

print "You're turning into a penguin.\n";
#print 'You're turning into a penguin.\n'; # error
print 'You\'re turning into a penguin.\n'; # special char not printed
print "\n"; # clear up the screen


$str = "AACTTTGGA";
print substr($str,3), "\n";
print substr($str,6,3), "\n";

$rev = reverse $str; # reverse the order
print $str,"\n",$rev,"\n";

$len = length $str; # get the sequence length
print "DNA is $len bp long.\n";

$index = index($str,"TTG"); # find substring inside a string
print "first TTG is at $index ", substr($str,$index,3),"\n";


$dollars = 50;
$cents   = $dollars;
$cents   *= 100;
print "$dollars dollars = $cents cents\n";

