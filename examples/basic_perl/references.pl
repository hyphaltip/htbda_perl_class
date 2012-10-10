#!/usr/bin/perl
use strict;
use warnings;


my $str = "AAGAG";

my $str_ref = \$str;

print "String: $str Ref: $str_ref\n";
print "De-ref Ref:",$$str_ref,"\n";


my @array = (20,50,60);

my $array_ref = \@array;

print "Array: @array Ref: $array_ref\n";
print "Deref Ref: ",join(",",@$array_ref),"\n";

my %ha = ('apple' => 'green', 'bannana' => 'yellow');

my $hash_ref = \%ha;

print "Hash: ",join(",",keys %ha)," Ref: $hash_ref\n";
print "Deref Ref: ",join(",",keys %$hash_ref),"\n";

$hash_ref->{orange} = 'orange';
print "Hash: ",join(",",keys %ha)," Ref: $hash_ref\n";
print "Deref Ref: ",join(",",keys %$hash_ref),"\n";

print "\n";
my $hash_ref2 = {%ha};
$hash_ref2->{grape} = 'purple';
print "Hash: ",join(",",keys %ha)," Ref: $hash_ref\n";
print "Deref Ref: ",join(",",keys %$hash_ref),"\n";
print "Deref Ref2: ",join(",",keys %$hash_ref2),"\n";

print "\n==\n";

my $url = 'http://courses.stajich.org/public/gen220/data/Ncrassa_OR74A_InterproDomains.tab';
open(my $fh => "curl $url |") || die $!;
my %genes;
while(<$fh>) {
    	my ($gene,$domain, $domain_name, $start,$end,$score) = split;
	# store an array in for each of the 
	push @{$genes{$gene}}, $domain_name;
}
# now unpack to print this out
open(my $ofh =>">domain_list.tab") || die $!;
for my $gene ( keys %genes ) {
  my @domains = @{$genes{$gene}};
  print $ofh join("\t", $gene, join(",", @domains)), "\n";
} 


open($fh => "curl $url |") || die $!;
%genes = (); # reset genes to empty hash
while(<$fh>) {
    	my ($gene,$domain, $domain_name, $start,$end,$score) = split;
	# store an array in for each of the 
	$genes{$gene}->{$domain_name}++;
}

open($ofh =>">domain_uniq.tab") || die $!;
# now unpack to print this out
for my $gene ( keys %genes ) {
  my @domains = keys %{$genes{$gene}};
  print $ofh join("\t", $gene, join(",", @domains)), "\n";
}

# now unpack to print this out, where we print the counts for each domain
open($ofh =>">domain_uniq_count.tab") || die $!;
for my $gene ( keys %genes ) {
  my @domains = sort keys %{$genes{$gene}};
  my @domain_info;
  for my $domain ( @domains ) {
    push @domain_info, sprintf("%s=%d",$domain,$genes{$gene}->{$domain});
  }
  print $ofh join("\t", $gene, join(",", @domain_info)), "\n";
}
open($ofh =>">domain_uniq_count_sorted.tab") || die $!;
for my $gene ( keys %genes ) {
  # sort by the number of copies of each domain
  my @domains = sort { $genes{$gene}->{$b} <=> $genes{$gene}->{$a} } keys %{$genes{$gene}};
  my @domain_info;
  for my $domain ( @domains ) {
    push @domain_info, sprintf("%s=%d",$domain,$genes{$gene}->{$domain});
  }
  print $ofh join("\t", $gene, join(",", @domain_info)), "\n";
}




