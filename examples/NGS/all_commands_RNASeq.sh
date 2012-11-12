#PBS -l nodes=1:ppn=4

# link in the data from the shared folder, no need to copy, just symlink with ln -s
ln -s /srv/projects/db/GEN220/RNAseq/yeast_15hrs_fermentation.fastq  .
ln -s /srv/projects/db/GEN220/RNAseq/yeast_1hr_fermentation.fastq  .


module load tophat/2.0.5
module load cufflinks/2.0.2
module load bowtie2

git clone git://github.com/hyphaltip/htbda_perl_class.git

# uncompress the genome file which came from 
# http://downloads.yeastgenome.org/sequence/S288C_reference/genome_releases/S288C_reference_genome_R64-1-1_20110203.tgz
tar zxf /srv/projects/db/GEN220/S288C_reference_genome_R64-1-1_20110203.tgz
# convert the chromsome names to chrI, chrII from ref|NC_XXXX 
perl htbda_perl_class/examples/NGS/rename_seq.pl S288C_reference_genome_R64-1-1_20110203/S288C_reference_sequence_R64-1-1_20110203.fsa > Saccharomyces.fa

# extract the first 16425 lines of the GFF file so the sequence that is appended at the end can be ignore
head -n 16425 S288C_reference_genome_R64-1-1_20110203/saccharomyces_cerevisiae_R64-1-1_20110208.gff > saccharomyces_cerevisiae_R64-1-1_20110208.noseq.gff

#Let's locate all the genome files in this genome directory
mkdir -p genome
mv Saccharomyces.fa genome
cp saccharomyces_cerevisiae_R64-1-1_20110208.noseq.gff genome/Saccharomyces.gff
bowtie2-build genome/Saccharomyces.fa genome/Saccharomyces

# -I max intron length in saccharomyces is ~300 bp - for animals this would be much bigger
tophat -p 4 -I 500 -G genome/Saccharomyces.gff -o tophat_yeast1hr genome/Saccharomyces yeast_1hr_fermentation.fastq 
tophat -p 4 -I 500 -G genome/Saccharomyces.gff -o tophat_yeast15hr genome/Saccharomyces yeast_15hrs_fermentation.fastq 

cufflinks -p 4 -o cufflinks_yeast1hr -G genome/Saccharomyces.gff tophat_yeast1hr/accepted_hits.bam 
cufflinks -p 4 -o cufflinks_yeast15hr -G genome/Saccharomyces.gff tophat_yeast15hr/accepted_hits.bam 

cuffdiff -p 4 -o cuffdiff -G genome/Saccharomyces.gff tophat_yeast1hr/accepted_hits.bam tophat_yeast15hr/accepted_hits.bam  -L Yeast_1hr,Yeast_15hr
