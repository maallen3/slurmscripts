#!/bin/bash 
#SBATCH --job-name=zipfastq # Job name
#SBATCH --mail-type=ALL # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --mail-user=allenma@colorado.edu # Where to send mail
#SBATCH --nodes=1 # Run on a single node
#SBATCH --ntasks=1     # Number of CPU (processer cores i.e. tasks) In this example I use 1. I only need one, since none of the commands I run are parallelized.
#SBATCH --mem=10gb # Memory limit
#SBATCH --time=01:00:00 # Time limit hrs:min:sec
#SBATCH --output=/Users/allenma/e_and_o/zip.%j.out # Standard output
#SBATCH --error=/Users/allenma/e_and_o/zip.%j.err # Standard error log



gunzip $var

