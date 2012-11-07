#!/bin/bash
#module load mysql
module load orthoMCL
module load ncbi-blast

#mysqladmin drop -u orthomcl -p0rthMC1 orthomcl_testMYNAME
#mysqladmin create -u orthomcl -p0rthMC1 orthomcl_testMYNAME
#orthomclInstallSchema orthomcl.config

#mkdir proteomes
#cd proteomes
#../download.sh
#cd ..

mkdir cleanseq
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

if [ ! -f goodProteins.BLASTP.tab ]; then
 blastp -query goodProteins.fasta -db goodProteins.fasta -num_threads 4 -outfmt 6 -out goodProteins.BLASTP.tab -evalue 1e-3
fi
if [ ! -f goodProteins.BLASTP.bpo ]; then
 orthomclBlastParser goodProteins.BLASTP.tab cleanseq > goodProteins.BLASTP.bpo
fi

orthomclLoadBlast orthomcl.config goodProteins.BLASTP.bpo
orthomclPairs orthomcl.config  pairs.log cleanup=no
orthomclDumpPairsFiles orthomcl.config

mcl mclInput  --abc -I 1.5 -o mclOutput.I15.out
orthomclMclToGroups OG 1 < mclOutput.I15.out > mclGroups.I15.table
