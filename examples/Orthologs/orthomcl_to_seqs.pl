#!/usr/bin/perl
use strict;
use warnings;
use Bio::SeqIO;
use Bio::DB::Fasta;

my ($orthomcl_file,$dbfile);

# assume when we run the program will pass 2 arguments
($orthomcl_file,$dbfile) = @ARGV;
my $dbh = Bio::DB::Fasta->new($dbfile);

# perl orthomcl_to_seqs.pl ORTHOMCLFILE DBFILE

#open file for reading orthomcl output
open(my $in => $orthomcl_file) || die " cannot open $orthomcl_file: $!";
# loop to parse the orthomcl data
# data look like
# OG1: GENE1 GENE2 GENE3
my %orthogroup;
my $counter = 0;
while(<$in>) {
 my ($orthname, @genes) = split(/\s+/,$_);
 $orthname =~ s/://;
 $orthogroup{ $orthname } = [ @genes ]; 
 $counter++;
}
print "There are $counter OrthoGroups\n";
my $dirname = "OrthGroups";
mkdir($dirname);
foreach my $group ( keys %orthogroup ) {
 my $out = Bio::SeqIO->new(-file => ">$dirname/$group.fa", 
			   -format => 'fasta');
 foreach my $seqname ( @{ $orthogroup{$group} } ) {
   if( my $seq = $dbh->get_Seq_by_acc($seqname) ) {
        $out->write_seq($seq);
   } else {
	warn("Cannot find sequence $seqname\n");
   }
 }
}
