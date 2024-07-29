#!/bin/bash

#SBATCH --job-name="BLAST Evaluation"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=16
#SBATCH --time=16:00:00
#SBATCH --mem=64G
#SBATCH --output=output_blast_%j.o

module load BLAST+/2.11.0-gompi-2021a

WORKDIR=/storage/homefs/kk22w918/Assembly
cd $WORKDIR/7-Protein-Coding/blast

base=atal_flye_polished
maker_output_dir=$WORKDIR/7-Protein-Coding/$base.maker.output
protein_fasta=$maker_output_dir/$base.all.maker.proteins.fasta.renamed.fasta

uniprot=$WORKDIR/references/uniprot_viridiplantae_reviewed.fa
uniprot_db=uniprot.db
blast_output=${base}_blast.out

makeblastdb -in $uniprot -out $uniprot_db -dbtype prot
blastp -query $protein_fasta -db $uniprot_db \
                        -num_threads 16 -outfmt 6 -evalue 1e-10 -out $blast_output