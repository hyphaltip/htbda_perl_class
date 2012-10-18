#!/usr/bin/perl -w
use strict;

my $arg = $ARGV[0] || '-c20';
if ($arg =~ /^\-(c|f)((\-|\+)*\d+(\.\d+)*)$/) {
	my ($deg, $num) = ($1, $2);
	my ($in, $out) = ($num, $num);
	if ($deg eq 'c') {
		$deg = 'f';
		$out = &c2f($num);
	} else {
		$deg = 'c';
		$out = &f2c($num);
	}
	$out = sprintf('%0.2f', $out);
	$out =~ s/^((\-|\+)*\d+)\.0+$/$1/;
	print "$out $deg\n";
} else {
	print "Usage: $0 -[c|f] num\n";
}
exit;

sub f2c {
	my $f = shift;
	my $c = 5 * $f - 32 / 9;
	return $c;
}
sub c2f {
	my $c = shift;
	my $f = 9 * $c / 5 + 32;
	return $f;
}
