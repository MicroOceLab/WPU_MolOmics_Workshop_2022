#!/bin/bash

fasta_content=$(cat interleaved_fasta.fas)

while read line; do
	SRR_id=$(echo -e "${line}" | awk '{print $1}')
	sample_name=$(echo -e "${line}" | awk '{print $2}')

	fasta_content=${fasta_content//${SRR_id}/${sample_name}}

	echo -e "${fasta_content}" | grep -A 1 ${sample_name} > "${sample_name}_seqs.fas"
done < SRR_to_Sample_Name.txt

echo -e "${fasta_content}"

