Practice problems week #4

1. Fix syntax or run-time errors in the following scripts:

* [print_line_num.pl](week4/print_line_num.pl) (use “print_line_input.txt” as input file)
* [sum.pl](week4/sum.pl)
* [temp_convert.pl](week4/temp_convert.pl)
* [unit.pl](week4/unit.pl)

These scripts will be on the biocluster under /home/rliu/GEN220 and
will be also posted to the GEN220 course website (linked above).

2. Colin McMillen used a Perl script “propose.pl” to ask Kristen
Stubbs to marry him. The script is cute, but not very readable. Please
reformat this script so that it follows the conventions for “beautiful
code”. You may add comments or change variable names if you want, but
the output should be the same.

* script [propose.pl](week4/propose.pl) 

Additional Practice problems for week #4:

3.  After you have fixed all syntax or run-time errors in
“temp_convert.pl” (in problem (1)), create a package “Temperature.pm”
and put the two sub routines in “temp_convert.pl” in this
package. Then modify temp_convert.pl so it calls functions from
Temperature.pm. Test your script using commands 

    “perl temp_convert.pl –c30” 
and 

   “perl temp_convert.pl –F60” 

and put your output in file “temp_out.txt” (two numbers, one number
per line).

4. Download module “Statistics::Descriptive” from
[Statistics::Descriptive](http://search.cpan.org/~shlomif/Statistics-Descriptive-3.0604/lib/Statistics/Descriptive.pm)
and install it in your home directory under "lib” in your home directory. For example, my home directory is /home/rliu, I would install it under
/home/rliu/lib. You will need to use a command such as 

    “perl Makefile.PL PREFIX=/home/rliu/lib” 

A shortcut is to use the UNIX environment variable $HOME and install it with

    “perl Makefile.PL PREFIX=$HOME/lib” 

(and a few other commands. Find out these commands by a search engine)
for installation. After installation, write a script named
“average.pl” to call functions in this module to calculate the sum and
average of integers from 1 to 100 (inclusive). You should output two
numbers (separated by a space) to a file named “average.txt”.
