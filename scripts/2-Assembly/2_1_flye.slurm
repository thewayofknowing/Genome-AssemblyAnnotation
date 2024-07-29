#!/bin/bash

#SBATCH --job-name="Flye Assembly"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --time=24:00:00
#SBATCH --mem=64G
#SBATCH --partition=bdw
#SBATCH --output=output_fly.o

module load Flye/2.9-GCC-10.3.0

pacbio_folder=/storage/homefs/kk22w918/Assembly/reads/pacbio
output_folder=/storage/homefs/kk22w918/Assembly/2-Assembly/Flye/

flye --pacbio-raw $pacbio_folder/*  --out-dir $output_folder --threads 8