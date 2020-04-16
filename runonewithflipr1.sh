




name=Eli__repB__tech1.1
fastqdir=/scratch/Shares/dowell/Down/RNA/fastqrand/
fastq1=${fastqdir}${name}__R1.fastq
fastq2=${fastqdir}${name}__R2.fastq
outdir=/scratch/Shares/dowell/Down/RNA/run040519/
eandodir=/scratch/Shares/dowell/Down/RNA/run040519/scripts/e_and_o/
email=allenma@colorado.edu
indices_path=/scratch/Shares/public/genomes/hisatfiles/hg38/HISAT2/genome
fafile=/scratch/Shares/public/genomes/hisatfiles/hg38/hg38.fa
mkdir -p $eandodir

pwd; hostname; date
jid0=$(sbatch --export=fastq1=$fastq1,fastq2=$fastq2,outdir=${outdir}qual/ --job-name=${name} --error=${eandodir}${name}qual.%j.err --out=${eandodir}${name}qual.%j.out --mail-user=$email /scratch/Shares/dowell/Down/RNA/run040519/scripts/qual.sh)
jid0=$(echo $jid0 | cut -d ' ' -f 4-)
echo $jid0
jid1=$(sbatch --dependency=afterany:$jid0 --export=fastq1=$fastq1,fastq2=$fastq2,name=$name,outdir=${outdir}fastq/trim/ --job-name=${name} --error=${eandodir}${name}trim.%j.err --out=${eandodir}${name}trim.%j.out --mail-user=$email /scratch/Shares/dowell/Down/RNA/run040519/scripts/trim.sh) 
jid1=$(echo $jid1 | cut -d ' ' -f 4-)
echo $jid1
jid2=$(sbatch --dependency=afterany:$jid1 --export=fastq1=${outdir}fastq/trim/${name}_R1.trim.fastq,name=$name,outdir=${outdir}fastq/flip/ --job-name=${name}flip --error=${eandodir}${name}flip.%j.err --out=${eandodir}${name}flip.%j.out --mail-user=$email /scratch/Shares/dowell/Down/RNA/run040519/scripts/flip.sh)
jid2=$(echo $jid2 | cut -d ' ' -f 4-)
echo $jid2
jid3=$(sbatch --dependency=afterany:$jid2 --export=fastq1=${outdir}fastq/flip/${name}_R1.trim.flip.fastq,fastq2=${outdir}fastq/trim/${name}_R2.trim.fastq,name=$name,outdir=${outdir}mapped/sams/,indices_path=$indices_path --job-name=${name}hisat2 --error=${eandodir}${name}hisat2.%j.err --out=${eandodir}${name}hisat2.%j.out --mail-user=$email /scratch/Shares/dowell/Down/RNA/run040519/scripts/map.sh)
#jid3=$(sbatch --dependency=afterany:$jid2 --export=fastq1=${outdir}fastq/trim/${name}_R1.trim.fastq,fastq2=${outdir}fastq/trim/${name}_R2.trim.fastq,name=$name,outdir=${outdir}mapped/sams/,indices_path=$indices_path --job-name=${name}hisat2 --error=${eandodir}${name}hisat2.%j.err --out=${eandodir}${name}hisat2.%j.out --mail-user=$email /scratch/Shares/dowell/Down/RNA/run040519/scripts/map.sh)
jid3=$(echo $jid3 | cut -d ' ' -f 4-)
echo $jid3
###mapped_sam, bamdir, name, sortedbamdir, genome (Reference sequence FASTA FILE), cramdir
jid4=$(sbatch --dependency=afterany:$jid3 --export=mapped_sam=${outdir}mapped/sams/${name}.sam,bamdir=${outdir}mapped/bams/,name=${name},sortedbamdir=${outdir}mapped/sortedbams/,genome=$fafile,cramdir=${outdir}mapped/crams/ --job-name=${name}bams --error=${eandodir}${name}bams.%j.err --out=${eandodir}${name}bams.%j.out --mail-user=$email /scratch/Shares/dowell/Down/RNA/run040519/scripts/makebam.sh)
jid4=$(echo $jid4 | cut -d ' ' -f 4-)
echo $jid4
jid5=$(sbatch --dependency=afterany:$jid4 --export=jid0=$jid0,jid1=$jid1,jid2=$jid2,jid3=$jid3,jid4=$jid4 --job-name=${name}stats --error=${eandodir}${name}stats.%j.err --out=${eandodir}${name}stats.%j.out --mail-user=$email /scratch/Shares/dowell/Down/RNA/run040519/scripts/jobstats.sh)
