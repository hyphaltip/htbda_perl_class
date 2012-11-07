#!/bin/bash
mkdir B_anthracis
cd B_anthracis
curl -s -C - -O ftp://ftp.ncbi.nih.gov/genomes/Bacteria/Bacillus_anthracis_Ames_uid57909/NC_003997.faa
cat *.faa > ../B_anthracis.pep
cd ..

mkdir E_coli_O157
cd E_coli_O157
curl -s -C - -O ftp://ftp.ncbi.nih.gov/genomes/Bacteria/Escherichia_coli_O157_H7_Sakai_uid57781/NC_002695.faa
curl -s -C - -O ftp://ftp.ncbi.nih.gov/genomes/Bacteria/Escherichia_coli_O157_H7_Sakai_uid57781/NC_002128.faa
curl -s -C - -O ftp://ftp.ncbi.nih.gov/genomes/Bacteria/Escherichia_coli_O157_H7_Sakai_uid57781/NC_002127.faa
cat *.faa > ../E_coli_O157.pep
cd ..

mkdir E_coli_K12
cd E_coli_K12
curl -s -C - -O ftp://ftp.ncbi.nih.gov/genomes/Bacteria/Escherichia_coli_K_12_substr__DH10B_uid58979/NC_010473.faa
cat *.faa > ../E_coli_K12.pep
cd ..

mkdir Y_pestis
cd Y_pestis
curl -s -C - -O ftp://ftp.ncbi.nih.gov/genomes/Bacteria/Yersinia_pestis_Pestoides_F_uid58619/NC_009377.faa
curl -s -C - -O ftp://ftp.ncbi.nih.gov/genomes/Bacteria/Yersinia_pestis_Pestoides_F_uid58619/NC_009378.faa
curl -s -C - -O ftp://ftp.ncbi.nih.gov/genomes/Bacteria/Yersinia_pestis_Pestoides_F_uid58619/NC_009381.faa
cat *.faa > ../Y_pestis.pep
cd ..
