**You can submit these as separate files or a single file with comments**

1. Write a program that will take as command line input some DNA sequences
   letters. Your program should.

	a) Validate that the letters are all valid DNA symbols (A,C,G,T) - print a warning and exit if not
    b) report the number of codons in the sequence
    c) print out the GC content (% of Gs and Cs in the total sequence)

2. Write code to generate a random DNA string of length 100 where the
  frequency of the bases should be A=30% C=20% G=20% T=30%.  Print out
  the sequence to a file. Print out to the screen the total observed
  frequency of all of these letters to see how close the frequency is to your expected.

3. Write code to read a tab delimited data from a file and capture the
   1st column (gene_id) and 5th (FPKM) in this file:
   `/shared/gen220/data_files/expression/Nc20H.expr.tab` or
   [http://courses.stajich.org/public/gen220/data/Nc20H.expr.tab](http://courses.stajich.org/public/gen220/data/Nc20H.expr.tab). Print
   the data out (columns 1 and 5) sorted by the FPKM value largest to
   smallest.

4. Using regular expressions, write code to parse this genbank file
   and print out the number of `gene` features in this file. Extra
   credit for the more advanced - print out the total length of
   all the genes in this file.
   `/shared/gen220/data_files/sequences/D_mel.63B12.gbk`
   (or you can get it from genbank
   [http://www.ncbi.nlm.nih.gov/nuccore/AL021106.1](http://www.ncbi.nlm.nih.gov/nuccore/AL021106.1)
   and save as a text file.
