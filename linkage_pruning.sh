#!/bin/bash
#
#SBATCH --nodes=1
#SBATCH --tasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=1:00:00
#SBATCH --mem=25GB
#SBATCH --job-name=process_snp
#SBATCH --mail-user=ib2382@nyu.edu
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=FAIL
#SBATCH --mail-type=END

module load plink2/20230417

prefix="plink_indica_mac_geno_imp_804_005"

# First step of linkage pruning
plink2 --bfile ${prefix} \
       --allow-extra-chr \
       --indep-pairwise 10 kb 1 0.8 \
       --out ${prefix}_ld_1

plink2 --bfile ${prefix} \
       --extract ${prefix}_ld_1.prune.in \
       --allow-extra-chr \
       --make-bed \
       --out ${prefix}_10kb
       