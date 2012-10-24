#!/usr/bin/perl -w
use strict;
use Bio::SeqIO;
my $file = 'NT_021877.gbk';
my $in = Bio::SeqIO->new(-format => 'genbank',
			 -file   => $file);
my $cds_out = Bio::SeqIO->new(-format => 'fasta',
			      -file   => ">$file.CDS");
my $exon_out = Bio::SeqIO->new(-format => 'fasta',
			      -file   => ">$file.CDS_exons");
my $exon_pep_out = Bio::SeqIO->new(-format => 'fasta',
				   -file   => ">$file.CDS_exons_pep");

while ( my $seq = $in->next_seq ) {
  print $seq->display_id, " features:\n";
  for my $feature ( $seq->get_SeqFeatures ) {
    print " ",$feature->primary_tag," ",$feature->location->to_FTstring(),"\n";
    next unless ( $feature->primary_tag eq 'CDS');
		  #||
		  #$feature->primary_tag eq 'mRNA');
    my ($name) = $feature->get_tag_values('gene'); # careful, what if it doesn't exist?
    my $exonct = 1;
    for my $exon (sort { $a->start * $feature->strand <=> $b->start * $feature->strand }
		  $feature->location->each_Location ) {
      print "  ",$exon->to_FTstring,"\n";
      my $exonseq = $seq->trunc($exon);
      $exonseq->display_id($name.".exon".$exonct++);
      $exonseq->description($exon->to_FTstring);
      $exon_out->write_seq($exonseq);
      $exon_pep_out->write_seq($exonseq->translate);
    }
    my $spliced = $feature->spliced_seq;
    $spliced->display_id($name);
    $cds_out->write_seq($spliced);
  }
}
