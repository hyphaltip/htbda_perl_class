#!/usr/bin/perl -w
use strict;
use Bio::Seq;
use Bio::SeqIO;
my $seq = Bio::Seq->new(-seq        => 'ATGAATGATGAA',
                        -display_id => 'example',
                        -description=> 'My first example sequence');
my $out = Bio::SeqIO->new(-format => 'fasta');
$out->write_seq($seq);
print "Id is ",$seq->display_id, "\n";
print "Length is ", $seq->length, "\n";
print "Seq is                ",$seq->seq,"\n"; 
print "Reverse complement is ", $seq->revcom->seq,"\n";
print "Translation is ", $seq->translate->seq, "\n";
print "Subseq of 3..6 is ", $seq->subseq(3,6), "\n";
print "Trunc/revcom of 3..6 is ", $seq->trunc(3,6)->revcom->seq, "\n";
