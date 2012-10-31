Data and scripts for this Tutorial and Lectures are available at [https://github.com/hyphaltip/CSHL_2012_NGS](https://github.com/hyphaltip/CSHL_2012_NGS).



Preparation Steps
=================

1. Checkout my github repo for this course.

Using Git on the command line (or install Git for Mac)

    $git clone git://github.com/hyphaltip/CSHL_2012_NGS.git
 
The rename_seq.pl and other tools are 

1. Download Broad IGV viewer at
[http://www.broadinstitute.org/igv/](http://www.broadinstitute.org/igv/)

2. Download the Saccharomyces genome from [SGD
site](http://downloads.yeastgenome.org/sequence/S288C_reference/genome_releases/S288C_reference_genome_R64-1-1_20110203.tgz). Uncompress this and get the .fsa file which is the genome. 

You could do this like

    $ curl -O http://downloads.yeastgenome.org/sequence/S288C_reference/genome_releases/S288C_reference_genome_R64-1-1_20110203.tgz
    $ tar zxf S288C_reference_genome_R64-1-1_20110203.tgz

Run this script to fix the chromosome names in the download file so the will match the GFF file.

    perl CSHL_2012_NSG/data/rename_seq.pl S288C_reference_genome_R64-1-1_20110203/S288C_reference_sequence_R64-1-1_20110203.fsa > Saccharomyces.fa

  * You need to fix this GFF file so it doesn't have any sequence, to
    do this a grep to find where the '>' lines are where the sequence
    as fasta is in there and find the first one.

Commands to run

    grep -n ">" S288C_reference_genome_R64-1-1_20110203/saccharomyces_cerevisiae_R64-1-1_20110208.gff
    # note the number for the first '>' - there are a few lines before that we want to drop so
    # and the last position in the file we want is 16425 so we can use head 
    $ head -n 16425 S288C_reference_genome_R64-1-1_20110203/saccharomyces_cerevisiae_R64-1-1_20110208.gff > saccharomyces_cerevisiae_R64-1-1_20110208.noseq.gff

  * Use this saccharomyces_cerevisiae_R64-1-1_20110208.noseq.gff for GFF file later needs.

3. [NOT NEEDED FOR THIS TUTORIAL, DATA ARE ALREADY in ~/nextgen/fastq] Downlod the read data from SRA and convert it. You can run the download script (rerequires [curl](http://curl.haxx.se/), [sratoolkit](http://ftp-private.ncbi.nlm.nih.gov/sra/sdk/), and for download speedup [Aspera client](http://downloads.asperasoft.com/download_connect/)

    * For Aspera, get the web client and find the ascp binary and
      put in your path (like ```~/bin```). For example on OSX it installs in
      ```"/Applications/Aspera\ Connect.app/Contents/Resources/ascp"```. so you would copy this file to ```~/bin```

    * The download script to obtain all the data is here
      [https://github.com/hyphaltip/CSHL_2012_NGS/blob/master/data/download.sh](https://github.com/hyphaltip/CSHL_2012_NGS/blob/master/data/download.sh) or in the github repo you checked out - ```CSHL_2012_NGS/data/download.sh```

Tutorial
========

1. Trim FASTQ data for quality using [sickle](https://github.com/najoshi/sickle) - run ```sickle pe``` to see how to run PE options

2. Compare the FASTQC quality report for one of the files (_1 or _2) files both before and after trimming. Set this up in the background so you can run it and do other things in the meantime.

```fastqc -h``` to get help

3. Align reads to the genome using BWA. This requires you to also build and index for the genome. See the [lecture notes](http://hyphaltip.github.com/CSHL_2012_NGS/lecture/NGS_DNA.slides.html#slide34).

3. Fix the Read groups see [this slide](http://hyphaltip.github.com/CSHL_2012_NGS/lecture/NGS_DNA.slides.html#slide51)

4. Realign reads with Picard and GATK [based on lecture](http://hyphaltip.github.com/CSHL_2012_NGS/lecture/NGS_DNA.slides.html#slide40).

1. Call SNPs with SAMTools - refer to the SAMtools manpage on mpileup for more details. [http://samtools.sourceforge.net/](http://samtools.sourceforge.net/)

1. Call SNPs with GATK, using [example from the lecture](http://hyphaltip.github.com/CSHL_2012_NGS/lecture/NGS_DNA.slides.html#slide42)

1. Run Filtering steps on GATK output SNPs to remove potential biased or low-quality ones using options [provided in lecture](http://hyphaltip.github.com/CSHL_2012_NGS/lecture/NGS_DNA.slides.html#slide45).

1. Calculate the total number of remaining SNPs. Count the lines or use [vcftools](http://vcftools.sourceforge.net/).

1. For advanced users, intersect this list of SNPs (in the VCF file)
with the GFF for the genome to determine which SNPs are in coding
regions.  Read up on
[BEDTools](http://code.google.com/p/bedtools/). The genome annotation in GFF is available
in the folder where the genome was downloaded from [SGD](http://yeastgenome.org).

9. Open the genome file for Saccharomces in IGV.  Then add the GFF file as annotation track. Then BAM file, and VCF file in IGV to view the SNPs in context of the gene annotation and the read-depth

Feel free to try this also with your own favorite organism. Many
datasets exist in the [SRA](http://www.ncbi.nlm.nih.gov/sra) from genome resequencing. To extend the
problem, ddownload more than 4 strains so you can apply comparisons between individuals instead of just between one individual and the reference.

For example, here is the [Drosophila reference panel](http://www.ncbi.nlm.nih.gov/bioproject/36679) which included sequencing 192 individuals. Or find something smaller (10 C.elegans for example).

