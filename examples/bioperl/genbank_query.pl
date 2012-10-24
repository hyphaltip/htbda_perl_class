use strict;
use Bio::DB::GenBank;
use Bio::SeqIO;

my $out = Bio::SeqIO->new(-format => 'genbank');
my $dbh = Bio::DB::GenBank->new;
my $query = 'MUSIGHBA1';
my $seq = $dbh->get_Seq_by_acc($query);
if( $seq ) {
 $out->write_seq($seq);
} else {
 warn("cannot find sequence $query\n");
}
