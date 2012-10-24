#!/usr/bin/perl -w
use strict;
use Bio::SearchIO;
my $cutoff = '0.001';
my $file = 'BOSS_DROME.CE_FASTP';
my $in = Bio::SearchIO->new(-format => 'fasta',
                            -file    => $file);

while( my $r = $in->next_result ) {

  print "Query is: ", $r->query_name, " ",
  $r->query_description," ",$r->query_length," aa\n";
  print " Matrix was ", $r->get_parameter('matrix'), " ",
        " Method was ", $r->algorithm,"\n";
  while( my $h = $r->next_hit ) {
    last if $h->significance > $cutoff;
    print "Hit is ", $h->name, "\n";
    while( my $hsp = $h->next_hsp ) {
     print " HSP Len is ", $hsp->length('total'), " ",
           " E-value is ", $hsp->evalue, " Bit score ",
           $hsp->score, " \n",
           " Query loc: ",$hsp->query->start, " ",
           $hsp->query->end," ",
           " Sbject loc: ",$hsp->hit->start, " ",
           $hsp->hit->end,"\n";
    }
  }
}
