#indir=/scratch/Shares/dowell/Down/RNA/fastqrand/
#indir=/scratch/Shares/dowell/Down/public/Sullivan/mouse/
indir=/scratch/Shares/allen_collab/pythonrat/data/downloaded_data/downloadSRP002796/

for pathandfilename in `ls $indir*.fastq`; do
sbatch --export=var=$pathandfilename zipfastq.slurm
done 


