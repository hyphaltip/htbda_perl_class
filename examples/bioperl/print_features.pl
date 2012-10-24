#!/usr/bin/perl -w
use strict;
use Bio::SeqIO;
my $file = 'NT_021877.gbk';
my $in = Bio::SeqIO->new(-format => 'genbank',
			 -file   => $file);

while ( my $seq = $in->next_seq ) {
  print $seq->display_id, " features:\n";
  for my $feature ( $seq->get_SeqFeatures ) {
    print " ",$feature->primary_tag," ",$feature->start, "..",$feature->end,"\n";
    for my $tag ( sort $feature->get_all_tags ) {
      my @values = $feature->get_tag_values($tag);
      print "  $tag:\t", join(",", @values),"\n";
    }
  }
}
