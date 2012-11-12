#!/usr/bin/perl
use warnings;
use strict;
# run with perl single_linkage.pl small.block.dat
# assume this is BLAST table format
my $in = shift || "need an input table\n";
my $cutoff_evalue = 1e-5;

open(my $fh => $in) || die $!;


my %combos;
while (<$fh>) {
  my ($query,$hit,$pid,$aln_len, $mismatches,$gapsm,
            $qstart,$qend,$hstart,$hend,$evalue,$bits) = split;
  next if $evalue > $cutoff_evalue;
  $combos{$query}->{$hit} = $evalue;
}

my %clusters;

# This function will take as input
# sequence scores - hash reference, where keys are the ids and value are the
#                   scores [percent identity for this script]
# cutoff          - the minimum cutoff value for putting sequences in the same 
#                   cluster 
sub single_linkage {
  my ($seqscores,$cutoff) = @_;
  my (@clusters,$clusterct,%seqclusterlookup);

  while ( my ($sequence1,$data1) = each %$seqscores ) {
    # get the bin for this sequence, in the absence 
    # of seeing anything about this sequence we give it a
    # new bin number, we'll join bins if need be
    my $bin = $seqclusterlookup{$sequence1};
    unless( defined $bin ) {
      $bin = $seqclusterlookup{$sequence1} = $clusterct++;
      push @{$clusters[$bin]}, $sequence1;
    }
    while ( my ($sequence2,$evalue) = each %$data1 ) {
      next if( $evalue > $cutoff );
      my $bin2 = $seqclusterlookup{$sequence2};
      if ( defined $bin2 ) {    # already seen a sequence2 before
	if ( $bin != $bin2 ) { 
	  # join these two bins since they meet the threshold
	  # this means pulling everything from both bins
	  # together
	  push @{$clusters[$bin]}, @{$clusters[$bin2]};
	  $clusters[$bin2] = [];
	}
	next;
      } else { 
	push @{$clusters[$bin]}, $sequence2;
      }
      $seqclusterlookup{$sequence2} = $bin2 = $bin;
    }
  }    
  # this only returns clusters which are > 0 in size (empty clusters
  # come from joining to bins together
  # it sorts them by size so largest cluster cluster comes first
  return sort { scalar @$b <=> scalar @$a } 
    grep { defined && scalar @$_ > 0} @clusters;
}
