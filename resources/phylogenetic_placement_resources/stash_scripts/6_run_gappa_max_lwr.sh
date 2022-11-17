#!/bin/bash

EPA_TREE=3_epa/*jplace
MULTIPS_TREE=5_gappa_w_multips/*jplace
OUT_DIR=6_gappa_max_lwr_only

#Create jplace tree considering the max LWR only for the tree produced by RAxML EPA
gappa examine heat-tree \
   --jplace-path ${EPA_TREE} \
   --log-scaling \
   --write-svg-tree \
   --out-dir ${OUT_DIR} \
   --file-prefix no_multips_dino_max_heat_ \
   --allow-file-overwriting \
   --under-color "#cccccc" \
   --min-value 1 \
   --point-mass

#Create jplace tree considering the max LWR only for the tree with multiplicities 
gappa examine heat-tree \
   --jplace-path ${MULTIPS_TREE} \
   --log-scaling \
   --write-svg-tree \
   --out-dir ${OUT_DIR} \
   --file-prefix multips_dino_max_heat_ \
   --allow-file-overwriting \
   --under-color "#cccccc" \
   --min-value 1 \
   --point-mass

