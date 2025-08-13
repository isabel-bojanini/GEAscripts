#!/bin/bash

module load bcftools/intel/1.14
module load plink2/20210103

plink2 --vcf indica_957_het_mac_geno_imp.vcf.gz --keep keep_804_names.txt \
--allow-extra-chr --make-bed --out Shuhui_804_SNP_biallel_HT_VQSR90_het_mac_imp

#plink2 --bfile Shuhui_804_SNP_biallel_HT_VQSR90_het_mac_imp --recode vcf-iid \
# --out indica_mac_geno_804 --allow-extra-car

plink2 --bfile Shuhui_804_SNP_biallel_HT_VQSR90_het_mac_imp \
  --export vcf id-paste=iid \
  --out indica_mac_geno_imp_804 \
  --allow-extra-chr

bcftools view -q 0.05:minor indica_mac_geno_imp_804.vcf -Oz -o indica_mac_geno_imp_804_005.vcf.gz

bcftools index indica_mac_geno_imp_804_005.vcf.gz
echo “done”


#I ran this command on a later date. I wanted to convert vcf to bfiles to later use in lfmm result analysis
plink2 --vcf indica_mac_geno_imp_804_005.vcf \
	--allow-extra-chr --make-bed \
	--out plink_indica_mac_geno_imp_804_005

#to get allele frequencies
plink2 --bfile plink_indica_mac_geno_imp_804_005 \
	--freq  --out plink_indica_mac_geno_imp_804_005_freq \
	--allow-extra-chr