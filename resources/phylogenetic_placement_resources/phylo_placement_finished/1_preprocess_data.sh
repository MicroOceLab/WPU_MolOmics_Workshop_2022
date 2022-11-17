#!/bin/bash

PREP_DIR=0_pre_processing
INIT_DIR=1_init_data

#######################################################################################
#
#STEP 1: join the ref ids and taxa names into 2 columns and save to 1-sortedid2tax_map;
#
#######################################################################################

REFIDS_ORIG=${PREP_DIR}/ref_names_orig.txt
REFIDS_ARRG=${PREP_DIR}/arranged_refnames.txt
TAXNAMES_ARRG=${PREP_DIR}/arranged_taxnames.txt
TEMPFILE=${PREP_DIR}/temp-id2tax_map
ID2TAXMAP=${PREP_DIR}/1_sortedid2tax_map

#join the REFIDS_ARRG and TAXNAMES_ARRG into 2 columns
paste ${REFIDS_ARRG} ${TAXNAMES_ARRG} > ${TEMPFILE}

#sort TEMPFILE according to REFIDS_ORIG order. This is done so that ID2TAXMAP matches the ref ids of the Reference Alignment line-by-line
while read -r line; do 
   grep ${line} ${TEMPFILE}; 
done < ${REFIDS_ORIG} > ${ID2TAXMAP}

#delete TEMPFILE
rm ${TEMPFILE}

echo -e "Finished running Step 1: Created reference id to taxa name map file - check: \e[0;31m 1_sortedid2tax_map \e[0m"
read -p "Press return key to resume..."



#######################################################################################
#
#STEP 2: change the ref id in the original ref aln by the taxa names for easier viewing
#
#######################################################################################

REF_ALN_ORIG=${PREP_DIR}/reference_alignment_dinoflagellates.fas
REF_ALN_FINAL=${INIT_DIR}/2_ref_aln.fas

awk -v OFS=' ' '
   NR==1 {print $0; next} 
   NR==FNR {a[$1]=$2; next} 
   NR!=FNR {print $2,a[$1]}
' ${REF_ALN_ORIG} ${ID2TAXMAP} > ${REF_ALN_FINAL}

echo -e "Finished running Step 2: Changed reference ID in alignment file with corresponding taxa names - check: \e[0;31m 2_ref_aln.fas \e[0m"
read -p "Press return key to resume..."



####################################################
#
#STEP 3: change ref ids in tree file with taxa names
#
####################################################

REF_TREE_ORIG=${PREP_DIR}/reference_tree_dinoflagellates_rerooted.tre
REF_TREE_FINAL=${INIT_DIR}/3_ref_tree.tre

#save the content of REF_TREE_ORIG
TREETEXT=$(cat ${REF_TREE_ORIG})

#replace each refid with corresponding taxname
while read -r line; do
   refid=$(echo "$line" | awk -F '\t' '{print $1}')
   taxa=$(echo "$line" | awk -F '\t' '{print $2}')
	
   #perform find and replace shell parameter expansion function
   #syntax: ${parameter/pattern/replace}
   TREETEXT=${TREETEXT/$refid/$taxa}
done < ${ID2TAXMAP}

#redirect final TREETEXT to REF_TREE_FINAL
echo ${TREETEXT} > ${REF_TREE_FINAL}

echo -e "Finished running Step 3: Changed reference ID in taxa file with corresponding taxa names - check: \e[0;31m 3_ref_tree.tre \e[0m"
read -p "Press return key to resume..."



##########################################
#
#STEP 5: copy QS from prep dir to init dir
#
##########################################

QUERY_SEQS=${PREP_DIR}/OTU*

cp ${QUERY_SEQS} ${INIT_DIR}

echo -e "Finished running Step 5: Copied the query sequence file to 1_init_data folder"