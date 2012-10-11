#!/usr/bin/perl
use strict;
use warnings;

my %seqs = ('AAC35278'=>'LLIAITYYNEDKVLTARTLHGVMQNPAWQKIVVCLVFDGIDPVLATIGV-VMKKDVDGKE',
'AnCSMA' => 'AMCLVTCYSEGEEGIRTTLDSIALTPN-SHKSIVVICDGIIKVLRMMRD-TGSKRHNMAK',
'AfCHSF' => 'ALCLVTCYSEGEEGIRTTLDSIAMTPN-SHKTIIVICDGIIKVLRMMRD-TGSKRHNMAK',
'AAF19527' => 'AILLVTAYSEGELGIRTTLDSIATTPN-SHKTILVICDGIIKVLGMMKD-RGSKRHNMAK',
'P30573-1' => 'TINLVTCYSEDEEGIRITLDSIATTPN-SHKLILVICDGIIKVLDMMSDAQGSKRHNMAK',
);

print "names of the sequences ", join(",", keys %seqs), "\n";
my %gap_columns;
for my $seqname ( keys %seqs ) {
 my $seq = $seqs{$seqname};
 my $gap_count = 0;
 my $index = index($seq, '-');
 while( $index >= 0 ) {
  $gap_count++;
  $gap_columns{$index} = 1;
  $index = index($seq,'-',$index+1);
 }
 my $length = length($seq) - $gap_count;
 print "$seqname is $length residues long\n";
}
print "the gap columns are ",join(",", keys %gap_columns), "\n";
print "there are ", scalar keys %gap_columns, " columns with gaps\n";

my $seq1 = $seqs{'AfCHSF'};
my $seq2 = $seqs{'AAF19527'};

my $length1 = length($seq1);
my $identical_bases = 0;
for( my $i = 0; $i < $length1; $i++ ) {
 my $base_seq1 = substr($seq1,$i,1);
 my $base_seq2 = substr($seq2,$i,1);
 next if( $base_seq1 eq '-' || $base_seq2 eq '-' );
 if( $base_seq1 eq $base_seq2 ) {
   $identical_bases++;
 }
}

print "There are $identical_bases between AfCHSF,AAF19527 \n";
printf "The sequences AAF19527,AfCHSF are %.2f %% identical\n", 100 * $identical_bases / $length1;
