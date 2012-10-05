#!/usr/bin/perl -w
use strict;
use warnings;

my $lightning = 0;
my $johnny_five = 0;
while( $johnny_five < 1000 ) {
  if( $lightning == 1 ) {
    print "I'm fried!\n";
    last;
  } else {
    print "I'm alive\n";
  }
  $lightning = int rand(10);
}



my $str = "110101210201010011110";
my $ind = index($str,"01");
while( $ind > 0 ) {
  # when ind is -1 it means it got to the end of the string
  print substr($str,$ind,2),"\n"; # print 2 digits
  $ind = index($str,"01",$ind+1);
}
