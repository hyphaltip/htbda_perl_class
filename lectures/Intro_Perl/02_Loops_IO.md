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

* Operators equals `==`, less than <, greater than >, less than or equal to <=, greater than or equal to >=   
* ! means take opposite of
* For strings equals is with the `eq`, less than is `lt`, and greater than `gt` 
* Numbers, except for 0 are always true, undefined is always false
* ? :, is a special operator for combing, you can use it to combine a test and performing an operation depending on if the test is true or false. Here we test if a value is bigger than 10, if so set it to 'yes' otherwise set it to 'no'
** `my $is_large = ($val > 10 ? 'yes' : 'no');`

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
  

---
#Scope 

Scope defines the area in a program that variable is valid for. Inside
the brackets ({}) any variable declared with them is valid for that
scope.

    !perl
    my $toy = "Truck";
    my $n = 0;
    print "Toy is $toy before the if\n";
    if( $n < 1 ) {
        my $toy = "Transformer";
        print "Toy is $toy inside the if\n";
    }
    print "Toy is $toy outside the if\n";


If you do not declare the variable inside the loop, you can end up updating the value. Notice the missing 'my' inside the if block.

    !perl
    my $toy = "Truck";
    my $n = 0;
    print "Toy is $toy before the if\n";
    if( $n < 1 ) {
        $toy = "Transformer";
        print "Toy is $toy inside the if\n";
    }
    print "Toy is $toy outside the if\n";


