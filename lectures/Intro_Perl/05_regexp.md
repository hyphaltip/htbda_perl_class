#regular expressions

    !perl
    if( $string =~ /[A-Z]/) {
    }

---
#Patterns

* $str =~ /match/
* $str =~ m!match!  # use m to specify the separator
* $str =~ s/from/to/ # replace
* $str =~ tr/[A-Z]/[a-z]/ #translate

---
#Reverse complement

my $str = 'AGCATA';
$str =~ tr/ACGT/TGCA/;
my $rev = reverse($str);

---
#Pattern types

* \d - number
* \s - whitespeace
* \D - NOT a number
* \S - NOT whitespace

* \d+ - a number 1 to many times
* \d* - a number 0 to many times

---
#try this

my @strs = qw(GENE124 GENE112 GENE180 GENEX321);

for my $str ( @strs ) {

    if( $str =~ /GENE\d+/ ) {
    	print $str, "\n";
    }
}



