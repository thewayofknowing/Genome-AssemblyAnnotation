#!/bin/bash

#SBATCH --job-name="QC"
#SBATCH --nodes=1
#SBATCH --cpus-per-task=2
#SBATCH --time=12:00:00
#SBATCH --mem-per-cpu=16G
#SBATCH --output=output_qc.o

module load FastQC/0.11.9-Java-11
module load MultiQC/1.11-foss-2021a

illumina_reads_folder=/storage/homefs/kk22w918/Assembly/reads/Illumina
pacbio_reads_folder=/storage/homefs/kk22w918/Assembly/reads/pacbio
fastqc_output_folder=/storage/homefs/kk22w918/Assembly/1-QC/

#FASTQC OF ALL FASTQ FILES
fastqc -t 2 $illumina_reads_folder/*.fastq.gz -o $fastqc_output_folder/Illumina/
fastqc -t 2 $pacbio_reads_folder/*.fastq.gz -o $fastqc_output_folder/pacbio/

# Run MultiQC to combine reads data
multiqc --filename illumina_MultiQC -o $fastqc_output_folder/MultiQC $fastqc_output_folder/Illumina
multiqc --filename pacbio_MultiQC -o $fastqc_output_folder/MultiQC $fastqc_output_folder/pacbio