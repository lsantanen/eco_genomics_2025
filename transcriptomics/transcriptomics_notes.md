### Transcriptomics Module

This is a place for me to keep my notes on my electronic/server activities during the transcriptomics module

### 10/07/2025: Intro to Study System

-   Learned about the motivation and process of asking questions and analyzing RNAseq data

-   Started to run fastp to clean and visualize the data quality in our fastq files, but ran into file recognition issues

-   To be continued on Thursday

### 10/09/2025: Clean and Visualize Reads

-   Provided script was copied and saved into `transcriptomics/myscripts` and is called `fastp_tonsa.sh`

-   Tried to run `fastp_tonsa.sh` scripts, but ran into errors and timing issues

-   Scripts were taking too long to run, so created a wrapper with the `fastp_tonsa.sh` and `salmon_quant.sh` and ran sbatch in the terminal so everything would be ready for next class

### 10/14/2025: Mapping and Counts Matrix

-   Discussion of why mapping rate is so low, likely because the clade was mismatched

-   Species is so diverged that it should be considered a subspecies

-   start with a fastq file

    -   go through cleaning, mapping, DGE analysis

    -   Making decisions all along the way that can impact results

    -   Test things along the way to see how the results are effected

-   PCA predictions

    -   Controls cluster
    -   G1 in treatment cluster further away
    -   Replicates within a group cluster with each other
    -   In the treatment-gradation from G1 to G4
    -   Control, maybe adaptation/acclimation

-   Factors

    -   Temperature line
    -   Generation

-   General framework

    -   GE\~Line+Gen+Line:Gen

-   Used the code

    \grep -r --include "*.log" -e "Mapping rate"\
    \| sed -E 's\|/logs/.*:.\*Mapping rate = ([0-9.]+)%\|\t\1\|'

in the terminal to create a txt file in `myresults\` to see the mapping rates

-   Roughly 40% mapping rate

-   Created an R code to create a counts matrix `create_counts_matrix.r` is saved in `myscripts` and the output is a txt file called `counts_matrix.txt` saved under `mydata`

    -   Note since this is an R script it needs to be run one line at a time, so need to click down through each line
    -   Needed to change `write.txt` to `write.table` and the rest of the code told it to be a `txt` file
    -   The code used is saved under Transcriptomics Tutorial 3

-   The code run above prepped `quant.sf` files to be imported into DESeq2

**DESeq2 start of data analysis**

-   copied the `metadata.txt` file from the class directory into `mydata`

-   created an R markdown to visualize the reads and variation

-   explored patterns in the data

-   defined the DESeq2 object

-   stopped here and will create a PCA plot next time

### 10/16/2025: Gene Expression and Analysis Continued

-   Opened `DESeq_notes.rmd` from last class located in `mydocs`

-   Last class was data exploration, and this time we will run DESeq2

-   Left off talking about expected patterns of PCA

-   Pick up with actually making the PCA from the tutorial

-   Looking at two different types of distributions

    -   See average expression from 0 to 15,000 and a line of average expression (std dev)

-   Made a heat map based on the sample distance matrix, how dissimilar is each sample from every other sample

-   Along 1:1 line is the sample compared to itself

    -   Nothing too crazy in the results

-   Moved on to making a cluster tree to see outlier samples (`hclust`)

    -   No outliers just like as seen in the previous step

-   Now onto PCA...

    -   Distinct clustering of G4 in control and treatment

    -   G1 and G4 are separated by PC1

    -   All generations separated along PC1, which explains 32% of the variance

    -   PC2 splits control and treatment for G3 and G2

    -   PC axes are larger than we've seen previously, which is based on the data

        -   DNA vs RNA - what are you looking at

-   Made another PCA graph to try an optimize the data visualization

-   Move on to testing for differential gene expression using the group model

-   Pull out results of interest and reorder them by significance

-   Plot individual genes

    -   Just input the gene names into the code to see the expressions

-   All work was done in `DESeq2_notes.rmd`

-   Continue next week with heat map, MA plot, and Euler plot
