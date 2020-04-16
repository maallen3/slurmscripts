
#indir=/scratch/Shares/dowell/Down/RNA/hoeffer/manmap/riboremoved/mapped/bams/
indir=/scratch/Shares/dowell/Down/RNA/hoeffer/manmapped_afterriboremove_bowtie2/mapped/sortedbams/

for pathandfilename in `ls $indir*.bam`; do
sbatch --export=bamfile=$pathandfilename countmis.slurm
done 


