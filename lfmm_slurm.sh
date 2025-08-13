#!/bin/bash
#
#SBATCH --nodes=1
#SBATCH --tasks-per-node=1
#SBATCH --cpus-per-task=1
#SBATCH --time=24:00:00
#SBATCH --mem=200GB
#SBATCH --job-name=lfmm_4
#SBATCH --mail-user=ib2382@nyu.edu
#SBATCH --mail-type=BEGIN
#SBATCH --mail-type=FAIL
#SBATCH --mail-type=END               
#SBATCH --array=1-3
module load r/gcc/4.1.0

# Get the task ID
task_id=$SLURM_ARRAY_TASK_ID

# Run the R script with the task ID as an argument
Rscript lfmm_run.R $task_id
#june_23_1 --> precipitation pc1
#june_23_2 --> temperature pc2
#june_23_3 --> water balance
