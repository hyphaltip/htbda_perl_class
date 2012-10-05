#Loops and Conditionals

Logic and control are the next steps in learning a programming language
Loops let us repeat steps.


---
#If, else, elsif

if( *CONDITIONAL* ) {
}

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
#One liners

If statements can be combined onto a single line and can include or not include parentheses.

    !perl
    my $i = 2;
    print "$i is even\n" if $i % 2 == 0;

    $i++;
    print "$i is even\n" if($i % 2 == 0);

---
#Logically speaking

* True && True = True
* True && False = False
* True || True = True
* True || False = True
* ! ( True ) = False
* ! ( False) = True
* ! ( $x && $y ) = !$x || ! $y
* ! ( $x || $y ) = !$x && ! $y

---
#if and unless

`if` will test if something is true and execute the code block. `unless` will test if something is false and then execute the code block.

    !perl
    if( $color eq 'red' || $color eq 'yellow' || $color eq 'orange' ) {
     print "The color is warm\n";
    } elsif( $color eq 'blue' || $color eq 'green' || $color eq 'purple' ) {
     print "The color is cool\n";
    }

Can also be written as 

    unless( $color eq 'red' && $color eq 'yellow' || $color eq 'orange' ) {
     print "The color is warm\n";
    } elsif( $color eq 'blue' || $color eq 'green' || $color eq 'purple' ) {
     print "The color is cool\n";
    }

---
#Some logic

Test if one number is larger than another

    !perl
    if( $num1 > $num3 ) {
      print "$num1 is larger\n";
    }

Test if two strings are equal

    !perl
    if( $str eq 'yellow') {
      print "found a yellow one!\n";
    }


---
#Loop-de-Loop

`while` loops will execute a block of code as long as the conditional is true

`until` is also a way to loop, but will continue as long as the 

    !perl
    my $n = 0;
    while($n < 10) {
     print "n is $n\n";
     $n++;
    }
    $n = 0;
    until($n > 10) {
     print "n is $n\n";
     $n++;
    }
---
#For looping

For loops, much like while loops. There are 3 components. The initialization, the test, and the iteration.

    !perl
    for( my $i = 0; $i < 10; $i++) {
      print "i is $i\n";
    }

The initialization is `my $i = 0`  
The test is `$i < 10`  
The iterator is `$i++`

This could also be written as a while loop.

    !perl
    my $i = 0;
    while($i < 10) {
      $i++:
    }

---
#Loop control

Can Short-circuit a loop with `last`  

    !perl
    my $lightning = 0;
    my $johnny_five = 0;
    while( $johnny_five < 1000 ) {
     if( $lightning == 1 ) {
      print "I'm fried!\n";
      last;
     } else {
      print "I'm alive\n";
     }
     $lightning = int rand(10);
    }

---
#Continuation

Can also continue a loop with `next`, by stopping and going back to the top of the loop.

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


---
#Parenthetically

In some cases you may have seen 

    !perl
    print "hello\n";
    print("hello\n");

Both are valid, Perl will let you get away without parenthesees in many cases. However if it is ambiguous it can cause problems. For example

    use strict;
    use warnings;
    my $str = 'AB-CD';
    print join ",", split "-", $str, "\n";

    print "\n--\n";

    print join(",",split( "-", $str)), "\n";

---
#Combining concepts

Suppose you wanted to process a stream of digits and find where the '01' were.
You could just use index to find it all the occurances.


    !perl
    my $str = "110101210201010011110";
    my $ind = index($str,"01");
    while( $ind > 0 ) {
      # when ind is -1 it means it got to the end of the string
      print substr($str,$ind,2); # print 2 digits
      $ind = index($str,"01",$ind+1);
    }

Note - this is not exactly how you would find specific codons in a DNA
string because `index` is not going to respect the reading frame.

