#!/usr/bin/perl
use warnings;
use strict;

# assume this is BLAST table format
my $in = shift || "need an input table\n";
my $cutoff_evalue = 1e-5;

open(my $fh => $in) || die $!;


my %combos;
while (<$fh>) {
  my ($query,$hit,$pid,$aln_len, $mismatches,$gapsm,
            $qstart,$qend,$hstart,$hend,$evalue,$bits) = split;
  next if $evalue > $cutoff_evalue;
  my ($sp1,$g1) = split(/\|/,$query);
  my ($sp2,$g2) = split(/\|/,$hit);
  # need to keep track of the count (is this the Nth hit)
  push @{$combos{$query}->{$sp2}},[$hit,$evalue]; # PUSHING ON pairs
}

my %BBD;
for my $query ( keys %combos ) {

  my ($qsp,$qgene) = split(/\|/,$query);
  for my $species ( keys %{$combos{$query}} ) {
    # get the top hit -- insure it is the best by sorting them
    my ($firsthit) = sort { $a->[1] <=> $b->[1] } @{$combos{$query}->{$species}};
    # firsthit is the data from the lins PUSHING ON pairs above
    my ($hit,$evalue) = @{$firsthit};
    next if exists $BBD{$query}->{$hit}; # skip if we have already seen this pair
    my ($hsp,$hgname) = split(/\|/,$hit);
    next if $qsp eq $hsp; # skip in cases of comparing self to self
    # get the top hit in the other direction
    my ($reciprocal) = sort { $a->[1] <=> $b->[1] } @{$combos{$hit}->{$hsp}};

    if ( $firsthit->[0] eq $reciprocal->[0]) {
      print join("\t", $query, $hit, $evalue), "\n";

      # let's record this pair as finished so we don't print it out again
      $BBD{$query}->{$hit}++;
      $BBD{$hit}->{$query}++;
    }
  }
}
