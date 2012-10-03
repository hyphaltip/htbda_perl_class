my @array = ();
    push @array, 'yellow';
    unshift @array, 'red';
    print join(" ", @array),"\n";
    push @array, 'green', 'purple','blue';
    print join(" ", @array),"\n";
    print $array[2], "\n"; # what do you think will be printed here?

    my $str = "AACA-AG-TTTG-TACA";
    my @bases = split('-',$str); 
    print "bases are @bases\n";
    $str = "AACA--AG-TTTG-TACA";
    my @bases = split('-',$str); # this doesn't quite work if there are adjacent gaps
    print "bases are @bases\n";

    $str = "AACA--AG-TTTG-TACA";
    my @bases = split(/\-+/,$str); # this way will work using patterns
    print "bases are @bases\n";

    @array = (1..10);
    print "3 elements starting with 6th one are ", join(" ",splice(@array, 5,3)),"\n";
    splice(@array,2,2,'100');
    print join(" ", @array), "\n";

