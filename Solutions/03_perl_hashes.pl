#!/usr/bin/perl 
use warnings;
use strict;

# http://courses.stajich.org/public/gen220/problems/03_IO.html

# here I am showing how to get the data on the fly.
# alternatively you could have downloaded the data already to your 
# directory and you would just open the domain_file, Nc20_file, and Nc3_file
my $domains = 'http://courses.stajich.org/public/gen220/data/Ncrassa_OR74A_InterproDomains.tab';
my $domain_file = 'Ncrassa_OR74A_InterproDomains.tab';

my $Nc20 ='http://courses.stajich.org/public/gen220/data/Nc20H.expr.tab';
my $Nc20_file = 'Nc20H.expr.tab';

my $Nc3  = 'http://courses.stajich.org/public/gen220/data/Nc3H.expr.tab';
my $Nc3_file = 'Nc3H.expr.tab';

# this is a way to get the data from website
open(my $fh => "curl -s $domains |") || die "get the domains failed: $!";

# this is a way to get the data from file you downloaded
#open(my $fh => "$domains |") || die "get the domains failed: $!";


# use this hash to store a lookup of gene name to domain name
# remember that more than one domain can be found for a gene
# so we will have to store a hash for each gene name
# we use a hash because we want the unique set of domains for the gene
my %gene2domain;

while(<$fh>) {
    chomp; # drop the last character if it is whitespace (\n)
    my @row = split(/\t/,$_); # split by tabs to make the string into an array
    my $genename = $row[0]; # first column is the gene name
    my $domain_name = $row[2]; # 3rd column is the domain name
    # store the domains found for this gene 
    # by first looking up the gene, then looking up the domain name
    # and adding one to the count
    $gene2domain{$genename}->{$domain_name}++;
}

# now process the genes in the Nc20 and the Nc5 to store the expression
# value for these genes

my (%gene2exp,%geneinfo);
open($fh => "curl -s $Nc20 |") || die "cannot open $Nc20: $!";
#if you downloaded the files, would use this code instead
#open($fh => $Nc20_file) || die "cannot open $Nc20_file: $!";

# FPKM is the 6th column, so grab that and store it for 
# the gene by expression timepoint
while(<$fh>) {
    chomp; # drop the trailing \n
    next if /^gene_id/; # skip lines that start with the header
    my @row = split(/\t/,$_);
    $gene2exp{$row[0]}->{Nc20} = $row[5];

    if( ! exists  $geneinfo{$row[0]} ) { # check to see if this gene has been stored
	$geneinfo{$row[0]}->{length} = $row[4] - $row[3]; # length is right minus left
	$geneinfo{$row[0]}->{chr} = $row[2]; # chr is the 3rd column
	$geneinfo{$row[0]}->{start} = $row[3]; # start is the 4th column
    }
}

open($fh => "curl -s $Nc3 |") || die "cannot open $Nc3: $!";
#if you downloaded the files, would use this code instead
#open($fh => $Nc3_file) || die "cannot open $Nc3_file: $!";

# FPKM is the 6th column, so grab that and store it for 
# the gene by expression timepoint  
while(<$fh>) {
    chomp; # drop the trailing \n
    next if /^gene_id/; # skip lines that start with the header
    my @row = split(/\t/,$_);
    $gene2exp{$row[0]}->{Nc3} = $row[5];

    if( ! exists  $geneinfo{$row[0]} ) { # check to see if this gene has been stored
	$geneinfo{$row[0]}->{length} = $row[4] - $row[3]; # length is right minus left
	$geneinfo{$row[0]}->{chr} = $row[2]; # chr is the 3rd column
	$geneinfo{$row[0]}->{start} = $row[3]; # start is the 4th column
    }
}

# now print it all out, these will be the columns
#The Gene name (NCUXXXX)
#The gene length (use the left and right information from either the Nc20H or Nc3H file)
#The chromosome name (supercontig)
#The start position of the gene
#The Nc3H FPKM (which is the average gene expression value)
#The Nc20H FPKM
#The list of domains found in the genes

# first print a header

open(my $ofh => ">genes_namesorted.tab") || die $!;
print $ofh join("\t", qw(GENE_NAME GENE_LENGTH CHR START NC3H NC20H DOMAINS)), "\n";
for my $gene ( sort keys %geneinfo) {
    # a default value for the expression if it didn't show up in the file
    my $nc20 = $gene2exp{$gene}->{Nc20};
    my $nc3  =  $gene2exp{$gene}->{Nc3};

    my @domains;
    if( exists $gene2domain{$gene} ) {
	@domains = sort keys %{$gene2domain{$gene}};
    }
    print $ofh join("\t", 
		    $gene, 
		    $geneinfo{$gene}->{length},
		    $geneinfo{$gene}->{chr},
		    $geneinfo{$gene}->{start},
		    $nc20,
		    $nc3,
		    join(",", @domains)), "\n";		    
}



open($ofh => ">genes_sorted_by_length.tab") || die $!;
print $ofh join("\t", qw(GENE_NAME GENE_LENGTH CHR START NC3H NC20H DOMAINS)), "\n";
# lookup the length by using the $a and $b variables in sort
# to then get the value for the gene length
for my $gene ( sort { $geneinfo{$a}->{length} <=> $geneinfo{$b}->{length} } 
	       keys %geneinfo) {
    # a default value for the expression if it didn't show up in the file
    my $nc20 = $gene2exp{$gene}->{Nc20};
    my $nc3  = $gene2exp{$gene}->{Nc3};

    my @domains;
    if( exists $gene2domain{$gene} ) {
	@domains = sort keys %{$gene2domain{$gene}};
    }
    print $ofh join("\t", 
		    $gene, 
		    $geneinfo{$gene}->{length},
		    $geneinfo{$gene}->{chr},
		    $geneinfo{$gene}->{start},
		    $nc20,
		    $nc3,
		    join(",", @domains)), "\n";		    
}

open($ofh => ">genes_sorted_by_Nc3H.tab") || die $!;
print $ofh join("\t", qw(GENE_NAME GENE_LENGTH CHR START NC3H NC20H DOMAINS)), "\n";
# for highest to lowest sorting, you need to compare it as b to a
for my $gene ( sort { 
    $gene2exp{$b}->{Nc3} <=>
		      $gene2exp{$a}->{Nc3} }
	       keys %geneinfo) {
    # a default value for the expression if it didn't show up in the file
    my $nc20 = $gene2exp{$gene}->{Nc20};
    my $nc3  = $gene2exp{$gene}->{Nc3};
    my @domains;
    if( exists $gene2domain{$gene} ) {
	@domains = sort keys %{$gene2domain{$gene}};
    }
    print $ofh join("\t", 
		    $gene, 
		    $geneinfo{$gene}->{length},
		    $geneinfo{$gene}->{chr},
		    $geneinfo{$gene}->{start},
		    $nc20,
		    $nc3,
		    join(",", @domains)), "\n";		    
}


open($ofh => ">genes_sorted_by_Nc20H.tab") || die $!;
print $ofh join("\t", qw(GENE_NAME GENE_LENGTH CHR START NC3H NC20H DOMAINS)), "\n";
# for highest to lowest sorting, you need to compare it as b to a
for my $gene ( sort { $gene2exp{$b}->{Nc20} <=>
		      $gene2exp{$a}->{Nc20} }
	       keys %geneinfo) {
    # a default value for the expression if it didn't show up in the file
    my $nc20 = $gene2exp{$gene}->{Nc20};
    my $nc3  = $gene2exp{$gene}->{Nc3};

    my @domains;
    if( exists $gene2domain{$gene} ) {
	@domains = sort keys %{$gene2domain{$gene}};
    }
    print $ofh join("\t", 
		    $gene, 
		    $geneinfo{$gene}->{length},
		    $geneinfo{$gene}->{chr},
		    $geneinfo{$gene}->{start},
		    $nc20,
		    $nc3,
		    join(",", @domains)), "\n";		    
}


open($ofh => ">genes_sorted_by_chrom_position.tab") || die $!;
print $ofh join("\t", qw(GENE_NAME GENE_LENGTH CHR START NC3H NC20H DOMAINS)), "\n";
# for highest to lowest sorting, you need to compare it as b to a
for my $gene ( sort { $geneinfo{$a}->{chr} cmp $geneinfo{$b}->{chr} ||
		      $geneinfo{$a}->{start} <=> $geneinfo{$b}->{start} 
	       } keys %geneinfo) {
    # a default value for the expression if it didn't show up in the file
    my $nc20 = $gene2exp{$gene}->{Nc20};
    my $nc3  = $gene2exp{$gene}->{Nc3};

    my @domains;
    if( exists $gene2domain{$gene} ) {
	@domains = sort keys %{$gene2domain{$gene}};
    }
    print $ofh join("\t", 
		    $gene, 
		    $geneinfo{$gene}->{length},
		    $geneinfo{$gene}->{chr},
		    $geneinfo{$gene}->{start},
		    $nc20,
		    $nc3,
		    join(",", @domains)), "\n";		    
}



