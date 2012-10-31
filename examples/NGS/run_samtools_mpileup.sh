SRACC=SRR527545
samtools mpileup -D -S -gu -f genome/Saccharomyces_cerevisiae.fa $SRACC.realign.W303.bam | bcftools view -bvcg - > $SRACC.raw.bcf
bcftools view $SRACC.raw.bcf | vcfutils.pl varFilter -D100 > $SRACC.filter.vcf

SRACC=SRR567754
samtools mpileup -D -S -gu -f genome/Saccharomyces_cerevisiae.fa $SRACC.realign.W303.bam | bcftools view -bvcg - > $SRACC.raw.bcf
bcftools view $SRACC.raw.bcf | vcfutils.pl varFilter -D100 > $SRACC.filter.vcf

