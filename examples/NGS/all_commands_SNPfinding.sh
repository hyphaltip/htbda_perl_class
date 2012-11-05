mkdir NGS_DNA_SNPs
cd NGS_DNA_SNPs
# clone the repository with some useful scripts for the class
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

# include some programs in our path on the biocluster system (would be different on other systems)
module load bwa
module load samtools
module load GATK
module load picard
module load sickle

# index the genome for alignment
if [ ! -f genome/Saccharomyces.bwt ]; then
 bwa index -p genome/Saccharomyces genome/Saccharomyces.fa
fi

# let's make a link to the already downloaded FASTQ data for this project
if [ ! -d fastq ]; then
 ln -s /srv/projects/db/GEN220/fastq fastq
fi

# trim some reads before processing
# This strain is W303 of yeast, you can either use this short name or the original SRR567756 if you like
if [ ! -f  W303_1.fq ]; then
 sickle pe -f fastq/SRR567756_1.fastq -r fastq/SRR567756_2.fastq -o W303_1.fq -p W303_2.fq -s W303_unpaired.fq -t sanger -q 20 -l 50
fi

if [ ! -f W303_1.sai ]; then
 bwa aln -t 4 -q 20 genome/Saccharomyces W303_1.fq > W303_1.sai
 bwa aln -t 4 -q 20 genome/Saccharomyces W303_2.fq > W303_2.sai
fi

#make the SAM file, then the BAM file as a sorted file
if [ ! -f W303.bam ]; then
 # make the SAM file by combining the two parts of the paired set with BWA
 bwa sampe genome/Saccharomyces W303_1.sai W303_2.sai W303_1.fq W303_2.fq > W303.sam
 # now convert the SAM file into a BAM file  and sort at same time, Ask for 3gb of memory in case this is big
 # datafile
 java -Xmx3g -jar $PICARD/SortSam.jar I=W303.sam O=W303.bam SORT_ORDER=coordinate VALIDATION_STRINGENCY=SILENT CREATE_INDEX=TRUE
 samtools flagstat W303.bam > W303.flagstat
fi

# Mark duplicate reads (usually where the forward and reverse are identical, indicating a
# PCR bias
if [ ! -f W303.dedup.bam ]; then
java -Xmx2g -jar $PICARD/MarkDuplicates.jar I=W303.bam \
  O=W303.dedup.bam METRICS_FILE=W303.dedup.metrics \
  CREATE_INDEX=true VALIDATION_STRINGENCY=SILENT
 samtools flagstat W303.dedup.bam > W303.dedup.flagstat
fi

# COMPARE the un-deduplicated file stats (W303.flagstat) with the duplicates marked to get a sense of duplication
# in the Illumina run (sometimes due to chemistry of the run) W303.dedup.flagstat

echo "Original flagstat is "
cat W303.flagstat
echo "Dedup flagstat is "
cat W303.dedup.flagstat

# Fix the ReadGroups - required by GATK
# right now the read groups aren't set in the depdup.bam file
if [ ! -f W303.RG.bam ]; then
 java -Xmx2g -jar $PICARD/AddOrReplaceReadGroups.jar I=W303.dedup.bam O=W303.RG.bam \
  SORT_ORDER=coordinate CREATE_INDEX=TRUE \
   RGID=W303 RGLB=SRR527545 RGPL=Illumina RGPU=Genomic RGSM=W303 \
   VALIDATION_STRINGENCY=SILENT
fi

# Identify where the variants are to realign around these
# this includes Indels
if [ ! -f W303.intervals ]; then
 java -Xmx2g -jar $GATK -T RealignerTargetCreator \
 -R genome/Saccharomyces.fa \
 -o W303.intervals -I W303.RG.bam
fi

# realign the BAM file based on the intervals where there are polymorphism
if [ ! -f W303.realign.bam ]; then
 java -Xmx2g -jar $GATK -T IndelRealigner \
  -R genome/Saccharomyces.fa \
  -targetIntervals W303.intervals -I W303.RG.bam -o W303.realign.bam
fi

# Call the SNPs from this BAM file generating a VCF file
# using 4 threads (-nt 4) and only calling SNPs, INDELs could be call too
# with the -glm BOTH or -glm INDEL
if [ ! -f  W303.GATK.vcf ]; then
java -Xmx3g -jar $GATK -T UnifiedGenotyper \
  -glm SNP -I W303.realign.bam -R genome/Saccharomyces.fa \
  -o W303.GATK.vcf -nt 4
fi

# run the filtering to mark low-quality SNPs
# See this for more information on best practices
# http://www.broadinstitute.org/gatk/guide/topic?name=best-practices
if [ ! -f W303.GATK_filtered.vcf ]; then
    java -Xmx3g -jar $GATK  \
    -T VariantFiltration -o W303.GATK_filtered.vcf \
    --variant W303.GATK.vcf -R genome/Saccharomyces.fa \
    --clusterWindowSize 10  -filter "QD<2.0" -filterName QualByDepth \
    -filter "MQ<=40.0" -filterName MapQual \
    -filter "HRun>=4" -filterName HomopolymerRun \
    -filter "QUAL<100" -filterName QScore \
    -filter "MQ0>=10 && ((MQ0 / (1.0 * DP)) > 0.1)" -filterName MapQualRatio \
    -filter "FS>60.0" -filterName FisherStrandBias \
    -filter "MQRankSum < -12.5" -filterName MQRankSum  \
    -filter "ReadPosRankSum < -8.0" -filterName ReadPosRankSum  >& W303.filter.log
fi

# now only select the variants which are NOT filtered to be output
if [ ! -f W303.GATK_selected.vcf ]; then
 java -Xmx3g -jar $GATK \
  -T SelectVariants -o W303.GATK_selected.vcf \
  --variant W303.GATK_filtered.vcf -R genome/Saccharomyces.fa \
  --excludeFiltered 
fi
# now grep out the lines
module load vcftools

# run VCF tools to convert the filtered VCF file into tab-delimited
# for some simple look at the SNPs
# would also do other work with the VCF file in vcftools to look at summary statistics
vcf-to-tab < W303.GATK_filtered.vcf > W303.GATK_filtered.SNPs.tab

module load bedtools
# can use BEDTools to intersect the SNPs with the GFF file of genes to see which SNPs overlap features.
# problem is the file has 'chromosome' features which span the whole chromosome, so ignore these
# by using 'grep -v' which ignores lines which match a pattern.  A better solution is to fix the GFF so it
# only has features you care about in it
intersectBed -wb -a W303.GATK_filtered.vcf -b genome/Saccharomyces.gff | grep -v chromosome  > W303_snps_overlapping.bedtools.out
# this would restrict the output to only SNPs landing in CDSs
intersectBed -wb -a W303.GATK_filtered.vcf -b genome/Saccharomyces.gff | grep CDS > W303_snps_onlyGenes.bedtools.out
