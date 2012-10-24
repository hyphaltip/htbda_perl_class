#!/usr/bin/perl -w
use strict;
use Bio::DB::Fasta;

my $dbfile = 'basidio_fungi_20050923.aa';
my $db = Bio::DB::Fasta->new($dbfile);

# retrieve a sequence
my $id = 'cneo_JEC21_TIGR:CNA07700';
my $seq = $db->get_Seq_by_acc($id);
if ( $seq ) {
  print "seq was ",$seq->seq,"\n";
} else {
  warn("Cannot find $id\n");
}
