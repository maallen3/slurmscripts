#!/bin/bash 
#SBATCH --mail-type=ALL # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --nodes=1 # Run on a single node
#SBATCH --ntasks=16     # Number of CPU (processer cores i.e. tasks) In this example I use 1. I only need one, since none of the commands I run are parallelized.
#SBATCH --mem=20gb # Memory limit
#SBATCH --time=02:00:00 # Time limit hrs:min:sec


mkdir -p $outdir

name=${outdir}$name

module load seqkit
seqkit seq -j 16 -r -p \
                  $fastq1 \
                  -o ${name}_R1.trim.flip.fastq


