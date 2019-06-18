# Artificial_metagenomes_variableSize
Pipeline for the generation of artificial metagenomes containing a variable number of organisms. Parrallelized for HPC.

The complete pipeline will generate K artificial metagenomes of a given sequencing depth (Nb of reads). The number of organisms in each metagenome is randomly chosen between a min and a max (defined by the user). 
IF SQUEUE is set to TRUE : the abundance distribution will be squeued. 1/5 of the organisms will represent around 60% of the total population.
If SQUEUE is set to FALSE : The abundance of each organisms in the metagenome is obtained by dividing the total number of reads by the number of organisms, the addition of a gaussian noise and a normalization.

## Requirements

### Python 3
This pipeline necessites Python3 as well as several packages :
  -[numpy] (https://www.numpy.org/)
  -[Sklearn] (https://scikit-learn.org/stable/)

### GemSim
This pipeline necessites to download and install [GemSim](https://bmcgenomics.biomedcentral.com/articles/10.1186/1471-2164-13-74) on the HPC.

## Quick start

### Edit scripts/config.sh file

please modify the following attributes

  - GEMSIM : path to the gemsim directory
  - LIST_GENOMES : list of genomes that will constitute the artificial metagenomes
  - GENOMES_DIR : path to the directory where the genomes are stored, Beware GemSim won't work if this is not relative to $GEMSIM
  - RESULT_DIR : path to the output directory
  - REL_OUT : relative path to the output dir for GEMSIM
# parameters
  - NB_READS : nb reads to generate
  - NB_METAGENOMES : nb metagenomes to generate
  - MODEL : error/length model to use
  - MINI : nb minimum of organisms in the metagenomes
  - MAXI : nb maximum of organisms in the metagenomes
  - SQUEUE : If set to TRUE, the abundance distribution will be squeued. 1/5 of the organisms will represent around 60% of the total population. If set to FALSE, the abundance distribution of the organisms will be almost homogeneous. 

  - OUTNAME  : indicate here the name to use for the output files
  - MAIL_USER : indicate here your arizona.edu email
  - GROUP : indicate here your group affiliation

You can also modify

  - BIN = change for your own bin directory.
  - MAIL_TYPE = change the mail type option. By default set to "bea".
  - QUEUE = change the submission queue. By default set to "standard".
  
  ### Run pipeline
  
  Run 
  ```bash
  ./submit.sh
  ```
  This command will place two jobs in queue.
  
