######### PCADAPT ANALYSIS #########

#Dataset, LD pruned using 10KB windows and 0.8 threshold
K7=readRDS("/scratch/ib2382/GEA/June_lfmm_804/PCAdapt/ld_10k_pruned/pcadapt7.rds")

#Investigating outliers
hist(K7$pvalues, xlab = "p-values", main = NULL, breaks = 50, col = "blue")
plot(K7, option = "manhattan")
plot(K7, option = "qqplot")

#FDR Correction
qvalues=p.adjust(K7$pvalues, method="fdr")

#Merging q.values with genome data
snp_maf_table = read.table("/scratch/ib2382/GEA/June_lfmm_804/K6_10kb_pruning/plink_indica_mac_geno_imp_804_005_10kb.bim", header=FALSE)
snp_maf_table = snp_maf_table %>% dplyr::select(V1,V4)

nrow(snp_maf_table)
snp_maf_table$SNP= paste0("Os", 1:nrow(snp_maf_table))

colnames(snp_maf_table)=c("CHROM", "POS","SNP")
snp_maf_table$CHROM_NUM <- snp_maf_table$CHROM  # copy column

CHROM_NAME <- unique(snp_maf_table$CHROM)

for (i in seq_along(CHROM_NAME)) {
  snp_maf_table$CHROM_NUM[snp_maf_table$CHROM == CHROM_NAME[i]] <- i
}

q.value.snp=cbind(snp_maf_table,qvalues) #merge the two dataframes

#store values for further analysis
write.csv(q.value.snp,"/scratch/ib2382/GEA/June_lfmm_804/PCAdapt/ld_10k_pruned/q.values.pcadapt.csv",row.names = F)
