#!/bin/bash

WORKDIR=/storage/homefs/kk22w918/Assembly
INPUT_DIR=$WORKDIR/5-TE/TESorter
OUT_DIR=$WORKDIR/6-TE-Dynamics/RT-Proteins
cd $OUT_DIR

module load Clustal-Omega/1.2.4-GCC-10.3.0
FastTree=$WORKDIR/Containers/FastTree

# Run scripts for both superfamilies
for family in "gypsy" "copia"
do
    if [[ "$family" == "gypsy" ]]; then
        prot='Ty3-RT'
    elif [[ "$family" == "copia" ]]; then
        prot='Ty1-RT'
    fi

    # make a list of RT proteins to extract
    list_file=${family}_prots.list
    grep $prot $INPUT_DIR/flye_${family}.dom.faa > $list_file

    # remove ">" from the header
    sed -i 's/>//' $list_file

    # remove all characters following "empty space" from the header
    sed -i 's/ .\+//' $list_file   

    out_fasta=${family}_RT.fasta
    seqkit grep -f $list_file $INPUT_DIR/flye_${family}.dom.faa -o $out_fasta

    out_sed=$out_fasta.sed
    sed 's/|.\+//' $out_fasta > $out_sed

    # use clustal omega to align sequences
    out_clustalo=$out_sed.clustalo_alignment.fasta
    clustalo --force -i $out_sed -o $out_clustalo

    # use FastTree to create a phylogenetic tree
    phylo_tree=$out_clustalo.tree
    $FastTree -out $phylo_tree $out_clustalo
done
