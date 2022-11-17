#!/bin/bash

INIT_DIR=1_init_data
ALN_DIR=2_alignment
EPA_DIR=3_epa

#Perform phylogenetic placement using RAxML
raxmlHPC \
   -f v \
   -s ${ALN_DIR}/papara_alignment.dino_aln \
   -m GTRGAMMAX \
   -n dino_epa \
   -t ${INIT_DIR}/3_ref_tree.tre \
   --epa-accumulated-threshold=0.99 

mv RAxML* ${EPA_DIR}

