#!/bin/bash

#SBATCH --job-name="TESorter"
#SBATCH --cpus-per-task=16
#SBATCH --time=6:00:00
#SBATCH --mem=64G
#SBATCH --output=output_tesorter.o

WORKDIR=/storage/homefs/kk22w918/Assembly
cd $WORKDIR/5-TE/TESorter

singularity exec \
--bind $WORKDIR \
$WORKDIR/Containers/TEsorter_1.3.0.sif \
TEsorter -p 16 $WORKDIR/5-TE/Superfamilies/flye_gypsy.fa -db rexdb-plant -pre flye_gypsy

singularity exec \
--bind $WORKDIR \
$WORKDIR/Containers/TEsorter_1.3.0.sif \
TEsorter -p 16 $WORKDIR/5-TE/Superfamilies/flye_copia.fa -db rexdb-plant -pre flye_copia

singularity exec \
--bind $WORKDIR \
$WORKDIR/Containers/TEsorter_1.3.0.sif \
TEsorter $WORKDIR/5-TE/Superfamilies/brac_gypsy.fa -db rexdb-plant -pre brac_gypsy

singularity exec \
--bind $WORKDIR \
$WORKDIR/Containers/TEsorter_1.3.0.sif \
TEsorter $WORKDIR/5-TE/Superfamilies/brac_copia.fa -db rexdb-plant -pre brac_copia