#!/bin/bash

#SBATCH --job-name="Assembly - Meryl"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --time=6:00:00
#SBATCH --mem-per-cpu=4G
#SBATCH --output=output_meryl.o

WORKDIR=/storage/homefs/kk22w918/Assembly
export PATH=/storage/homefs/kk22w918/meryl/build/bin:$PATH
export PATH=/storage/homefs/kk22w918/merqury:$PATH

reads_array=("ERR3624577_1" "ERR3624577_2")

illumina_folder=/storage/homefs/kk22w918/Assembly/reads/Illumina
qc_folder=/storage/homefs/kk22w918/Assembly/1-QC

# One Step Counting
meryl k=18 count $illumina_folder/*.fastq.gz output $qc_folder/ERR3624577.meryl