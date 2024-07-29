#!/bin/bash

WORKDIR=/storage/homefs/kk22w918/Assembly

cd $WORKDIR/5-TE/Superfamilies
grep -A1 'Gypsy' $WORKDIR/references/Brassicaceae_repbase_all_march2019.fasta | grep -v -- "^--$" > brac_gypsy.fa
grep -A1 'Copia' $WORKDIR/references/Brassicaceae_repbase_all_march2019.fasta | grep -v -- "^--$" > brac_copia.fa

grep -A1 'Gypsy' $WORKDIR/5-TE/pilon-flye.fasta.mod.EDTA.TElib.fa | grep -v -- "^--$" > flye_gypsy.fa
grep -A1 'Copia' $WORKDIR/5-TE/pilon-flye.fasta.mod.EDTA.TElib.fa | grep -v -- "^--$" > flye_copia.fa



