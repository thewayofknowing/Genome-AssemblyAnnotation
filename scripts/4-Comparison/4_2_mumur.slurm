#!/bin/bash

#SBATCH --job-name="Mummur Assembly"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=2
#SBATCH --time=2:00:00
#SBATCH --mem=32G
#SBATCH --output=output_mummer_%j.o

export PATH=/storage/homefs/kk22w918/mummer-4.0.0rc1/bin:$PATH

WORKDIR=/storage/homefs/kk22w918/Assembly
POLISHED_DIR=$WORKDIR/3.1-Polishing
CANU_POLISHED=$POLISHED_DIR/pilon-canu
FLYE_POLISHED=$POLISHED_DIR/pilon-flye

REFERENCE=$WORKDIR/references/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa

OUTDIR=$WORKDIR/4-Comparison
cd $OUTDIR

# Run 1. Ref v. Flye
# mummerplot -R $REFERENCE -Q $FLYE_POLISHED/pilon.fasta --filter -t png -s large --layout -p ref_flye ref_flye.delta

# Run 1. Ref v. Flye Unpolished
mummerplot -R $REFERENCE -Q $WORKDIR/2-Assembly/Flye/flye_assembly.fasta --filter -t png -s large --layout \
                                                                                    -p ref_flye_unpolished ref_flye_unpolished.delta

# Run 2. Ref  vs Canu
# mummerplot -R $REFERENCE -Q $CANU_POLISHED/pilon.fasta --filter -t png -s large --layout -p ref_canu ref_canu.delta

# Run 3. Flye vs. Canu
# mummerplot -R $FLYE_POLISHED/pilon.fasta -Q $CANU_POLISHED/pilon.fasta --filter -t png -s large --layout -p flye_canu flye_canu.delta
