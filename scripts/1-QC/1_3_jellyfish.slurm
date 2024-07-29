#!/bin/bash

#SBATCH --job-name="Jellyfish QC"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=12
#SBATCH --time=2:00:00
#SBATCH --mem-per-cpu=64G
#SBATCH --output=output_jellyfish_%j.o

module load Jellyfish/2.3.0-GCC-10.3.0

WORKDIR=/storage/homefs/kk22w918/Assembly

Illumina_reads=$WORKDIR/reads/Illumina
Illumina_output_dir=$WORKDIR/1-QC/Jellyfish/Illumina

PacBio_reads=$WORKDIR/reads/pacbio
PacBio_output_dir=$WORKDIR/1-QC/Jellyfish/PacBio

# run jellyfish for Illumina
jellyfish count -C -m 18 -s 5G -t 12 -o $Illumina_output_dir/reads.jf <(zcat $Illumina_reads/*)
jellyfish histo -t 8 $Illumina_output_dir/reads.jf > $Illumina_output_dir/reads.histo

# run jellyfish for PacBio
jellyfish count -C -m 18 -s 5G -t 12 -o $PacBio_output_dir/reads.jf <(zcat $PacBio_reads/*)
jellyfish histo -t 8 $PacBio_output_dir/reads.jf > $PacBio_output_dir/reads.histo