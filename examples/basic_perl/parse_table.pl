#!/usr/bin/perl 
use strict;
use warnings;

open(my $fh => 'Nc20H.expr.tab') || die $!;

my $i = 0;
my %genes;
my $header = <$fh>;
my $genename;
while(<$fh>) {
	chomp; # remove the last newline
	my @row = split(/\t/,$_);
	$genename = $row[0];
	my $left = $row[3];
	my $right = $row[4];
#	$genes{$genename}->{'left'} =$left;
#	$genes{$genename}->{'right'} =$right;
	my %vals = ( left => $left, right => $right);
	$genes{$genename} = \%vals;
	$genes{$genename} = { left => $left, right => $right };
	last if $i++ > 10;
}
foreach my $gene ( sort keys %genes ) {
	my $length = $genes{$genename}->{'right'} - $genes{$gene}->{'left'};
	print "$gene is $length bases long\n";	
}