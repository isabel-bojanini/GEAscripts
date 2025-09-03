#!/bin/bash
#
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4         
#SBATCH --time=12:00:00
#SBATCH --mem=100GB
#SBATCH --job-name=LDKIT
#SBATCH --mail-user=ib2382@nyu.edu
#SBATCH --mail-type=BEGIN,FAIL,END
#SBATCH --array=1-12
#SBATCH --output=logs/LDKIT_%A_%a.out
#SBATCH --error=logs/LDKIT_%A_%a.err

module load jdk/11.0.9

# Make sure the log directory exists
mkdir -p logs

# Get chromosome name for this array index
CHROM=$(sed -n "${SLURM_ARRAY_TASK_ID}p" chromosome_names.txt)

# Run LDkit
java -jar ~/LDkit/LDkit.jar \
  --infile /scratch/ib2382/GEA/June_lfmm_804/K6/indica_mac_geno_imp_804_005.vcf \
  --out /scratch/ib2382/GEA/June_lfmm_804/LD_decay/results/${CHROM}_file \
  --ws 1000 \
  --chr ${CHROM} \
  --threads 4
