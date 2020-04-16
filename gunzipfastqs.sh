
indir=/scratch/Shares/dowell/Down/RNA/hoeffer/fastqpaired/

for pathandfilename in `ls $indir*.fastq.gz`; do
sbatch --export=var=$pathandfilename gunzipfastq.slurm
done 


