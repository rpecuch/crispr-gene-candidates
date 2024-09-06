# To run: python3 exomeReport.py clinical_data.txt postCrispr/

# Import needed modules
import os
import csv
import sys

# Read input files
inputDir = sys.argv[2]
inputFiles = os.listdir(inputDir)

# Read clinical data file
clinical_data_path = sys.argv[1]
with open(clinical_data_path) as f:
    reader = csv.reader(f, delimiter="\t")
    clinical_data = list(reader)
# Create dictionary of entries in clinical data file with organism names as keys
clinical_data_dict = {}
for record in clinical_data:
    clinical_data_dict[record[5]] = record[0:5]

# Store entries to write to output file
entries_to_write = []

# Loop through input files
for file in inputFiles:
    # Get needed info from clinical data file
    organism = file.split('_')[0]
    discoverer = clinical_data_dict[organism][0]
    diameter = clinical_data_dict[organism][2]
    env = clinical_data_dict[organism][3]
    # Put together into first sentence
    first_sentence = f'Organism {organism}, discovered by {discoverer}, has a diameter of {diameter}, and from the environment {env}.'
    
    # Put together second sentence
    genome_path = f'{inputDir}{file}'
    second_sentence = f'The list of genes can be found in: ./{genome_path}'
    
    # Read first sequence of genome
    with open(genome_path, 'r') as f:
        line1 = f.readline()
        line2= f.readline()
    # Put togther third sentence
    third_sentence = f'The first sequence of {organism} is:\n{line1}\n{line2}'

    # Create entry of information about organism and add to list
    entry = f'{first_sentence}\n\n{second_sentence}\n\n{third_sentence}\n\n\n'
    entries_to_write.append(entry)

# Write output file
with open("exomeReport.txt", 'w') as f:
    # Add entries for all organisms
    f.writelines(entries_to_write)

