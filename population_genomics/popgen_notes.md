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

-   We created a file under `myscripts` called `ANGSD.sh` to estimate the genotype likelihoods

-   We created a file under `myscripts` called `ANGSD_doTheta` to estimate the SFS and nucleotide diversity stats for our population (2103)

-   The two above files were combined into a wrapper to send to SLURM customized with 10cpus and 64G RAM

-   All scripts are located in `~projects/eco_genomics_2025/population_genomics/myscripts`

### 09/23/25: Visualizing genomic diversity and intro to population structure

-   Fixed the failure with the scripts from last week, executed the "cut" command given at the end of the fourth tutorial `cut -f2-5,9,14 ${OUT}/${MYPOP}_${SUFFIX}_win${WIN}_step${STEP}.thetasWindow.gz.pestPG > ${OUT}/${MYPOP}_${SUFFIX}_win${WIN}_step${STEP}.thetas`

-   Outputs can be viewed in `~projects/eco_genomics_2025/population_genomics/myresults/ANGSD/diversity`

-   The correct output file is called `2103_ALL_win50000_step50000.thetas`

-   We created an R markdown file to display the nucleotide diversity

    -   We loaded two libraries, ggplot and tidyverse, then read in our theta outputs using read.table

    -   Then, we scaled our thetas using nSites

    -   Plotted a histogram of how many sites are in the window that got sequenced

    -   Plotted the points of nucleotide diversity as pi

-   Data from each population was put into a shared spreadsheet to compare different average values

-   The R markdown file is saved in `mydocs` and the shared spreadsheet is located in the classroom tutorial website

-   All files are located in `~projects/eco_genomics_2025/population_genomics`

### 09/25/25: Visualizing genomic diversity and intro to population structure

-   Knitted the R markdown file we created last time
    -   To edit in the future, open in a web browser
-   Created an bash script to use ANGSD to estimate Fst between our pops (2103) and the black spruce pop (95 red spruce samples and 18 black spruce samples in total)
-   The script is called `ANGSD_Fst.sh` and is located in `myscripts`
-   Included a sliding window analysis using a win size of 50kb and step of 50kb
-   The results for `ANGSD_Fst.sh` are located in `myresults/ANGSD/Fst`
    -   There is one file showing the results with the windows (`2103_WISC_Fst_50kbWindows.txt`) and one file showing the overall results using all the data (`2103_WISC_Fst.txt`)
    -   The Fst value we added to the shared spreadsheet is the second number in the `2103_WISC_Fst.txt` file
    -   Higher pi values show higher genetic diversity between the red and black spruce
-   While the `ANGSD_Fst.sh script` was running, we created another script called `PCAngsd_RSBS.sh` to run a PCA analysis assuming the data fits a single eigenvalue
    -   The outputs are saved in `/myresults/ANGSD/PCA_ADMIX`
-   We created an R markdown file called `PCA_Admixture.Rmd`
    -   We used K=2 to represent the red spruce and the black spruce populations
    -   We created a bar plot and a scatter plot for PCA as well as a heat map to show the admixture between the red and black spruce populations
    -   Evidence of hybridization seen in results
-   `PCA_Admixture.Rmd` was knitted and saved into `mydocs`

### 09/30/25: Genomic Scan for Selection

-   Started by opening `PCA_Admixture.html` from last class
    -   Quick review about PCA analysis
    -   bar plot explains 18% of the variance
    -   eigenvalue - variable that explains the maximum level of variance between the data points
    -   Right now, K=2 in the `PCAngsd_RSBS.sh` for one eigenvalue
    -   Change to K=3 for two eigenvalues and run SBATCH
        -   `cd projects/eco_genomics_2025/population_genomics/myscripts`
        -   `ls`
        -   `sbatch PCAngsd_RSBS.sh`
        -   `squeue --me`
    -   Did not show much change between graphs since the main variance is in the first eigenvalue
-   Made a new script called `PCAngsd_allRS_selection.sh`
-   Overwrote a few things from the `PCAngsd_RSBS.sh file`, but the majority of the file is the same
    -   See tutorial for added/changed code (K=3)
-   Run SBATCH
-   Create R markdown `RedSpruce_Selection.Rmd`
    -   Still have latitudinal axis for RS and still shows introgression
-   Based on the results showing the PC1 and PC2 scores against black spruce ancestry, they should both be examined
-   We created Manhattan plots for the values in PC1 and PC1 to see the log distribution of each sample
-   The R markdown file was knitted and both `RedSpruce_Selection.Rmd` and `RedSpruce_Selection.html` are saved into `mydocs`

### 10/03/25: Homework 1 Option B (Due 10/9)

-   Pulled up `PCAngsd_RSBS.sh` script from `myscripts`
    -   Note all red spruce and black spruce samples will be used as that part of the code was not changed from what was done in class
-   Need to have values of K=2,3,4,5 - already have 2 and 3 from previous runs
    -   Results of these runs are saved in `myresults/ANGSD/PCA_ADMIX`
    -   The necessary files are currently labeled `RSBS_poly_K2.cov` `RSBS_poly_K3.cov` `RSBS_poly_K2.admix.2.Q` `RSBS_poly_K3.admix.3.Q`
-   Using the aforementioned `PCAngsd_RSBS.sh` script to run for K=4,5
-   All K values are in the code, but they are commented out unless actively being used
-   K=4 run on terminal `sbatch PCAngsd_RSBS.sh` output will be saved in `myresults/ANGSD/PCA_ADMIX` the same as the other outputs from this script
    -   Waited for this run to end before running for K=5
-   Both runs completed! Now have all files necessary to make an Rmarkdown file to view results and make plots
-   Make a copy of `PCA_Admixture.Rmd` and called it `HW1_PCA_Admixture.Rmd` also saved in the `mydocs` folder
-   In the Rmarkdown file `HW1_PCA_Admixture.Rmd` made a code chunk for each of the K values to find the variance and make a bar plot
    -   Example of code chunk

    -   `K=2`

    -   `var <- round(PCA$values/sum(PCA$values),3)`

    -   `var[1:3]`

    -   `barplot(var,xlab="Eigenvalues of the PCA K=2", ylab="Proportion of variance explained K=2")`

    -   All screeplots look the same for each K value although the variance values are different

10/4/2025

-   Read in bam.list
-   Plotted PCA for each K value
    -   PCA plots look the same, but the % shown on the x and y axis change based on the K value
-   Under the "data wrangling" line, changed the code chunk to include `data=data[,c(1:5)]` to get more of the eigenvalues for the PCA plots
-   Need to go to office hours and check that PCA plots are correct and something is wrong with the admixture plots
