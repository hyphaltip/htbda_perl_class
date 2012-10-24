#!/usr/bin/perl -w
use strict;
use Bio::AlignIO;
my $in = Bio::AlignIO->new(-format => 'clustalw',
                           -file   => 'actin_hits.clustalw');
my $out = Bio::AlignIO->new(-format => 'nexus',
                            -file   => '>actin_hits.nex');
while( my $aln = $in->next_aln ){ 
 $out->write_aln($aln);
}

