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

### 10/16/2025: Gene Expression and Analysis Continued (DESeq cont.)

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

### 10/21/2025: Continue Data Visualization (DESeq cont.)

-   Reminder: `DESeq_notes.rmd` is saved under `mydocs` and has been used continuously since 10/14
-   Left off last week on plotting individual genes, this time move on to making an MA plot
-   Updated code was provided for plotting individual genes to make a clearer graph, so code was updated in `DESeq_notes.rmd`
    -   Gene name is listed as "XXX" in code but can be filled in with any of the genes directly above
-   The tutorial has typical questions above each code chunk for the plots
    -   i.e. what does this plot potentially answer
-   Create a heatmap to visualize the top 100 genes
-   Explore differentially expressed genes from each generation
    -   Created and saved results files for all the different contrasts from each generation
-   Take the sig genes from G1 and create a heatmap to see how they change across generations
    -   See if we can make the same plot focusing on the generation 2 significant genes
    -   Change every instance of `G1` in code to `G2` and change matrix name from `lfc_mat` to `lfc_mat2` to ensure there's no interference with original graph
    -   Can see there's more genes expressed in G2 than in G1
    -   Can see that G1, G3, and G4 are all more similar to each other than to G2
-   Go on to make a Venn or Euler plot
    -   Focus on comparing G1, G2, and G3 because G3 and G4 are very similar and making a Venn diagram with 4 categories becomes very complicated
        -   Not every comparison is able to be made and there are too many categories which makes it very tedious to calculate
    -   Overlapping 214 genes are most likely doing opposite things in the two different generations (G1 and G2)
    -   Based on the previous plots made
-   Make sure to have `library(eulerr)` loaded to make the Euler plot
    -   Can have it up at the top of the code with the other loaded libraries, or can just add it to the top of the code chunk - either way run it first!

### 10/23/2025: DESeq2 to TopGO

-   Created a new R markdown file called `DESeq2toTopGO.rmd` and saved it in `mydocs`
-   Using the outputs we created last class from DESeq2 we started putting data into TopGO
-   Created a few different plots to visualize data a bit before exploring all the differentially expressed genes
    -   Looked at differential expression contrast, distribution of results, relationships between the metrics, and a density plot with a rugplot to understand what was tested in the functional enrichment test
-   Then ran TopGO to see the GO enrichment
-   Created an output txt file called `topGOsig_for_REVIGO.txt` which can be copy-pasted into revigo and see the results that it outputs like different plots
-   Note for markdown script created today, the paths weren't working although the root directory was loaded, so all files had to have the complete path with them
