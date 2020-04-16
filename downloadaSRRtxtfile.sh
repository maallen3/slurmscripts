

#went to https://trace.ncbi.nlm.nih.gov/Traces/study/?go=home and searched for SRP051827 to download both the SRR list and the Sra-run-table
#to use type 
#bash downloadaSRR.sh <SRRtxtfile> <outdir> 


IFS=''
while read var
do
echo $var
sbatch --export=var=$var,outdir=$2 downloadafastq.slurm
done < $1 


