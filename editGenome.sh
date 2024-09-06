#!/bin/bash
# Run script: bash editGenome.sh crisprSites/

# Create output directory if does not exist
mkdir -p postCrispr/

# Loop through crispr site files
fileNames=`ls $1`

for file in $fileNames
do
    # Get exome name by removing file extension
    exome_name="${file%_precrispr.fasta}"
    # Insert the letter A right before the *GG site
    cat $1/$file | sed 's/\([ATCG]GG\)/A\1/g' > postCrispr/${exome_name}_postcrispr.fasta
done