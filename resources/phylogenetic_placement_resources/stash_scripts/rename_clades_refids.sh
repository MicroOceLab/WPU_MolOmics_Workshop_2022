#!/bin/bash

#change the ref ids to tax names in the clade label file

while read -r line; do
   REF_ID=$(echo "$line" | awk -F '\t' '{print $1}')
   REF_LABEL=$(echo "$line" | awk -F '\t' '{print $2}')

   TAX_NAME=$(grep ${REF_ID} ../0_pre_processing/1_sortedid2tax_map | awk -F '\t' '{print $2}')

   echo -e "${TAX_NAME}\t${REF_LABEL}"  
done < clades.txt

