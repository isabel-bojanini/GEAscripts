#!/bin/bash

module load vcftools/intel/0.1.16

for i in Bangladesh Cambodia China India Indonesia Thailand; do

vcftools --vcf indica_mac_geno_imp_804_005_v42.vcf\
         --weir-fst-pop subset_${i}_K6.csv \
         --fst-window-size 100000 \
         --fst-window-step 50000\
         --weir-fst-pop subset_not_${i}_K6.csv \
         --out ${i}_vs_all_not_50kstep${i}
done
