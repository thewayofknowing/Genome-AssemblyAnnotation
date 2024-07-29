#!/bin/bash

#SBATCH --job-name="Preproc CompGen"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --time=2:00:00
#SBATCH --mem=32G

# Conda Environment containing Seqkit
source activate fire #assembly

WORKDIR=/storage/homefs/kk22w918/Assembly
cd $WORKDIR/8-Comparitive-Genomics

base=atal_flye_polished
gff=Accessions/$base.all.maker.noseq.gff.renamed.gff
fasta=Accessions/$base.all.maker.proteins.fasta.renamed.fasta

list_longest_contigs=$base.longest.contigs.txt
list_out_gene_ids=$base.gene_ids.txt

output_bed=bed/$base.bed
output_protein=peptide/$base.fa

# Command Interpretation:
# GFF File Format: seqname  source  feature start   end score   strand  frame   attribute
# Awk : filter lines with $3 i.e. feature == contig
# Sort in reverse order by 5th column i.e. end or length (starting at 1)
# Extract seqname, start, end, attribute columns, post processing
# Filter top 10 contings
awk '$3=="contig"' $gff | sort -t $'\t' -k5 -n -r | cut -f 1,4,5,9 | sed 's/ID=//' | sed 's/;.\+//' | head -n 10 > $list_longest_contigs

# Create Bed File
awk '$3=="mRNA"' $gff | cut -f 1,4,5,9 | sed 's/ID=//' | sed 's/;.\+//' | grep -w -f <(cut -f1 $list_longest_contigs) > $output_bed

# Extract gene IDs from bed file
cut -f4 $output_bed > $list_out_gene_ids

# Lookup extracted gene IDs in protein fasta file and output filtered proteins
cat $fasta | seqkit grep -r -f $list_out_gene_ids | seqkit seq -i > $output_protein