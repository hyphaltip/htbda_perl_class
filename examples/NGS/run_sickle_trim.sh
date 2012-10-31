module load stajichlab
module load sickle
FASTQDIR=fastq
for file in $FASTQDIR/*_1.fastq
do
base=`basename $file _1.fastq`
 if [ ! -f $FASTQDIR/$base"_1.trim.fq" ]; then
 sickle pe -f $FASTQDIR/$base"_1.fastq" -r $FASTQDIR/$base"_2.fastq" -o $FASTQDIR/$base"_1.trim.fq" -p $FASTQDIR/$base"_2.trim.fa" -s $FASTQDIR/$base"_unpair.trim.fq" -t sanger
 fi
done
