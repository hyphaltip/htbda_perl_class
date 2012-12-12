#!/usr/bin/perl
use strict;
use warnings;

use Bio::SeqIO;
use Bio::SearchIO;
use Bio::DB::Fasta;

# download the sequence database
my $gbkfile = 'sample_seqs.gbk';
my $dbfile = 'sacharomyces_cerevisiae_S288C.fa';

if( ! -f $dbfile ) {
    `curl -s -C - -O http://courses.stajich.org/public/gen220/data/sacharomyces_cerevisiae_S288C.fa`;
}

if( ! -f $gbkfile ) {
`curl -s -C - -O http://courses.stajich.org/public/gen220/data/sample_seqs.gbk`;
}
# BLAST file download
my $blastfile = 'actin-vs-basidio.BLASTP';
if( ! -f $blastfile ) {
    `curl -s -C - -O http://courses.stajich.org/public/gen220/data/actin-vs-basidio.BLASTP`;
}

# PROBLEM 1
my $seqio = Bio::SeqIO->new(-format => 'fasta',
			    -file   => $dbfile);

my ($sequence_count,$total_length);
while( my $seq = $seqio->next_seq ) {
    $sequence_count++;
    $total_length += $seq->length;
}
print "Problem 1:\n";
print "there are $sequence_count sequences in $dbfile\n";
print "total length is $total_length\n";

# PROBLEM 2
$seqio = Bio::SeqIO->new(-format => 'genbank',
			 -file   => $gbkfile);
$sequence_count = 0;
my ($cds_feature_no, $cds_feature_length);
my %species_count;
# parse the sequences from the file
while( my $s = $seqio->next_seq ) {
    $sequence_count++;
    # get the species info as a binomial string
    my $species = $s->species->binomial();
    
    # process all the sequence features
    for my $f ( $s->get_SeqFeatures() ) {
	# but only process those which are CDS features otherwise skip
	next unless $f->primary_tag eq 'CDS';
	$cds_feature_no++;
	# get the lenght of the feature and add it to the total lengths
	$cds_feature_length += $f->length;
    }
    $species_count{$species}++;
}
print "--\n";
print "Problem 2:\n";
print "There are $sequence_count sequences in $gbkfile\n";
print "There are $cds_feature_no CDS features totalling $cds_feature_length bases pairs\n";
# sort by the total number seen so most abundant is at top
print "The species distribution is \n";
for my $species ( sort { $species_count{$b} <=> $species_count{$a} } 
		  keys %species_count ) {
    print join( "\t", $species, $species_count{$species}), "\n";
}

print "--\n";
print "Problem 3:\n";

my $dbh = Bio::DB::Fasta->new($dbfile);

my $segment1 = $dbh->seq('chrI', 54584 => 54913);
print "seq segment is $segment1\n";

my $seqobj = Bio::Seq->new(-seq => $segment1);
my $protein = $seqobj->translate;

print "protein seq is ", $protein->seq, "\n";

print "--\n";
print "Problem 4:\n";
my $in = Bio::SearchIO->new(-format => 'blast', -file => $blastfile);

while( my $r = $in->next_result ) {
    while( my $hit = $r->next_hit ) {
	while( my $hsp = $hit->next_hsp ) {
	    print join("\t",
		       $r->query_name,
		       $hit->name,
		       $hsp->evalue,
		       $hsp->length,
		       sprintf("%.2f",$hsp->frac_identical * 100),
		       $hsp->query->start,
		       $hsp->query->end,
		       $hsp->subject->start,
		       $hsp->subject->end), "\n";
	}
    }    
}

