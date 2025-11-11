#!/bin/bash

### load modules

module purge
module load gcc angsd


### Set up directories and variables

#mkdir ~/projects/eco_genomics_2025/population_genomics/mydata/ANGSD

INPUT="/gpfs1/cl/ecogen/pbio6800/PopulationGenomics/bams"

OUT="/gpfs1/cl/ecogen/pbio6800/GroupProjects/spruceAgogo/RDA"

REF="/gpfs1/cl/ecogen/pbio6800/PopulationGenomics/ref_genome/Pmariana/Pmariana1.0-genome_reduced.fa"

MYPOP="2103" #see if this will need to be run independently for each pop or if I can make a list

ls ${INPUT}/${MYPOP}*sorted.rmdup.bam >${OUT}/${MYPOP}_bam.list



# File suffix to distinguish analysis choices, like "All" or "Poly" depending on whether you're analyzing all the sites or just the polymorphic ones

SUFFIX="ALL"


###########################################
#  Estimating Genotype Likelihoods (GLs)  #
###########################################

angsd -b ${OUT}/${MYPOP}_bam.list \
-ref ${REF} \
-anc ${REF} \
-out ${OUT}/${MYPOP}_${SUFFIX} \
-nThreads 10 \
-remove_bads 1 \
-C 50 \
-baq 1 \
-minMapQ 20 \
-minQ 20 \
-GL 2 \
-doSaf 1 \
-doCounts 1 \
#increase minInd to 6 (values between 5-8 for large datasets)
-minInd 6 \
#increase setMinDepthInd to 5 for a more stringent filter
-setMinDepthInd 5 \
-setMaxDepthInd 40 \
-setMinDepth 10 \
-skipTriallelic 1 \
-doMajorMinor 4 \
##### below filters require `doMaf`
-doMaf 1 \
-SNP_pval 1e-6 \
-minMaf 0.01 \
-doGeno 1