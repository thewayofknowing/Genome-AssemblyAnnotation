#!/bin/bash

#SBATCH --job-name="MAKER Tagging"
#SBATCH --time=20:00:00
#SBATCH --mem-per-cpu=8G
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=12
#SBATCH --output=output_maker_%j.o

WORKDIR=/storage/homefs/kk22w918/Assembly
SCRATCH=/storage/homefs/kk22w918/tmp
cd $WORKDIR/7-Protein-Coding

# conda activate annotation
base=atal_flye_polished

# Run maker
mpiexec -n 12 singularity exec \
--bind $WORKDIR \
--bind $SCRATCH \
$WORKDIR/Containers/MAKER_3.01.03.sif \
maker -mpi -base $base maker_opts.ctl maker_bopts.ctl maker_exe.ctl

# Generate gff and fasta files
cd $base.maker.output
index_log=${base}_master_datastore_index.log
gff3_merge -d $index_log -o $base.all.maker.gff 
gff3_merge -d $index_log -n -o $base.all.maker.noseq.gff 
fasta_merge -d $index_log -o $base 

# Finalize annotations
protein=$base.all.maker.proteins.fasta
transcript=$base.all.maker.transcripts.fasta
gff=$base.all.maker.noseq.gff

cp $gff ${gff}.renamed.gff
cp $protein ${protein}.renamed.fasta
cp $transcript ${transcript}.renamed.fasta

prefix=${genome}_
maker_map_ids --prefix $prefix --justify 7 $gff.renamed.gff > $base.id.map
map_gff_ids $base.id.map $gff.renamed.gff
map_fasta_ids $base.id.map $protein.renamed.fasta
map_fasta_ids $base.id.map $transcript.renamed.fasta