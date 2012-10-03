    $dollars = 50;
    $cents   = $dollars;
    $cents   *= 100;
    print "$dollars dollars = $cents cents\n";
    
    $x = 100;
    $y = $x;
    print "x=$x y=$y\n"; 
    $x = 50;
    print "x=$x y=$y\n"; # won't change the value of y to update x
