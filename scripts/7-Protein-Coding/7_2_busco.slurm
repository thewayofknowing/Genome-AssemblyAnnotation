#!/bin/bash

#SBATCH --job-name="BUSCO Evaluation"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=16
#SBATCH --time=16:00:00
#SBATCH --mem=64G
#SBATCH --output=output_busco_%j.o

module load BUSCO/5.4.2-foss-2021a

base=atal_flye_polished
WORKDIR=/storage/homefs/kk22w918/Assembly
cd $WORKDIR/7-Protein-Coding
export AUGUSTUS_CONFIG_PATH=$WORKDIR/scripts/augustus_config

base=atal_flye_polished
cd $base.maker.output

protein=$base.all.maker.proteins.fasta.renamed.fasta
busco -i $protein -l brassicales_odb10 -f -m proteins -c 16 -o ${base}_busco