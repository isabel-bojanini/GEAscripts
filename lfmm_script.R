#!/usr/bin/env Rscript

# Load necessary libraries 
library(LEA)
library(dplyr)

# Get the task ID from the command-line arguments (if using SLURM ARRAY)
args <- commandArgs(trailingOnly = TRUE)
task_id <- as.numeric(args[1])  # This is to convert the argument to a numeric index

setwd("/scratch/ib2382/GEA/June_lfmm_804/K6/")

# Construct the filename based on the task ID. For this to work, your env file name needs to match this format. Keep track of how you name these.
env_file <- paste0("env_", task_id, ".env")

# Load the genotype data. It needs to be converted from vcf to lfmm format.
genotype <- vcf2lfmm("indica_mac_geno_imp_804_005.vcf")

# Load the corresponding environmental variable.
env <- read.table(env_file, header = FALSE)  # Assuming no header in env file, double check or this step will not work

# Run the LFMM analysis
lfmm_loading <- lfmm2(input = genotype, env = env, K = 6)
lfmm_association_test <- lfmm2.test(object = lfmm_loading, input = genotype, env = env)

# Construct the output filename based on the task ID
output_file <- paste0("july_3rd", task_id, ".rds") #this is used only in case of using SLURM ARRAY. keep track of your naming system. The date is only to keep track of when things were produced.

# Save the results to an RDS file
saveRDS(lfmm_association_test, file = output_file)

#print(paste("Finished processing environment variable from", env_file, "and saved results to", output_file))