#!/bin/bash

# Create output directory if does not exist
mkdir -p crisprSites/

# Loop through top motifs files
fileNames=`ls $1`

for file in $fileNames
do
    # Get exome name by removing file extension
    exome_name="${file%_topmotifs.fasta}"
    # Find genes with "*GG" and at least 20 bases upstream
    grep -EB1 "[ATCG]{21}GG" $1/$file --no-group-separator > crisprSites/${exome_name}_precrispr.fasta
done

# Run script: bash identifyCrisprSite.sh crisprReady/