#!/bin/bash

EPA_TREE=3_epa/*jplace
OUT_DIR=5_gappa_w_multips
MULTIPS=${OUT_DIR}/QS_multips.txt
MULTIPS_TREE=${OUT_DIR}/*jplace

#Create new jplace tree file which includes mutliplicties/abundances of QS
gappa edit multiplicity \
   --jplace-path ${EPA_TREE} \
   --multiplicity-file ${MULTIPS} \
   --file-prefix multips_ \
   --out-dir ${OUT_DIR} \
   --allow-file-overwriting \
   --verbose

#Create heat tree of new jplace file
gappa examine heat-tree \
   --jplace-path ${MULTIPS_TREE} \
   --log-scaling \
   --write-svg-tree \
   --out-dir ${OUT_DIR} \
   --file-prefix multips_dino_heat_ \
   --allow-file-overwriting \
   --under-color "#cccccc" \
   --min-value 0.5
