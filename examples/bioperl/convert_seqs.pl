#!/usr/bin/perl -w
use strict;
use Bio::SeqIO;
use Getopt::Long;
my ($informat,$outformat) = ('genbank','fasta');
my ($infile,$outfile);
GetOptions('if:s'  => \$informat,
	   'of:s'  => \$outformat,
	   'i|input:s' => \$infile,
	   'o|output:s'=> \$outfile);
die "need input and output filenames\n" unless $infile && $outfile;
my $in = Bio::SeqIO->new(-format => $informat,   # input handle
                         -file   => $infile);
my $out = Bio::SeqIO->new(-format => $outformat, # output handle
                          -file   => ">$outfile");
while( my $seq = $in->next_seq ) {
 $out->write_seq($seq);
}
