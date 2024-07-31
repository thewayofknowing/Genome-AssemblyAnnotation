#!/bin/bash

#SBATCH --job-name="Trinity - Assembly"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=16
#SBATCH --time=24:00:00
#SBATCH --mem=64G
#SBATCH --output=output_trinity.o

WORKDIR=/storage/homefs/kk22w918/Assembly
READ_DIR=$WORKDIR/reads/RNAseq
OUTPUT_DIR=$WORKDIR/2-Assembly/Trinity

# Run trinity container on Illumina reads data
singularity exec -e /storage/homefs/kk22w918/trinityrnaseq.v2.15.1.simg  Trinity \
        --seqType fq --output $OUTPUT_DIR \
        --left $READ_DIR/SRR1584462_1.fastq.gz \
        --right $READ_DIR/SRR1584462_2.fastq.gz \
        --SS_lib_type RF --CPU 16 --max_memory 55G 

