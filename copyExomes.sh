#!/bin/bash
# Run script: bash copyExomes.sh clinical_data.txt exomes/

# Create output directory if does not exist
mkdir -p exomesCohort/

# Identify the samples that have a diameter between 20 and 30 mm long (inclusive), accepts tab-deliminited file
exomes_to_copy=`cat $1 | awk -F'\t' '$3 >= 20 && $3 <= 30 && $5 == "Sequenced" {print $6}'`

# Loop through identified samples and copy corresponding genome to output directory
for exome in $exomes_to_copy
do
    cp $2/$exome.fasta ./exomesCohort/$exome.fasta
done