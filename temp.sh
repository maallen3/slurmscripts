
name=Eli__repB__tech1.1
fastqdir=/scratch/Shares/dowell/Down/RNA/fastqrand/
fastq1=${fastqdir}${name}__R1.fastq
fastq2=${fastqdir}${name}__R2.fastq
outdir=/scratch/Shares/dowell/Down/RNA/run040519/
eandodir=/scratch/Shares/dowell/Down/RNA/run040519/scripts/e_and_o/
email=allenma@colorado.edu
indices_path=/scratch/Shares/public/genomes/hisatfiles/hg38/HISAT2/genome
fafile=/scratch/Shares/public/genomes/hisatfiles/hg38/hg38.fa
for pathandfilename in `ls ${fastqdir}*__R1.fastq`; do
name=`basename $pathandfilename __R1.fastq`
fastq1=${fastqdir}${name}__R1.fastq
fastq2=${fastqdir}${name}__R2.fastq
echo $name
echo $fastq1
done
