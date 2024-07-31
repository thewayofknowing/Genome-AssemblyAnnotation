#!/bin/bash

#SBATCH --job-name="QUAST Evaluation"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=16
#SBATCH --time=8:00:00
#SBATCH --mem=64G
#SBATCH --output=output_quast.o

WORKDIR=/storage/homefs/kk22w918/Assembly
export PATH=/storage/homefs/kk22w918/quast:$PATH

POLISHED_DIR=$WORKDIR/3.1-Polishing
CANU_POLISHED=$POLISHED_DIR/pilon-canu
FLYE_POLISHED=$POLISHED_DIR/pilon-flye

READ_DIR=$WORKDIR/reads/pacbio
REFERENCE_DIR=$WORKDIR/references

# Running quast without reference
quast.py $FLYE_POLISHED/pilon.fasta \
        $CANU_POLISHED/pilon.fasta \
        -1 $READ_DIR//ERR3415819.fastq.gz \
        -2 $READ_DIR/ERR3415820.fastq.gz \
        --labels "Flye_polished, Canu_polished" \
        --eukaryote \
        --est-ref-size 135000000 \
        --threads 16 --no-sv \
        --output-dir $WORKDIR/3.4-Quast/wo_reference

# Running quast with reference
quast.py $FLYE_POLISHED/pilon.fasta \
        $CANU_POLISHED/pilon.fasta \
        -1 $READ_DIR//ERR3415819.fastq.gz \
        -2 $READ_DIR/ERR3415820.fastq.gz \
        -R $REFERENCE_DIR/Arabidopsis_thaliana.TAIR10.dna.toplevel.fa \
        -G $REFERENCE_DIR/Arabidopsis_thaliana.TAIR10.57.gff3 \
        --labels "Flye_polished_rf, Canu_polished_rf" \
        --eukaryote \
        -e -m 3000 -i 500 -x 7000 \
        --est-ref-size 135000000 \
        --threads 16  \
        --output-dir $WORKDIR/3.4-Quast/with_reference
        
