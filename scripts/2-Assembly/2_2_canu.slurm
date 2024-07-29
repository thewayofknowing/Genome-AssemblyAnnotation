#!/bin/bash

#SBATCH --job-name="Canu Assembly"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=1
#SBATCH --time=24:00:00
#SBATCH --mem-per-cpu=4G
#SBATCH --partition=bdw
#SBATCH --output=output_canu.o

module load canu/2.2-GCCcore-10.3.0-Java-11

pacbio_folder=/storage/homefs/kk22w918/Assembly/reads/pacbio
output_folder=/storage/homefs/kk22w918/Assembly/2-Assembly/Canu

canu \
-p pacbio_canu -d  $output_folder \
genomeSize=119m \
maxThreads=16 minMemory=16 maxMemory=96 \
gridEngineResourceOption="--cpus-per-task=THREADS --mem-per-cpu=MEMORY" \
gridOptions="--time=24:00:00 --partition=bdw" \
-pacbio $pacbio_folder/*

# canu \
#   -p pacbio_canu -d $output_folder/... \
#   genomeSize=119m \
#    maxThreads=16 maxMemory=84 \
#  gridEngineResourceOption="--cpus-per-task=THREADS --mem-per-cpu=MEMORY" \
#  gridOptions="--time=16:00:00 --partition=bdw" \
#   correctedErrorRate=0.039 \
#   -trimmed -corrected -pacbio $output_folder/pacbio_canu.trimmedReads.fasta.gz
