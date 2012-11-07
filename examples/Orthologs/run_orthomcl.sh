#!/bin/bash
#module load mysql
module load orthoMCL
module load ncbi-blast

# copy the config file from the shared location
if [ ! -f orthomcl.config ]; then
 cp /srv/projects/db/GEN220/orthomcl/orthomcl.config .
done
# Grab the password from the file
PASS=`grep dbPassword orthomcl.config | awk -F= '{print $2}'`
# drop db to get a clean slate
mysqladmin drop -f -u orthomcl -p$PASS orthomcl_testMYNAME
mysqladmin create -u orthomcl -p$PASS orthomcl_testMYNAME
orthomclInstallSchema orthomcl.config

if [ ! -d proteomes ]; then
 mkdir proteomes
 cd proteomes
 ../download.sh
 cd ..
fi

mkdir -p cleanseq
cd cleanseq

for file in ../proteomes/*.pep
do
 base=`basename $file .pep`
# the 4th field the ACCESSION number
 orthomclAdjustFasta $base $file 4 
done
cd ..


orthomclFilterFasta cleanseq 10 10
makeblastdb -in goodProteins.fasta -title "OrthoMCLPeps" -dbtype prot

# This will run BLAST - may take an hour or two
if [ ! -f goodProteins.BLASTP.tab ]; then
 blastp -query goodProteins.fasta -db goodProteins.fasta -num_threads 4 -outfmt 6 -out goodProteins.BLASTP.tab -evalue 1e-3
fi

# This will reformat the BLAST data into something to load into the database
if [ ! -f goodProteins.BLASTP.bpo ]; then
 orthomclBlastParser goodProteins.BLASTP.tab cleanseq > goodProteins.BLASTP.bpo
fi

# Load the data into the DB
orthomclLoadBlast orthomcl.config goodProteins.BLASTP.bpo

# now run the ortholog/paralog initial finding
rm -rf pairs pairs.log 
orthomclPairs orthomcl.config  pairs.log cleanup=no

# Dump out the ortholog groups and the mclInput file
orthomclDumpPairsFiles orthomcl.config

# Run mcl for clustering
mcl mclInput  --abc -I 1.5 -o mclOutput.I15.out

# convert the MCL clusters into OrthoMCL groups
orthomclMclToGroups OG 1 < mclOutput.I15.out > mclGroups.I15.table
