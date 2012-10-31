# will put download of datasets commands in here

# use aspera if possible
module load aspera
ASCP=`which ascp`
# FIX to present the apera key if it is in a different location. If no ASCP on the system will just work with curl
DLOAD="ascp -i /opt/aspera/2.7.9/etc/asperaweb_id_dsa.putty -k 1 -l 300M -QTr"

GENOMEDIR=genome
mkdir -p $GENOMEDIR
# get yeast genome - Feb2011 release
cd $GENOMEDIR
url=http://downloads.yeastgenome.org/sequence/S288C_reference/genome_releases/S288C_reference_genome_R64-1-1_20110203.tgz    
base=`basename $url`
dirbase=`basename $url .tgz`
genomefile=`echo $dirbase | perl -p -e 's/genome/sequence/'`

curl -s -C - -o $base $url
tar zxf $base
perl ../rename_seq.pl $dirbase/$genomefile.fsa > Saccharomyces_cerevisiae.fa
cd ..

SRADIR=sra
mkdir -p $SRADIR
for urlbase in `awk '{print $2}' sra_acc.txt | grep -v URLBASE`
do
 sraacc=`basename $urlbase .sra` 
 echo $SRADIR/$sracc.sra
 if [ ! -f $SRADIR/$sracc.sra ]; then
  if [ -f $ASCP ] ;
  then
   $DLOAD anonftp@ftp-private.ncbi.nlm.nih.gov:$urlbase $SRADIR/$sraacc.sra
  else  
   curl -C - -o $SRADIR/$sraacc.sra http://ftp-private.ncbi.nlm.nih.gov$urlbase
  fi
 fi
 
done

module load sratoolkit
FASTQDIR=fastq
mkdir -p $FASTQDIR
for file in sra/*.sra
do
 base=`basename $file .sra`
 if [ ! -f $FASTQDIR/$base"_1.fastq" ]; then
  fastq-dump --split-3 -O $FASTQDIR -M 30 $file
 else
  echo "Skipping $file, already extracted"
 fi
done
