#!/usr/bin/perl -w
use strict;
use Bio::AlignIO;
my %seqs_to_remove =(umay_BRD_UM05510_1 => 1, umay_BRD_UM01600_1 =>1);

my $in = Bio::AlignIO->new(-format => 'fasta',
                           -file   => 'actin_hits.fasaln');
my $out = Bio::AlignIO->new(-format => 'nexus',
                            -file   => '>actin_hits_trim.nex');
if( my $aln = $in->next_aln ){ 
 my @seqs = $aln->each_seq;
 for my $s ( @seqs ) {
   if( exists $seqs_to_remove{$s->id} ) {
      $aln->remove_seq($s);
   }
 }
 my $updated = $aln->remove_gaps('-',1);
 $out->write_aln($updated);
}
