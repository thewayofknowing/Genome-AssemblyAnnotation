#!/bin/bash

#SBATCH --job-name="Pilon Polish"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --time=6:00:00
#SBATCH --mem=64G
#SBATCH --partition=bdw
#SBATCH --output=output_pilon.o

WORKDIR=/storage/homefs/kk22w918/Assembly
polish_output_folder=$WORKDIR/3.1-Polishing

# Polish the flye assembly
java -Xmx64g -jar $WORKDIR/pilon-1.24.jar --genome 2-Assembly/Flye/flye_assembly.fasta --bam $polish_output_folder/flye.sorted.bam --outdir $polish_output_folder/pilon-flye/

# Polish the canu assembly
java -Xmx64g -jar $WORKDIR/pilon-1.24.jar --genome 2-Assembly/Canu/pacbio_canu.contigs.fasta --bam $polish_output_folder/canu.sorted.bam --outdir $polish_output_folder/pilon-canu/



