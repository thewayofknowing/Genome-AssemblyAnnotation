#!/bin/bash

#SBATCH --job-name="Ncumer-Assembly"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --time=2:00:00
#SBATCH --mem=32G
#SBATCH --output=output_nucmer_%j.o

export PATH=/storage/homefs/kk22w918/mummer-4.0.0rc1/bin:$PATH

WORKDIR=/storage/homefs/kk22w918/Assembly

POLISHED_DIR=$WORKDIR/3.1-Polishing
CANU_POLISHED=$POLISHED_DIR/pilon-canu
FLYE_POLISHED=$POLISHED_DIR/pilon-flye

REFERENCE=$WORKDIR/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa

OUTDIR=$WORKDIR/4-Comparison
cd $OUTDIR

# Run 1. Ref v. Flye
# nucmer --prefix=ref_flye --breaklen 1000 --mincluster 1000 $REFERENCE $FLYE_POLISHED/pilon.fasta

# Run 1. Ref v. Flye Unpolished
nucmer --prefix=ref_flye_unpolished --breaklen 1000 --mincluster 1000 $REFERENCE $WORKDIR/2-Assembly/Flye/flye_assembly.fasta

# Run 2. Ref  vs Canu
# nucmer --prefix=ref_canu --breaklen 1000 --mincluster 1000 $REFERENCE $CANU_POLISHED/pilon.fasta

# Run 3. Flye vs. Canu
# nucmer --prefix=flye_canu --breaklen 1000 --mincluster 1000 $FLYE_POLISHED/pilon.fasta $CANU_POLISHED/pilon.fasta