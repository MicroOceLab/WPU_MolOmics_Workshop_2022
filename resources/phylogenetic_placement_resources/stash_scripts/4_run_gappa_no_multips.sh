#!/bin/bash

TREE=3_epa/*.jplace
OUT_DIR=4_gappa_no_multips

#Generate a heat tree from the results of RAxML EPA
gappa examine heat-tree \
   --jplace-path ${TREE} \
   --log-scaling \
   --write-svg-tree \
   --out-dir ${OUT_DIR} \
   --file-prefix dino_heat_ \
   --allow-file-overwriting \
   --under-color "#cccccc" \
   --min-value 0.5 

#Calculate EDPL per QS
gappa examine edpl \
   --jplace-path ${TREE} \
   --out-dir ${OUT_DIR} \
   --file-prefix dino_ \
   --allow-file-overwriting

#List LWR per QS; only top 5 highest LWRs are listed by default
gappa examine lwr-list \
   --jplace-path ${TREE} \
   --out-dir ${OUT_DIR} \
   --file-prefix dino_ \
   --allow-file-overwriting 

#Show distribution of the LWR of QS
gappa examine lwr-distribution \
   --jplace-path ${TREE} \
   --out-dir ${OUT_DIR} \
   --file-prefix dino_ \
   --allow-file-overwriting

#Show LWR histogram table
gappa examine lwr-histogram \
   --jplace-path ${TREE} \
   --out-dir ${OUT_DIR} \
   --file-prefix dino_ \
   --allow-file-overwriting
