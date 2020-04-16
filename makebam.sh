#!/bin/bash 
#SBATCH --mail-type=ALL # Mail events (NONE, BEGIN, END, FAIL, ALL)
#SBATCH --nodes=1 # Run on a single node
#SBATCH --ntasks=16     # Number of CPU (processer cores i.e. tasks) In this example I use 1. I only need one, since none of the commands I run are parallelized.
#SBATCH --mem=100gb # Memory limit
#SBATCH --time=10:00:00 # Time limit hrs:min:sec


mkdir -p $bamdir
mkdir -p $cramdir
mkdir -p $sortedbamdir 
###mapped_sam, bamdir, name, sortedbamdir, genome (Reference sequence FASTA FILE), cramdir
module load samtools
samtools view -@ 16 -bS -o ${bamdir}${name}.bam ${mapped_sam}
samtools flagstat ${bamdir}${name}.bam > ${bamdir}${name}.bam.flagstat
samtools sort -@ 16 ${bamdir}${name}.bam > ${sortedbamdir}${name}.sorted.bam
samtools flagstat ${sortedbamdir}${name}.sorted.bam > ${sortedbamdir}${name}.sorted.bam.flagstat
samtools view -@ 16 -cF 0x904 ${sortedbamdir}${name}.sorted.bam > ${sortedbamdir}${name}.sorted.bam.millionsmapped
samtools index ${sortedbamdir}${name}.sorted.bam ${sortedbamdir}${name}.sorted.bam.bai
samtools view -@ 16 -C -T ${genome} -o ${cramdir}${name}.cram ${sortedbamdir}${name}.sorted.bam
samtools sort -@ 16 -O cram ${cramdir}${name}.cram > ${cramdir}${name}.sorted.cram
samtools index -c ${cramdir}${name}.sorted.cram ${cramdir}${name}.sorted.cram.crai
diff ${bamdir}${name}.bam.flagstat ${sortedbamdir}${name}.sorted.bam.flagstat
echo Does the sorted bam have the same rnumber of reads as the unsored
