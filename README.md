# Genome-AssemblyAnnotation
This is the code repository for course module Genome Assembly (473637) and Annotation (SBL.30004)  as part of Bioinformatics masters at University of Bern.

Broad goals are as follows:
- Learn the techniques of data preprocessing and de-novo genome assembly.
- Assess the quality of the assembled genome/transcriptome.
- Annotate the genome for mobile elements and perform synteny analysis.

The data originates from [Jiao et al.](https://www.nature.com/articles/s41467-020-14779-y), specifically:
- Accession: C24
- Dataset: 6

Reads data available from following sources:
- Genome: Illumina paired-end reada data
- Genome: PacBio long reads data
- Transcriptome: Illumina RNASeq paired-end reads data

### 1) Quality Control
 ```
Aim: Get read quality and statistics
Scripts:
-- 1_1_make_stats.slurm
-- 1_2_qc.slurm
-- 1_3_jellyfish.slurm
Input:
-- Reads fastq files
Output:
-- FastQC graphs
-- Jellyfish Genomescope data
```

### 2) Genome assembly
 ```
Aim:
-- Use the PacBio long reads data and perform de-novo assembly using Canu and Flye
-- Use the Illumina RNASeq paired-end reads to perform transcriptome assembly
Scripts:
-- 2_1_flye.slurm
-- 2_2_canu.slurm
-- 2_3_trinity.slurm
Input:
-- PacBio reads fastq files
-- Illumina RNASeq reads fastq files
Output:
-- Fasta assembly files
```

### 3) Assembly Polishing and Evaluation
 ```
Aim:
-- Polish flye and canu assemblies using high quality short reads data
-- Evaluate the different assemblies using various qualitative and quantitative methods
Scripts:
-- 2_4_bowtie_polish.slurm
-- 2_5_pilon.slurm
-- 3_1a_busco.slurm
-- 3_2_quast.slurm
-- 3_3b_merqury.slurm
Input:
-- Assembly fasta files
-- Illumina short reads fastq files
-- TAIR10 reference genome 
Output:
-- Polished assembly fasta files
-- Graphs and Statistics comparing Flye/Canu Polished/Original assemblies
```

### 4) Assembly comparison
 ```
Aim: Compares assembled genomes with each other and the reference genome
Scripts:
-- 4_1_ncumer.slurm
-- 4_2_mummer.slurm
Input:
-- Assembly fasta files
Output:
-- Pair-wise genome comparison dot-plots 
```

### 5) Transposable Elenents (TE) annotation
 ```
Aim:
-- Use EDTA pipeline to annotate structurally intact and fragmented TEs
-- Clade level classification of Class I and II LTRs
Scripts:
-- 5_1a_edta.slurm
-- 5_1b_superfamily_grep.sh
-- 5_1c_visualize_clades.ipynb
-- 5_2_tesorter.slurm
Input:
-- Selected assembly with best results (polished flye)
Output:
-- Summary of whole-genome TE annotation (.mod.EDTA.TEanno.sum)                  
-- Repeat Masker comparison to ref (.mod.EDTA.TEanno)
-- gff with whole-genome TE annotation (.mod.EDTA.TEanno.gff3)
-- gff with annotation of intact only (.mod.EDTA.intact.gff3)                  
-- fasta with non-redundant TE library, classification into superfamilies (.mod.EDTA.TElib.fa)
-- Graph showing distribution of TEs along the contig/scaffold
```

### 6) Phylogenetics and Dating TEs
 ```
Aim:
-- Phylogenetic analysis of 2 largest TE superfamilies: Gypsy and Copia
-- Date TEs of different families
Scripts:
-- 6_1_parseRM.slurm
-- 6_2_phylogeny.sh
Input:
-- RepeatMasker output from EDTA pipeline
-- TESorter output (.dom.faa and .cls.tsv)
Output:
-- Graph showing TEs dating (Myr)
-- Phylogenetic trees of Gypsy and Copia superfamilies
```

### 7) Annotation of protein-coding sequences
 ```
Aim:
-- Use homology to annotate protein-coding sequences
-- Evaluate the obtained protein-coding sequences
Scripts:
-- 7_1_maker.slurm
-- 7_2_busco.slurm
-- 7_3_blast.slurm
Input:
-- Genome assembly (polished flye)
-- Transcriptome assembly from Trinity
-- TE library
Output:
-- gff file for annotated proteins
-- fasta file for annotated proteins
-- BUSCO summary file for quality of protein annotation
```

### 8) Comparitive genomics
 ```
Aim: Compare the assembled C24 accession with other groups for synteny and orthologs
Scripts:
-- 8_1_prep_data.slurm
-- 8_2_genespace.slurm
Input:
-- gff file for annotated proteins
-- fasta file for annotated proteins
Output:
-- Dotplots of pairwise accession/reference synteny
-- Orthogroups tables and statistics
```

