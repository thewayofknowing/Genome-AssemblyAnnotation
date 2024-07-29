#!/bin/bash

#SBATCH --job-name="ProducingStats"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=4
#SBATCH --time=2:00:00
#SBATCH --mem=40G

# Conda Environment containing Seqkit
source activate assembly
WORKDIR=/storage/homefs/kk22w918/Assembly

seqkit stats $WORKDIR/reads/Illumina/*.fastq.gz > $WORKDIR/1-QC/illumina_stats.txt
seqkit stats $WORKDIR/reads/pacbio/*.fastq.gz > $WORKDIR/1-QC/pacbio_stats.txt