use strict;
use warnings;
my @array1 = qw(A B C D);
my @array2 = qw(W X Y Z);
my @array3 = (@array1, @array2);

print join(",", @array3), "\n";

my @array4 = (\@array1, \@array2);
print join(",", @array4),"\n";
foreach my $array ( @array4) {
	print join(",",@{$array}), "\n";
}
push @array1, 'F';
my %genes;
$genes{'A'} = ('100','200');
$genes{'A'} = \@array1;
print $genes{'A'}," is gene A value\n";

print join(",", @{ $genes{'A'} }), " is gene A value\n";


%genes = ();


#GENE123   
#    START  25
#    STOP   50
#    CHROM  ChrI
#GENE112
#    START  78
#    STOP   122
#    CHROM  ChrII

# if want to use array
#$genes{'GENE123'} = [25,50,'ChrI'];
$genes{'GENE123'} = { 'START' => 25,
					  'STOP'  => 50,
					  'CHROM' => 'ChrI'};
					
$genes{'GENE112'}->{'START'} = 78;
print $genes{'GENE112'},"\n";
print ref($genes{'GENE112'}),"\n";
if ( ref( $genes{'GENE112'} ) eq 'HASH' ) {
	
} else {  

}
# $genes{'GENE112'}->[90] = 78; # will get a not array ref error
$genes{'GENE112'}->{'STOP'} = 122;
$genes{'GENE112'}->{'CHROM'} = 'ChrII';

foreach my $genename ( keys %genes ) {
	print "$genename\n";
	#my %val = %{ $genes{$genename} };
	
	print " START ", $genes{$genename}->{'START'},"\n";
	print " STOP ", $genes{$genename}->{'STOP'},"\n";	
	print " CHROM ", $genes{$genename}->{'CHROM'},"\n";
}					



