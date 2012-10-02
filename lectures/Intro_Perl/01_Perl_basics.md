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
#Playing it Safe

---
#Other numeric operators



---
#String operators

Strings can be manipulated and compared in several ways

    !perl
    $str = "AACTTTGGA";
    print substr($str,3), "\n";   # --> TTTGGA
    print substr($str,6,3), "\n"; # --> GGA


[Interpolation](http://en.wikipedia.org/wiki/Variable_interpolation) is when a variable's value is evaluated and
substituted, for example when you want to insert a value into a string.

    !
    $fruit = 'apple';
    
