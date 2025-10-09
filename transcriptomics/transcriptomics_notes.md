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
