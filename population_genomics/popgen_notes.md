# Population Genomics Notebook

## Fall 2025 Ecological Genomics

## Author: Lauren Santanen

This will keep my notes on population genomics coding sessions

### 09/11/25: Cleaning fastq reads of red spruce

-   We wrote a bash script called fastp.sh located within my Github repo:

`~/projects/eco_genomics_2025/population_genomics/myscripts`

myscripts folder. We used this to trim the adapters out of our red spruce fastq sequence files.

-   The raw fastq files were located on the class share space:

`/gpfs1/cl/ecogen/pbio6800/PopulationGenomics/fastq/red_spruce`

-   Using the program fastp, we processed the raw reads and output and cleaned reads to the following directory on the class shared space:

`/gpfs1/cl/ecogen/pbio6800/PopulationGenomics/cleanreads`

-   Fastp produced html-formatted reports for each sample, which I saved into the directory:

`~/projects/eco_genomics_2025/population_genomics/myresults/fastp_reports`

-   The results showed high quality sequence with most Q-scores being much greater than 20, and low amount of adapted contamination, which we trimmed out. We also trimmed out the leading 12 base pairs to get rid of the barcoded indices.

-   Cleaned reads are now ready to proceed to the nect step in our pipeline: mapping to the reference genome!

### 09/16/25: Mapping our cleaned reads to the reference genome

-   We used the clean reads to map to the black spruce reference genome using bwa-mem2

-   The reference genome is provided here:

    -   `gpfs1/cl/ecogen/pbio6800/PopulationGenomics/ref_genome/Pmariana`

-   We modified the script mapping.sh to work on our specific population samples and saved the resulting sequence aligmnent files (.sam) to the class shared space here

`gpfa1/cl/ecogen/pbio6800/PopulationGenomics/bams`

-   We submitted this to the VACC SLURM scheduler using sbatch requesting 10cpus and 64G ram

-   We noticed that some nodes the jobs would land on appeared to have a cpu architecture that was not compatible with the program (bwa-mem2). The solution to this was to resubmit the job via sbatch until we (randomly) landed on a compatible node

-   While that was running, we created scripts for processing the bams (`process_bam.sh`) using the program `sambamba` to convert sam to bam, sort, remove PCR duplicates and index

-   Lastly. we created a script (`bam_stats.sh`) to get mapping and coverage stats from our alignments

-   Because these latter two scripts can run after the initial mapping completes, we wrote a wrapper script to execute both `process_bam.sh` and `bam_stats.sh` and submit to SLURM

-   All scripts are located in `~projects/eco_genomics_2025/population_genomics/myscripts`

### 09/18/25: Review bamstats and set up nucleotide diversity estimation using ANGSD

-   Wrote a short script called `bamstats_review.r` located in myscripts to evaluate the mapping success

    -   Saw roughly 66% of reads mapped in proper pairs

    -   Obtained depth of coverage between 2-3X -\> suggests we need to use a probabilistic framework for the genotype data
