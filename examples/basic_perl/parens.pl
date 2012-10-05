use strict;
use warnings;
my $str = 'AB-CD';
print join ",", split "-", $str, "\n";

print "\n--\n";

print join(",",split( "-", $str)), "\n";

