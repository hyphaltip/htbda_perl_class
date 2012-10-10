#!/usr/bin/perl
use strict;

my $url = 'http://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=nucleotide&id=163644330&retmode=text&rettype=fasta';
open(my $fh => "curl -S '$url' |") || die $!;
while(<$fh>) {
     print $_;
}
