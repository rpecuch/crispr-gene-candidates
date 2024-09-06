#!/bin/bash
# Run script: bash createCrisprReady.sh motif_list.txt exomesCohort/

# Create output directory if does not exist
mkdir -p crisprReady/

# Loop through exomes in input directory
fileNames=`ls $2`
motifs=`cat $1`

for file in $fileNames
do
    # Loop through motif list to find number of occurrences
    declare -a motif_count=()

    for motif in $motifs
    do
        # Count # of matches
        match_count=`grep -o $motif $2$file | wc -l`
        # Store # of matches with each motif
        motif_count+=("${match_count}_${motif}")
    done
 
    # Sort matches to find top 3 motifs by sorting in reverse numerical order
    top_motifs=`printf "%s\n" ${motif_count[@]} | sort -k1nr | head -3`

    # Store found matches
    declare -a matches=()
    for top_motif in $top_motifs
    do
        # Trim off motif count prefix
        pattern=`echo $top_motif | tr -d "0123456789_"`
        # Add match with gene name to found matches
        matches+=$(grep -B1 $pattern $2/$file --no-group-separator)
        # Add spacing between match sets
        matches+=' '
    done
    # Get exome name by removing file extension
    exome_name="${file%.fasta}"
    # Only add matches that are not duplicates to output file
    printf "%s\n" ${matches[@]} | awk '!seen[$0]++ {print $0}' > crisprReady/${exome_name}_topmotifs.fasta
done