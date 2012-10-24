#!/usr/bin/perl -w
use strict;
use Bio::SeqIO;
my $file = 'basidio_fungi_20050923.aa';
my $motif = '^[^C]+(C[^C]){4}[^C]*$';
#my $motif = '(C[^C]{2,}){2,}';
my $in = Bio::SeqIO->new(-format => 'fasta',
			 -file   => $file);
my $seqcount = 0;
my $basecount= 0;
my $basecount_nostops = 0;
my $motif_count = 0;
while ( my $seq = $in->next_seq) {
 $seqcount++; # count the number of sequences
 $basecount += $seq->length; # count how many bases in the whole db
 my $str = $seq->seq; # get the sequence as a string
 $str =~ s/\*//g;     # remove all '*' from sequence
 $basecount_nostops += length($str); # count bases from this string
 if ( $str =~ /$motif/i ) {
   $motif_count++; # count number of sequences that have this motif
 }
}

print "In db $file ther are $seqcount sequences, and $basecount bases ($basecount_nostops ignoring *)\n";
printf "In db %s ther are %d sequences, and %d bases (%d ignoring *)\n",
  $file, $seqcount, $basecount, $basecount_nostops;

printf "%d sequences have the motif $motif\n",$motif_count;
