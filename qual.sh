#!/bin/bash 
#SBATCH --mail-type=ALL # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --nodes=1 # Run on a single node
#SBATCH --ntasks=1     # Number of CPU (processer cores i.e. tasks) In this example I use 1. I only need one, since none of the commands I run are parallelized.
#SBATCH --mem=8gb # Memory limit
#SBATCH --time=01:00:00 # Time limit hrs:min:sec


mkdir -p $outdir
module load fastqc
fastqc $fastq1 -o $outdir
fastqc $fastq2 -o $outdir 

