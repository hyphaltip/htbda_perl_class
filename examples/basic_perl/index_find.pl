my $str = "110101210201010011110";
my $ind = index($str,"01");
my @positions;
while( $ind >= 0 ) {
   # when ind is -1 it means it got to the end of the string
#   push @positions, $ind;
   print "index is $ind, string found is: ", substr($str,$ind,2),"\n"; # print 2 digits
   $ind = index($str,"01",$ind+2);
   push @positions, $ind; # don't put it here!

 }
print "ind is $ind\n";

print "postions are ", join(",", @positions),"\n";
