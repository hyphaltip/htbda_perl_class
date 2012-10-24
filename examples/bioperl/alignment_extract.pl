#!/usr/bin/perl -w
use strict;
use Bio::AlignIO;
my $ref_seq = 'C08B11_6';
my $pos_start = 3; #INTERPRO ACTIN DOMAIN START 
my $pos_end   = 389; #INTERPRO ACTIN DOMAIN START
my $in = Bio::AlignIO->new(-format => 'fasta',
                           -file   => 'actin_hits.fasaln');
my $out = Bio::AlignIO->new(-format => 'nexus',
                            -file   => '>actin_hits_domain.nex');
if( my $aln = $in->next_aln ){
 for my $s ($aln->each_seq ) {
   if(  $s->id eq $ref_seq ) {
     my $col_start = $aln->column_from_residue_number($s->id, $pos_start);
     my $col_end = $aln->column_from_residue_number($s->id, $pos_end);
     print "grabbing columns $col_start .. $col_end\n";
     my $piece = $aln->slice($col_start, $col_end);
     $out->write_aln($piece);
     last; # all done
   }
 }
}
