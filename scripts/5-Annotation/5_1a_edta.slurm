#!/bin/bash

#SBATCH --job-name="EDTA Tagging"
#SBATCH --cpus-per-task=20
#SBATCH --time=24:00:00
#SBATCH --mem=64G
#SBATCH --output=output_edta_%j.o

# conda create -n EDTA
# conda activate EDTA
# mamba install -c conda-forge -c bioconda edta

WORKDIR=/storage/homefs/kk22w918/Assembly
cd $WORKDIR/5-TE

FLYE_ASSEMBLY=$WORKDIR/3.1-Polishing/pilon-flye
CANU_ASSEMBLY=$WORKDIR/3.1-Polishing/pilon-canu

# Run EDTA with polished flye assembly
EDTA.pl \
--genome $FLYE_ASSEMBLY/pilon-flye.fasta \
--species others \
--step all \
--cds $WORKDIR/references/TAIR10_cds_20110103_representative_gene_model_updated \
--anno 1 \
--threads 20