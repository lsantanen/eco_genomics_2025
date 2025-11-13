### Group Project Notes

### 11/11/25: First open lab

-   trying to get packages loaded

-   RNA data will be evaluated from raw data

-   new geospacial R needs to be used to access geodata library for climate data

-   RNA raw reads will be located in `/gpfs1/cl/ecogen/pbio6800/GroupProjects/picea_rnaseq/fastq_run1` and `.../run2`

-   get csv file from Steve with red spruce population info (table from first population genomics tutorial)

-   Will need to use `AGSD.sh` file from population genomics section to prepare data for RDA

-   work on agsd file

-   next time check with Steve about some things for the `ANGSD.sh` file saved in `group_project/myscripts`

### 11/13/2025: Second open lab day

-   copy `diversity_wrapper.sh` from `population_genomics/myscripts` into `group_project/myscripts`

-   change `ANGSD.sh` to create a directory in `/gpfs1/cl/ecogen/pbio6800/GroupProjects/spruceAgogo/RDA` (called ANGSD) so other people can access it

-   run `ANGSD.sh` for all pops so output file has all the data needed to put into RDA

    -   Changed suffix to `Poly` rather than `ALL`

    -   `ANGSD.sh` and `ANGSD_pops.sh` are both saved under `~/projects/eco_genomics_2025/group_project/myscripts`

    -   Gave `sbatch` a run time of 48 hours just to ensure it would have enough time
