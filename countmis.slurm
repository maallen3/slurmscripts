#!/bin/bash 
#SBATCH --job-name=reads # Job name
#SBATCH --mail-type=ALL # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=allenma@colorado.edu # Where to send mail
#SBATCH --nodes=1 # Run on a single node
#SBATCH --ntasks=1     # Number of CPU (processer cores i.e. tasks) In this example I use 1. I only need one, since none of the commands I run are parallelized.
#SBATCH --mem=1gb # Memory limit
#SBATCH --time=01:00:00 # Time limit hrs:min:sec
#SBATCH --output=/Users/allenma/e_and_o/slurm_test.%j.out # Standard output
#SBATCH --error=/Users/allenma/e_and_o/slurm_test.%j.err # Standard error log



module load samtools

samtools view $bamfile | wc -l > ${bamfile}.reads
samtools view $bamfile | grep --color=auto XM:i | wc -l >> ${bamfile}.reads
samtools view $bamfile | grep --color=auto XM:i:0 | wc -l >> ${bamfile}.reads
samtools view $bamfile | grep --color=auto XM:i:1 | wc -l >> ${bamfile}.reads
samtools view $bamfile | grep --color=auto XM:i:2 | wc -l >> ${bamfile}.reads
samtools view $bamfile | grep --color=auto XM:i:3 | wc -l >> ${bamfile}.reads
samtools view $bamfile | grep --color=auto XM:i:4 | wc -l >> ${bamfile}.reads
samtools view $bamfile | grep --color=auto XM:i:5 | wc -l >> ${bamfile}.reads
samtools view $bamfile | grep --color=auto XM:i:6 | wc -l >> ${bamfile}.reads
samtools view $bamfile | grep --color=auto XM:i:7 | wc -l >> ${bamfile}.reads
samtools view $bamfile | grep --color=auto XM:i:8 | wc -l >> ${bamfile}.reads
samtools view $bamfile | grep --color=auto XM:i:9 | wc -l >> ${bamfile}.reads
samtools view $bamfile | grep --color=auto XM:i:10 | wc -l >> ${bamfile}.reads

