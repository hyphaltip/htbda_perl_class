#!/usr/bin/perl -w
use strict;

while(<>) {
 if(/^>(\S+\s+.+\s+\[(?:chromosome|location)=([^\]]+)\](\s+.+)?)/ ) {
   my $stem = $2;
   my $line = $1;
   chomp($line);
   if( $stem =~ /mito/ ) {
	$stem = 'Mito';
   }
   $_ = sprintf(">chr%s %ss\n",$stem,$line);
 }
 print;
}

