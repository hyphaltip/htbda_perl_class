#Reading and Writing

* Input data from files
* Read data from a program
* Print data into a file or print data out to a program

---
#Input/Ouput

    !perl
    open(IN, "input.txt") || die $!;
    # read a line in
    my $line = <IN>;
    # read the whole file
    while(<IN>) {
     my ($col1, $col2) = split;    
    }      
    close(IN);


---
#Filehandles

Filehandles can also be stored in variables

    !perl
    my $fh;
    open($fh => "gene.dat") || die $!;
    while(<$fh>) {
     print $_;
    }
    #I like to use this in one line
    open(my $fh2 => "gene2.dat") || die $!;
    while(<$fh2>) {
     print $_;
    }

---
#Writing to a file

One can also write data out to a file

    !perl
    open(my $fh => ">outputfile.txt") || die $!;
    print $fh join("\t", qw(NAME RANK TOWN)), "\n";
    print $fh join("\t", qw(GRIFFITH SHERIFF MAYBERRY)), "\n";
    print $fh join("\t", qw(RAWLS DEPUTY BALTIMORE)), "\n";
    close($fh);

---
#Data embedded in a script

    !perl
    while(<DATA>) {
     my ($col1,$col2) = split(/\s+/,$_);
    }
   
    __DATA__
    Color  Size Model
    red    10   Jumbo
    yellow 8    Large
    pink   2    Mini

---
#Pipes for processes

You can combine operations that are on the command line with the `|`
operator in UNIX. This can also be used in Perl when specifying an
`open` command to actually run a program and have the output sent back
to the Perl program.  This can be used to obtain data from a
program. For example here we run the grep cmmand to find lines in a
file that have the string 'gene'. Only those lines will be returned
and thus be seen by the Perl program. 

    !perl
    open(IN,"grep 'gene' gene.dat | ") || die $!;
    while(my $line = <IN>) {
     print "line is $line\n";
    }


Or it can be used to send data to a program. For example this script
will print out data to a program which will then compress the
data. Notice how the pipe comes at the beginning because we plan to
send data into the program.

    !perl
    open(my $fh => "| gzip -c > file.gz") || die $!;
    print "hello there\n";
    print "can you see this?\n";

Now look at the file in your directory. It is compressed - you can
read it with `more` and see it is binary file. However you can read it
with `zmore` or you can uncompress it with `gunzip`.

---
#Pipe trick

Can use it to open a compressed file on the fly.

    !perl
    open(my $fh => "zcat file.gz |") || die $!;
    while(<$fh>) {
     # process data in a file that was compressed, without making a new copy of the file as uncompressed
    }

---
#Read data from the web with cmdline


    !perl
    my $url = 'http://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=nucleotide&id=163644330&retmode=text&rettype=fasta';
    # -S option will not print any statistics
    open(my $fh => "curl -S '$url' |") || die $!;
    while(<$fh>) {
      print $_;
    }

    open($fh => "GET '$url' |") || die $!;
    while(<$fh>) {
      print $_;
    }

---
#Let's try this together

Login to biocluster, Download data files. Data are in this [http://courses.stajich.org/public/gen220/data/](directory) which represent some time points in growth for a fungus.

> [http://courses.stajich.org/public/gen220/data/Nc20H.expr.tab](http://courses.stajich.org/public/gen220/data/Nc20H.expr.tab)
> [http://courses.stajich.org/public/gen220/data/Nc3H.expr.tab](http://courses.stajich.org/public/gen220/data/Nc3H.expr.tab)

Write a script to read in the Nc20H and Nc3H data into a hash (one
hash for each datafile). Store in the hash the gene name (the 1st
column) and the FPKM data. Each gene will appear once in each file.

* Print out a new file which has the gene name, the expression in 3H and the expression in 20H.
* Extra - print it out so that it is sorted by the 3HR timepoint

---
#A solution

    !perl
    use strict;
    use warnings;
    my (%expr3H,%expr20H);
    open(my $fh => 'Nc3H.expr.tab') || die $!;
    while(<$fh>) {
     my @row = split("\t",$_);
     next if $row[0] eq 'gene_id'; # skip when it is the header line
     $expr3H{$row[0]} = $row[5];
    }
    
    open($fh => 'Nc20H.expr.tab') || die $!;
    while(<$fh>) {
     my @row = split("\t",$_);
     next if $row[0] eq 'gene_id'; # skip when it is the header line
     $expr20H{$row[0]} = $row[5];
    }
    
    open(my $outfh => ">Combined.tab") || die $!;
    for my $gene ( keys %expr3H) {
     print $outfh join("\t", $gene, $expr3H{$gene}, $expr20H{$gene}), "\n";
    }
    
    open($outfh => ">Combined_sorted.tab") || die $!;
    for my $gene ( sort { $expr3H{$b} <=> $expr3H{$a} } keys %expr3H) {
     print $outfh join("\t", $gene, $expr3H{$gene}, $expr20H{$gene}), "\n";
    }

---
#References

Reference are ways to refer to a complicated data structures as a
single, scalar value. This lets one pass around multiple arrays and
they stay separate. We also primarily use reference to store multiple
things in a slot in an array.  

* Reference to an array is done with `\` or `[]`
* Reference to a hash is done with `\` or `{}`

For example this lets one pass around multiple
arrays and they aren't flattened into one. Consider this code.

    !perl
    my @array1 = qw(A B C D);
    my @array2 = qw(W X Y Z);
    my @array3 = (@array1, @array2);

    print join(",", @array3), "\n";

---
#Storing multiple items in an Array

    [ 0 | 1 | 2 ]
      |   |
      |   -------------------------
     { apple => 'red' ,           |
       turtle => 'green' }      { bannana => 'yellow',
                                  pig     => 'pink' }


Often we use this approach to store multiple things for a single key
in hash too. What if a gene has mutiple protein domains, function, or
other information you wanted to store for it?

> [http://courses.stajich.org/public/gen220/data/Nc3H.expr.tab](http://courses.stajich.org/public/gen220/data/Nc3H.expr.tab)
> [http://courses.stajich.org/public/gen220/data/Ncrassa_OR74A_InterproDomains.tab](Ncrassa_OR74A_InterproDomains.tab)

    !perl
    my $url = 'http://courses.stajich.org/public/gen220/data/Ncrassa_OR74A_InterproDomains.tab';
    open(my $fh => "GET $url |") || die $!;
    my %genes;
    while(<$fh>) {
    	my ($gene,$domain, $domain_name, $start,$end,$score) = split;
	# store an array in for each of the 
	push @{$genes{$gene}}, $domain_name;
    }    
    # now unpack to print this out
    for my $gene ( keys %genes ) {
    	my @domains = @{$genes{$gene}};
	print join("\t", $gene, join(",", @domains)), "\n";
    } 

---
#Subroutines

    !perl
    sub a_routine {
     my @args = @_; # the arguments passed in are avaialable as @_;
     print "the arguments are ", join(",", @args), "\n";
    }
    &a_routine('a','b','c');

---
#Command line arguments
   
    $ perl myscript.pl A B C

    !perl
    print join(",", @ARGS), "\n";
    print "the first argument is ", $ARGS[0], "\n";
 
    A,B,C

Use this to specify a data file to read in, or specific options you want to run.

---
#Practice

Write a script that will open and print out the first 5 lines of a
file. The name of the file to open should be passed in on the command line as
the first argument.



