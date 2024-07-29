#!/bin/bash

#SBATCH --job-name="Polish Assembly"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=8
#SBATCH --time=12:00:00
#SBATCH --mem=64G
#SBATCH --partition=bdw
#SBATCH --output=output_polish.o

module load Bowtie2/2.4.4-GCC-10.3.0
module load SAMtools/1.13-GCC-10.3.0;

WORKDIR=/storage/homefs/kk22w918/Assembly
polish_output_folder=$WORKDIR/3.1-Polishing
flye_assembly=/storage/homefs/kk22w918/Assembly/2-Assembly/Flye
canu_assembly=/storage/homefs/kk22w918/Assembly/2-Assembly/Canu

# Flye Polish pre-processing
bowtie2-build -f $flye_assembly/flye_assembly.fasta  mustard-flye --threads 16
bowtie2 --sensitive-local -q -1 reads/Illumina/ERR3624577_1.fastq.gz -2 reads/Illumina/ERR3624577_2.fastq.gz -x indices/mustard --threads 16 -S $polish_output_folder/flye.sam
samtools view -bo $polish_output_folder/flye.bam $polish_output_folder/flye.sam
samtools sort -@ 16 $polish_output_folder/flye.bam -o $polish_output_folder/flye.sorted.bam
samtools index $polish_output_folder/flye.sorted.bam

# Canu Polish pre-processing
bowtie2-build -f $canu_assembly/pacbio_canu.contigs.fasta  mustard-canu --threads 16
bowtie2 --sensitive-local -q -1 reads/Illumina/ERR3624577_1.fastq.gz -2 reads/Illumina/ERR3624577_2.fastq.gz -x indices/mustard-canu --threads 16 -S $polish_output_folder/canu.sam
samtools view -bo $polish_output_folder/canu.bam $polish_output_folder/canu.sam
samtools sort -@ 16 $polish_output_folder/canu.bam -o $polish_output_folder/canu.sorted.bam
samtools index $polish_output_folder/canu.sorted.bam