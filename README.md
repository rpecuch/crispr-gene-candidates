# CRISPR Gene Candidates Identification
# Author: Rita Pecuch 

The goal of this series of scripts is to identify samples with suitable CRISPR gene candidates and generate a report.

The below scripts should be executed in the order that they are presented.

## copyExomes.sh

The goal of this Bash script is to identify only samples that are between 20 and 30 mm long and have had their genomes sequenced.

Input files: 
- clinical_data.txt: list of samples with information such as discoverer and genome length
- exomes/: directory containing a fasta file for each sample in clinical_data.txt

Output files: 
- exomesCohort/: contains fasta file for each identified genome

Execution:

1) Copy over the following files into the directory that you would like to run the script:
- clinical_data.txt
- exomes/

2) Execute the following command: bash copyExomes.sh clinical_data.txt exomes/

## createCrisprReady.sh

The goal of this Bash script is to identify only sequences in each genome that contain at least 1 of the 3 highest occurring motifs (from a provided list of motifs).

Input files: 
- motif_list.txt: list of motifs
- exomesCohort/: directory containing a fasta file for each sample

Output files: 
- crisprReady/: contains fasta file for each sample with only sequences that contain at least 1 of the 3 highest occurring motifs

Execution:

1) Copy over the following files into the directory that you would like to run the script:
- motif_list.txt
- exomesCohort/

2) Execute the following command: bash createCrisprReady.sh motif_list.txt exomesCohort/

## identifyCrisprSite.sh

The goal of this Bash script is to identify only sequences in each genome that contain a suitable CRISPR site (an NGG sequence with at least 20 basepairs upstream, where N can be any base).

Input files: 
- crisprReady/: directory containing a fasta file for each sample

Output files: 
- crisprSites/: contains fasta file for each sample with only sequences that have a suitable CRISP site

Execution:

1) Copy over the following files into the directory that you would like to run the script:
- crisprReady/

2) Execute the following command: bash identifyCrisprSite.sh crisprReady/

## editGenome.sh

The goal of this Bash script is to insert the letter A before each occurrence of NGG (where N can be any base) in the input genomes.

Input files: 
- crisprSites/: directory containing a fasta file for each sample

Output files: 
- postCrispr/: contains fasta file for each sample with A inserted before NGG

Execution:

1) Copy over the following files into the directory that you would like to run the script:
- crisprSites/

2) Execute the following command: bash editGenome.sh crisprSites/

## exomeReport.py

The goal of this Bash script is to generate a report with the following information for each organism:
- Organism name
- Discoverer
- Diameter
- Environment
- First sequence
- Location of fasta file

Input files: 
- clinical_data.txt: list of samples with information such as discoverer and genome length
- postCrispr/: directory containing a fasta file for each sample

Output files: 
- exomeReport.txt: contains report findings

Execution:

1) Copy over the following files into the directory that you would like to run the script:
- clinical_data.txt
- postCrispr/

2) Execute the script. Depending on your Python version, you will use 1 of these commands:
- python3 exomeReport.py clinical_data.txt postCrispr/
- python exomeReport.py clinical_data.txt postCrispr/