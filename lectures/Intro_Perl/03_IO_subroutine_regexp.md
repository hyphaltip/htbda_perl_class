#Reading and Writing

* Input data from files
* 

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

   !perl
   open(IN,"grep 'gene' gene.dat | ") || die $!;
   while(my $line = <IN>) {
    print "line is $line\n";
   }


---
#

