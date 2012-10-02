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

    {perl}
    print "some code here, followed by comment"; # here is a comment

Lines end with a ‘;’  
Variables are used to store and access data. Scalar variables start with a ‘$’ and can contain one thing. This can be a string, a number, or a reference. (We’ll talk about References later)

    {perl}
    $var1 = "apple";
    $var2 = "orange";
    $var3 = 10;
    $var4 = 17.4312;

---
# Strings

Strings are collections of characters. They can be enclosed in single or double quotes. In Perl, many things can be converted to strings too.

    {perl}
    
