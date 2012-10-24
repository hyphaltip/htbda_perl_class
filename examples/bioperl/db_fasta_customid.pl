#!/usr/bin/perl -w
use strict;
use Bio::DB::Fasta;

my $dbfile = 'basidio_fungi_20050923.aa';
my $db = Bio::DB::Fasta->new($dbfile, -reindex => 1,
			     -makeid => \&my_makeid);

# retrieve a sequence
for my $id ( qw(CNA07700 cneo_JEC21_TIGR:CNA07700) ) {
  my $seq = $db->get_Seq_by_acc($id);
  if ( $seq ) {
    print "seq was ",$seq->seq,"\n";
  } else {
    warn("Cannot find $id\n");
  }
}

sub my_makeid {
  my $id = shift;
  if ( $id =~ /^>([^:]+:(\S+))/ ) {
    return $1;
  } elsif  ($id =~ /^>(\S+)/) {
    return $1;
  } else {
    warn("cannot parse ID for $id\n");
  }
}
