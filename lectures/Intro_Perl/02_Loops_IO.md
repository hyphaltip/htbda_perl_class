#Loops and Conditionals

Logic and control are the next steps in learning a programming language

---
#If, else, elsif


if( *CONDITIONAL* ) 


    !perl
    my $var = rand(10); # a RANDOM number generator
    if( $var < 3 ) {
     print "Variable ($var) is less than 3\n";
    } elsif( $var <= 5 ) {
     print "Variable ($var) is between 3 and 5\n";
    } else {
     print "Variable ($var) is > 5\n";
    }

---
#The Truth is out there

Operators equals ==, less than <, greater than >, <=, >=   
! means take opposite of

Numbers, except for 0 are always true

---
#Loop-de-Loop

`while` loops will execute a block of code as long as the conditional is true

`until` is also a way to loop, but will continue as long as the 

---
#For looping

For loops, like 

---
#Loop control

Can Short-circuit a loop with `last`  

    !perl
    while( $johnny_five < 1000 ) {
    	   if( $lightning ) {
               warn("I'm fried!\n");
               last;
           }
    }

Can also continue a loop with next, skipping back to the top with `last`

    !perl
    while( <DATA> ) {
       my $row = $_;
       chomp;
       if( substr($row,0,1) eq '#' ) {
       	   # this data has a comment, let's skip the lines starting with #
           next;
       }
    }
  

