#An Introduction to Perl

[Jason Stajich](http://lab.stajich.org)  
UC Riverside  
[@hyphaltip](http://twitter.com/hyphaltip) [@stajichlab](http://twitter.com/stajichlab)

---
# Hello World

A basic script
--------------
    !perl
    #!/usr/bin/perl
    print "Hello World.\n";

; to end the line  
**print** to display output (by default will go to your terminal window)    
the \n character is for printing a return at the end of what is printed

To run this, create this text file file called ‘hello.pl’ with this info.
Use a text editors such as ‘nano’, ‘emacs’, ‘vi’, then run on the command line:

    $ perl hello.pl

You can make it executable by doing:

    $ chmod u+x hello.pl
    $ ./hello.pl

---
# Primitives

Comments start with # 

    !perl
    print "some code here, followed by comment"; # here is a comment

Lines end with a ‘;’  
Variables are used to store and access data. Scalar variables start with a ‘$’ and can contain one thing. This can be a string, a number, or a reference. (We’ll talk about References later)

    !perl
    $var1 = "apple";
    $var2 = "orange";
    $var3 = 10;
    $var4 = 17.4312;

Print can also operate on a list of things.

    !perl
    print "Hello there ", $var2, "\n"; 

---
# Strings

Strings are collections of characters. They can be enclosed in single or double quotes. In Perl, many things can be converted to strings too.

    !perl
    print "You're turning into penguin.\n";
    print 'You're turning into penguin.\n'; # this will have an error
    print 'You\'re turning into penguin.\n'; # this will not have an error, but won't turn off 

* ' Single quotes are literally what is in the quotes, no special characters or variable interpolation is done
* " Double quotes will allow for special characters and interpolation
* ` (backquote) is used to execute programs outside of Perl (more on this later)  


---
# Numerics

Numbers can be integers, floating point, scientific notation. They can be initialized and computed. 
Strings can also be converted to numbers.

    !perl
    $x = 10;
    $y = 2.2;
    $z = 1/3;
    print "$x is x, z is $z\n";
    $sum = $x + $y;
    print "sum = $sum\n";
    $string = "12";
    $sum = $string + $x;
    print "sum = $sum\n";
    $sum += 5; # can add to an existing in one line
    $sum /= 5; # or divide by
    print "sum = $sum\n";

---
#String operators

Strings can be manipulated and compared in several ways

    !perl
    $str = "AACTTTGGA";
    print substr($str,3), "\n";   # --> TTTGGA
    print substr($str,6,3), "\n"; # --> GGA

    $rev = reverse $str; # reverse the order
    print $str,"\n",$rev,"\n";

    $len = length $str; # get the sequence length
    print "DNA is $len bp long.\n";

    $index = index($str,"TTG"); # find substring inside a string
    print "first TTG is at $index ", substr($str,$index,3),"\n";

---
#Interpolation

[Interpolation](http://en.wikipedia.org/wiki/Variable_interpolation) is when a variable's value is evaluated and
substituted, for example when you want to insert a value into a string.

    !perl
    $fruit = 'apple';
    print "my favorite fruit is $fruit.\n";
    $fruit = 'grape';
    print "my favorite fruit is $fruit.\n";

This will produce

    my favorite fruit is apple.
    my favorite fruit is grape.

---
#Naming variables

Variable names must contain alphanumeric characters. You can name variables how you like, note that variables cannot start with a number, but can contain numbers. 

    !perl
    $xyz = "ATGCAGTGA"; # not very descriptive
    $protein = "ATGCAGTGA"; # misleading
    $dna_sequence_variable = "ATGCAGTGA"; # needlessly long
    $sequence = "ATGCAGTGA"; # better
    $dna = "ATGCAGTAGA"; # even better

Often we name variables by their use or to describe their use. 
Other convention $i,$j,$k are often counters.
$a and $b are special variable names in some contexts in Perl so try to avoid using these.
---
#Assignment of values

Values from one variable can be copied to another. 

    !perl
    $dollars = 50;
    $cents   = $dollars;
    $cents   *= 100;
    print "$dollars dollars = $cents cents\n";
    
    $x = 100;
    $y = $x;
    print "x=$x y=$y\n"; 
    $x = 50;
    print "x=$x y=$y\n"; # won't change the value of y to update x

---
#Playing it Safe

So far have shown very basic code. Without any warnings turned
out. Only syntax or system errors will cause the program to stop
*without* extra options turned on.  By default Perl will not warn you
about empty or undeclared variables.  To be a **better** programmer
you want to use the following best practices to write better Perl code.

1. use strict
2. use warnings
3. use 'my' to declare variables. This declares them in a particular scope.

   !perl
   $x = 7;
   print "$x and $y\n"

   !perl
   use warnings;
   $x = 7;
   print "$x and $y\n"

   !perl
   use strict;
   use warnings;
   $x = 7;
   print "$x and $y\n";

   use strict;
   use warnings;
   my $x = 7;
   my $y;
   print "$x and $y\n";

   use strict;
   use warnings;
   my $x = 7;
   my $y = 'PRP8';
   print "$x and $y\n";

---
#At the top

Typical boilerplate for your Perl scripts then should usually look like this:

    !perl
    #!/usr/bin/perl
    use strict;
    use warnings;


---
#Some typical errors

Uninitialize variable

    !perl
    use warnings;
    use strict;
    my ($x,$y);
    $x = $y+10;


---
#Scope 

---
#Other numeric operators


---
#Printing


---
#Danger Will Robinson!

Warnings can be useful to print when something is unexpected. One can use the `print STDERR` to print to the error stream.

I also find that using the `warn` command is much more useful.

    !perl
    if( $error_condition == 1 ) {
    	warn("There was a problem sir!\n");
    }

---
#Kill them all

Sometimes you want to exit your program. There may be an unresolvable error, or you want to just finish right there. Two commands are useful for this. 
* One is `exit` which will exit the program. 
* The second is `die` which will print a warning message and exit, or if you fail to include a warning message it will report the line of the error, which can be helpful in debugging if you have lots of code.


