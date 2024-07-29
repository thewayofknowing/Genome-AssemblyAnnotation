#!/bin/bash

#SBATCH --job-name="Assembly-Eval"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=16
#SBATCH --time=12:00:00
#SBATCH --mem=48G
#SBATCH --partition=bdw
#SBATCH --output=output_mercury_%j.o

module load R/4.1.0-foss-2021a

WORKDIR=/storage/homefs/kk22w918/Assembly
export PATH=/storage/homefs/kk22w918/meryl/build/bin:$PATH
export PATH=/storage/homefs/kk22w918/merqury:$PATH
export MERQURY=/storage/homefs/kk22w918/merqury

meryl_folder=$WORKDIR/1-QC
output_folder=$WORKDIR/3.2-Merqury

flye_assembly=/storage/homefs/kk22w918/Assembly/2-Assembly/Flye/flye_assembly.fasta
output_flye=flye

pilon_flye_assembly=$WORKDIR/3.1-Polishing/pilon-flye/pilon.fasta
output_flye_polished=flye_polished

canu_assembly=$WORKDIR/2-Assembly/Canu/pacbio_canu.contigs.fasta
output_canu=canu

canu_pilon_assembly=$WORKDIR/3.1-Polishing/pilon-canu/pilon.fasta
output_canu_polished=canu_polished

# Run one at a time 

# Flye original
output_dir=$output_folder/$output_flye
cd $output_dir
merqury.sh $meryl_folder/ERR3624577.meryl  $flye_assembly $output_flye

# Flye polished
# output_dir=$output_folder/$output_flye_polished
# cd $output_dir
# merqury.sh $meryl_folder/ERR3624577.meryl  $pilon_flye_assembly $output_flye_polished

# Canu original
# output_dir=$output_folder/$output_canu
# cd $output_dir
# merqury.sh $meryl_folder/ERR3624577.meryl  $canu_assembly $output_canu

# Canu polished
# output_dir=$output_folder/$output_canu_polished
# cd $output_dir
# merqury.sh $meryl_folder/ERR3624577.meryl  $canu_pilon_assembly $output_canu_polished