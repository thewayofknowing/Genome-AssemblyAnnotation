#!/bin/bash

#SBATCH --job-name="BUSCO Evaluation"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=16
#SBATCH --time=16:00:00
#SBATCH --mem=64G
#SBATCH --partition=bdw
#SBATCH --output=output_busco.o

module load BUSCO/5.4.2-foss-2021a

WORKDIR=/storage/homefs/kk22w918/Assembly
export AUGUSTUS_CONFIG_PATH=$WORKDIR/scripts/augustus_config

flye_assembly=/storage/homefs/kk22w918/Assembly/2-Assembly/Flye
busco --cpu 16  -m genome -i $flye_assembly/flye_assembly.fasta -o BUSCO-FLYE -l brassicales_odb10 -f -c 16

pilon_flye_assembly=$WORKDIR/3.1-Polishing/pilon-flye
busco --cpu 16  -m genome -i $pilon_flye_assembly/pilon.fasta -o BUSCO-PILON-FLYE -l brassicales_odb10 -f -c 16

canu_assembly=$WORKDIR/2-Assembly/Canu/
busco --cpu 16  -m genome -i $canu_assembly/pacbio_canu.contigs.fasta -o BUSCO-CANU -l brassicales_odb10 -f -c 16

canu_pilon_assembly=$WORKDIR/3.1-Polishing/pilon-canu
busco --cpu 16  -m genome -i $canu_pilon_assembly/pilon.fasta -o BUSCO-PILON-CANU -l brassicales_odb10 -f -c 16

trinity_assembly=$WORKDIR/2-Assembly
busco --cpu 16 -m transcriptome -i $trinity_assembly/Trinity.Trinity.fasta -o BUSCO-TRINITY -l brassicales_odb10 -f -c 16