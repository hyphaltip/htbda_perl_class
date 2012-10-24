Problems for Week 5 and BioPerl
===============================

You will find the [HOWTOs](http://www.bioperl.org/wiki/HOWTOs) and [Module documentation](http://doc.bioperl.org/bioperl-live/) useful for these problems. The [CPAN version](http://search.cpan.org/~cjfields/BioPerl-1.6.901/) of the documentation is useful as well.

1. Write a script, using BioPerl's [Bio::SeqIO](http://search.cpan.org/~cjfields/BioPerl-1.6.901/Bio/SeqIO.pm), to count the number of sequences in the file and the total length of the sequences. 

2. Using SeqIO, parse all the sequences in this [genbank file](../data/, and generate a report which will print out
    * A count of the number of sequences
    * Total length of CDS features in the database
    * A table which presents the name of the species and number of times they each appear 

3. Use Bio::DB::Fasta to retrieve sequences from a FASTA sequence database

   * Sequence from chrI position 54584..54913
   * Translate this sequence into a protein
   * print out a report with the DNA and protein sequence

4. Parse this [BLAST report](../data/actin-vs-basidio.BLASTP) and print out the following summary

  * For each alignment to the query, print out the E-value, alignment length, and % identity,
    start and stop position of the alignment in the query sequence and and the hit.
    Basically the columns of the output should be:

    QUERY HIT EVALUE LENGTH IDENTITY QSTART QEND HSTART HEND
       

 
