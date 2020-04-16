#!/bin/bash 
#SBATCH --mail-type=ALL # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --nodes=1 # Run on a single node
#SBATCH --ntasks=1     # Number of CPU (processer cores i.e. tasks) In this example I use 1. I only need one, since none of the commands I run are parallelized.
#SBATCH --mem=8gb # Memory limit
#SBATCH --time=01:00:00 # Time limit hrs:min:sec


echo qualjobinfo
sacct -j $jid0 --format=JobID,JobName,MaxRSS,Elapsed
echo trimjobinfo
sacct -j $jid1 --format=JobID,JobName,MaxRSS,Elapsed
echo flipjobinfo
sacct -j $jid2 --format=JobID,JobName,MaxRSS,Elapsed
echo mapped
sacct -j $jid3 --format=JobID,JobName,MaxRSS,Elapsed
echo samtools
sacct -j $jid4 --format=JobID,JobName,MaxRSS,Elapsed
pwd; hostname; date
