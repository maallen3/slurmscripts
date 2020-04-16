#!/bin/bash 
#SBATCH --mail-type=ALL # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --nodes=1 # Run on a single node
#SBATCH --ntasks=16     # Number of CPU (processer cores i.e. tasks) In this example I use 1. I only need one, since none of the commands I run are parallelized.
#SBATCH --mem=20gb # Memory limit
#SBATCH --time=02:00:00 # Time limit hrs:min:sec


mkdir -p $outdir
bbmap_adapters=/scratch/Shares/dowell/Down/RNA/run040519/scripts/adapters.fa
name=${outdir}${name}
module load bbmap
bbduk.sh -Xmx20g t=16 in=$fastq1 \
                  in2=$fastq2 \
                  out=${name}_R1.trim.fastq \
                  out2=${name}_R2.trim.fastq \
                  ref=${bbmap_adapters} \
                  ktrim=r qtrim=10 k=23 mink=11 hdist=1 \
                  maq=10 minlen=25 tpe tbo \
                  literal=AAAAAAAAAAAAAAAAAAAAAAA \
                  stats=${name}.trimstats.txt \
                  refstats=${name}.refstats.txt \
                  ehist=${name}.ehist.txt
