#!/usr/bin/perl -w
use strict;
use Bio::SeqIO;
my $in = Bio::SeqIO->new(-format => 'swiss',
                         -file   => 'rel9.swiss');
while( my $seq = $in->next_seq ) {
 my $collection = $seq->annotation;
 my @types = $collection->get_all_annotation_keys;
 print "types are @types\n";
 my @dblinks = $collection->get_Annotations('dblink');
 for my $dblink ( @dblinks ) {
   printf "%s:%s \n", $dblink->database, $dblink->primary_id .
     (defined $dblink->version ? ".".$dblink->version : '');
 }
}
