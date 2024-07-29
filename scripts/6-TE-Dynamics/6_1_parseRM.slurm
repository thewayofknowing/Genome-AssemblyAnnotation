#!/bin/bash

#SBATCH --job-name="ParseML"
#SBATCH --cpus-per-task=4
#SBATCH --time=24:00:00
#SBATCH --mem=32G
#SBATCH --output=output_parseml_%j.o

# Activate environment for assembly and install bioperl
# conda activate assembly 
# mamba install perl-bioperl-core
# conda install bioconda::perl-bio-featureio

WORKDIR=/storage/homefs/kk22w918/Assembly

FLYE_ASSEMBLY=$WORKDIR/3.1-Polishing/pilon-flye
OUTPUT_DIR=$WORKDIR/6-TE-Dynamics/
INPUT_DIR=$WORKDIR/5-TE/pilon-flye.fasta.mod.EDTA.anno
cd $OUTPUT_DIR

# Use polished flye assembly and output from EDTA Repeatmasker annotation
genome=$FLYE_ASSEMBLY/pilon-flye.fasta
input_filename=$INPUT_DIR/pilon-flye.fasta.mod.out

# 1) Split the amount of DNA by bins of % divergence for each repeat name, family or class
pl_path=$WORKDIR/scripts/6-TE-Dynamics/parseRM.pl
perl $pl_path -i $input_filename -l 50,1 -v

# Get output file from default location (input directory)
cp $INPUT_DIR/*landscape.Div.Rname.tab $OUTPUT_DIR

# 2) Remove the first and the 3rd line
sed -i '1d;3d' pilon-flye.fasta.mod.out.landscape.Div.Rname.tab