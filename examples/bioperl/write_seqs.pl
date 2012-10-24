#!/usr/bin/perl -w
use strict;
use Bio::SeqIO;

my $informat = 'genbank';
my $outformat= 'fasta';
my $in = Bio::SeqIO->new(-format => $informat,   # input handle
                         -file   => 'seqs.gbk');
my $out = Bio::SeqIO->new(-format => $outformat, # output handle
                          -file   => '>seqs.fas');
while( my $seq = $in->next_seq ) {
 $out->write_seq($seq);
}
