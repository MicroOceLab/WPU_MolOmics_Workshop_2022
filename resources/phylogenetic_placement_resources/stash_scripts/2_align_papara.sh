#!/bin/bash

INIT_DIR=1_init_data
ALN_DIR=2_alignment

#Align QS to existing reference alignment using PaPaRa
papara \
   -t ${INIT_DIR}/3_ref_tree.tre \
   -s ${INIT_DIR}/2_ref_aln.fas \
   -q ${INIT_DIR}/OTU_representatives_dinoflagellates.upper \
   -n dino_aln

mv papara* ${ALN_DIR}
