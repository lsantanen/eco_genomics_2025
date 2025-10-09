#!/bin/bash   

#SBATCH --partition=general
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=16G
#SBATCH --time=1:00:00 
#SBATCH --job-name=Fastp_salmon_wrapper
#SBATCH --output=/users/l/s/lsantane/projects/eco_genomics_2025/transcriptomics/mylogs/%x_%j.out
#SBATCH --mail-type=ALL
#SBATCH --mail-user=lsantane@uvm.edu

cd /users/l/s/lsantane/projects/eco_genomics_2025/transcriptomics/myscripts

bash fastp_tonsa.sh

bash salmon_quant.sh