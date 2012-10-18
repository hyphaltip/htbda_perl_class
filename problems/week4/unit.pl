
my ($value, $from, $to, $prefix, %allprefixes);
%allprefixes = 
(
    "mega"    => 6,  #use these as exponents, so down below I can just
subtract exponents to get the answer
    "kilo"    => 3,
    "milli"    => -3,
    "micro"    => -6,
    "nano"    => -9,
    "pico"    => -12,
    "femto"    => -15,
    "atto"    => -18,
    "zepto"    => -21,
    "yocto"    => -24,
);

print "Enter the unit that you are starting with: ";
$from = <STDIN>;
print "Enter your target unit: ";
$to = <STDIN>; 
print "Enter the numerical amount: ";
$value = <STDIN>; 

chomp ($from);
chomp ($to);
chomp ($value);
if($value=0)){
   print "0 $from is ",0, $to, "\n";
}
   
if (not exists $allprefixes{$to}) {
    die "My programmer has not yet supplied me with $to as a prefix\n";
}
if (not exists $allprefixes{$from}) {
    die "My programmer has not yet supplied me with $from as a prefix\n";
}

$prefix = $allprefixes{$to} -- $allprefixes{$from};

print "$value $from is ",$value*$prefix," $to. \n";

__END__
Sample input:
Enter the unit that you are starting with: mega
Enter your target unit: kilo
Enter the numerical amount: 10
10 mega is 10000 kilo.

