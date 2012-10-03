#Practice Problems for in-class activities 

1. Write a script to print out your name, age, and your zip code.

2. Print out the forward and reverse of the string "DAMMIT I'M MAD"

3. Convert the string "1.6.7.9.90.6.14" into an array. Sort the array numerically and print it back out with tabs separating the numbers.

4. Build a hash that stores the names of some species of animals. The
keys will be the common name and the values are the latin name. For
example you would store "human" matched to "Homo sapiens".  Print out
all the common names in your hash in alphabetical order separted by a newline. Print out the total
number of species you have stored in the hash. How would you instead print out all the latin names?


Problem set for Week 2
=======================

The following sequence will be used to address the next 4 problems. You will write one script which will solve these 4 questions.  

 The accession number of the sequence we will use is 
[NM_001112733.1](http://www.ncbi.nlm.nih.gov/nuccore/NM_001112733.1).

(Hint, you can download this to your computer on the command line via a single UNIX command, it requires using a slightly different URL so I am pasting this in here:  

    curl 'http://eutils.ncbi.nlm.nih.gov/entrez/eutils/efetch.fcgi?db=nucleotide&id=163644330&retmode=text&rettype=fasta' > NM_001112733.1.fasta

You do not need to make your program automatically download this link,
you can download and save it in your folder and cut and paste the
sequence into your script.  For the purposes of the first few problems
you won't need to read any data in from the file.

This is an mRNA sequence so it is already spliced, you don't have to worry about introns.

1. Write a script to process the calculate the total length of this sequence and number of codons in the mRNA sequence. 

2. Actually the sequence is not just the coding sequence, it has [UTRs](http://en.wikipedia.org/wiki/Untranslated_region) (untranslated regions) at the 5' and 3' end of the sequence. To find the start of translation we can search for the first [start codon](http://en.wikipedia.org/wiki/Start_codon) in the sequence. Print out the location of the first potential start codon. Use this to determine the length of the 5' UTR"


3. Assume that start codon is the right one, find the end of the CDS by looking for the stop codon. Do this by scanning for the first in-frame stop codon. To insure you are inframe you will want to extract the sequence starting with your st codon and find the first stop codon.  You will probably need to us a loop to do this.

4. Print out the correct CDS length for this gene. Print out the length of the predicted protein (don't forget to remove the stop codon from that calculation). Print out the length of the 3' UTR.

>Your final script should provide an informative summary of these steps and report should look something like this

    The sequence is of length X bp and there are X codons.  
    The first start codon begins at basepair X, and the in-frame stop codon is at basepair X.  
    The 5' UTR is X bp long and the 3' UTR is X bp long.  
    The CDS length is X bp and the predicted protein length is X.  

>The following 5 sequences are aligned. Define each as a variable.

    AAC35278   LLIAITYYNEDKVLTARTLHGVMQNPAWQKIVVCLVFDGIDPVLATIGV-VMKKDVDGKE
    AnCSMA     AMCLVTCYSEGEEGIRTTLDSIALTPN-SHKSIVVICDGIIKVLRMMRD-TGSKRHNMAK
    AfCHSF     ALCLVTCYSEGEEGIRTTLDSIAMTPN-SHKTIIVICDGIIKVLRMMRD-TGSKRHNMAK
    AAF19527   AILLVTAYSEGELGIRTTLDSIATTPN-SHKTILVICDGIIKVLGMMKD-RGSKRHNMAK
    P30573-1   TINLVTCYSEDEEGIRITLDSIATTPN-SHKLILVICDGIIKVLDMMSDAQGSKRHNMAK

>For example in a hash (but copy in all 5 sequences)
    
    my %sequences;

    $sequence{AAC35278} = "LLIAITYYNEDKVLTARTLHGVMQNPAWQKIVVCLVFDGIDPVLATIGV-VMKKDVDGKE";
    $sequence{AnCSMA} = "AMCLVTCYSEGEEGIRTTLDSIALTPN-SHKSIVVICDGIIKVLRMMRD-TGSKRHNMAK";    

>Alternatively you can also store this in two sets of arrays (but copy in all 5 sequences)


    my @seqnames = ("AAC35278", "AnCSMA");
    my @seqs     = ("LLIAITYYNEDKVLTARTLHGVMQNPAWQKIVVCLVFDGIDPVLATIGV-VMKKDVDGKE","AMCLVTCYSEGEEGIRTTLDSIALTPN-SHKSIVVICDGIIKVLRMMRD-TGSKRHNMAK");

5. Process each sequence and print out for each sequence **the sequence name and number of residues in the sequence** excluding the gaps.

6. Process the whole alignment by processing each sequence and count the number of columns in the alignment which have a gap in ANY sequence. So your script should print out  

    `The number of gapped columns in this alignment is N`

7. Calculate the number of residues that are identical between sequence 'AfCHSF' and 'AAF19527'.  A more advanced solution would be to calculate the number of identical bases between all pairs of sequences so the report will read.

    `Identical residues between AfCHSF and AAF19527 is N`



