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

#od
#bamroot
#bedgraphfortdfdir

#split to the first read and second read
samtools view -h -b -f 0x0040 ${od}${bamroot}.sorted.bam > ${bedgraphfortdfdir}${bamroot}.pairfirst.bam
samtools view -h -b -f 0x0080 ${od}${bamroot}.sorted.bam > ${bedgraphfortdfdir}${bamroot}.pairsecond.bam

#make bedgraphs for each file and each strand
genomeCoverageBed -bg -split -strand - -ibam ${bedgraphfortdfdir}${bamroot}.pairfirst.bam -g $genome >$outdir/genomecoveragebedpair/${entry}.pairfirst.pos.bed
genomeCoverageBed -bg  -split -strand + -ibam ${bedgraphfortdfdir}${bamroot}.pairfirst.bam -g $genome | awk -F '\t' -v OFS='\t' '{ $4 = - $4 ; print $0 }'> $outdir/genomecoveragebedpair/${entry}.pairfirst.neg.bed
genomeCoverageBed -bg -split -strand + -ibam  ${bedgraphfortdfdir}${bamroot}.pairsecond.bam -g $genome > $outdir/genomecoveragebedpair/${entry}.pairsecond.pos.bed
genomeCoverageBed -bg -split -strand - -ibam ${bedgraphfortdfdir}${bamroot}.pairsecond.bam -g $genome | awk -F '\t' -v OFS='\t' '{ $4 = - $4 ; print $0 }'> $outdir/genomecoveragebedpair/${entry}.pairsecond.neg.bed

#sort the bedgraphs
sortBed -i ${bedgraphfortdfdir}${bamroot}.pairfirst.pos.bed > ${bedgraphfortdfdir}${bamroot}.pairfirst.pos.BedGraph.sort
sortBed -i ${bedgraphfortdfdir}${bamroot}.pairfirst.neg.bed > ${bedgraphfortdfdir}${bamroot}.pairfirst.neg.BedGraph.sort
sortBed -i ${bedgraphfortdfdir}${bamroot}.pairsecond.pos.bed > ${bedgraphfortdfdir}${bamroot}.pairsecond.pos.BedGraph.sort
sortBed -i ${bedgraphfortdfdir}${bamroot}.pairsecond.neg.bed > ${bedgraphfortdfdir}${bamroot}.pairsecond.neg.BedGraph.sort

#put both pos together in two columns
unionBedGraphs -i ${bedgraphfortdfdir}${bamroot}.pairfirst.pos.BedGraph.sort ${bedgraphfortdfdir}${bamroot}.pairsecond.pos.BedGraph.sort >${bedgraphfortdfdir}${bamroot}.pos.Bedgraphcol
unionBedGraphs -i ${bedgraphfortdfdir}${bamroot}.pairfirst.neg.BedGraph.sort ${bedgraphfortdfdir}${bamroot}.pairsecond.neg.BedGraph.sort >${bedgraphfortdfdir}${bamroot}.neg.Bedgraphcol

#then I need to sum cols 4 and 5

awk -F '\t' '{OFS="\t"; print $1,$2,$3,$4+$5;}' ${bedgraphfortdfdir}${bamroot}.pos.Bedgraphcol >${bedgraphfortdfdir}${bamroot}.pos.Bedgraph
awk -F '\t' '{OFS="\t"; print $1,$2,$3,$4+$5;}' ${bedgraphfortdfdir}${bamroot}.neg.Bedgraphcol >${bedgraphfortdfdir}${bamroot}.neg.Bedgraph

#then I need to cat the two Bedgraphs

cat ${bedgraphfortdfdir}${bamroot}.pos.Bedgraph ${bedgraphfortdfdir}${bamroot}.neg.Bedgraph >${bedgraphfortdfdir}${bamroot}.bed

#then I need to sort the final Bedgraph so it can be divided by millions mapped and converted into tdf
${bedtoolsdir}sortBed -i ${bedgraphfortdfdir}${bamroot}.bed >${bedgraphfortdfdir}${bamroot}.Bedgraph


#now correct for millionsmapped
${pythondir}python ${bd}correctBedgraphmillionsmapped.py ${bgft}${bamroot}.BedGraph ${od}${bamroot}.sorted.bam.millionsmapped
echo finished correcting for millions mapped
${igvtoolsdir}igvtools toTDF ${bgft}${bamroot}.BedGraph.mp.BedGraph ${tdfd}${bamroot}.tdf $igvgenome
echo finished making tdf

