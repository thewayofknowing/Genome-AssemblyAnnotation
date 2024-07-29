#!/bin/bash

#SBATCH --job-name="Genespace Run"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=16
#SBATCH --time=12:00:00
#SBATCH --mem=64G

# Load R library
# module load R/4.2.1-foss-2022a

WORKDIR=/storage/homefs/kk22w918/Assembly
GENESPACE_CONTAINER=$WORKDIR/Containers/genespace_1.1.4.sif
r_genespace=$WORKDIR/scripts/8-Comparitive-Genomics/genespace.R

# Load genespace container and Run genespace R script
apptainer exec \
--bind $WORKDIR \
$GENESPACE_CONTAINER Rscript $r_genespace 