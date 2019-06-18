export CWD=$PWD
# where programs are
export GEMSIM=""
# where the dataset to prepare is
<<<<<<< HEAD
export LIST_GENOMES="/rsgrps/bhurwitz/alise/my_data/De_Novo_meta/Simulated_datasets/SimSetM_genomes.txt"
export GENOMES_DIR="../../my_data/De_Novo_meta/Simulated_datasets/orginal_genomes" #GemSim won't work if this is not relative to $GEMSIM
export RESULT_DIR="/rsgrps/bhurwitz/alise/my_data/De_Novo_meta/Simulated_datasets/SimSetM2_2"
export REL_OUT="../../my_data/De_Novo_meta/Simulated_datasets/SimSetM2_2" #output dir relative to $GEMSIM
=======
export LIST_GENOMES=""
export GENOMES_DIR="" #GemSim won't work if this is not relative to $GEMSIM
export RESULT_DIR=""
>>>>>>> 933ec2ca6e2f52e901e9f5982a9e116a448c1aa4
# parameters
export NB_READS="50000000" #nb reads to generate
export NB_METAGENOMES=2 #nb metagenomes to generate
export MODEL="models/ill100v4_p.gzip" #error/legth model to use
export MINI=5 #nb minimum of organisms in the metagenomes
export MAXI=50 #nb maximum of organisms in the metagenomes
export QUEUE="TRUE" 
#TRUE if the distribution is squeued (1/5 of the organisms represent around 60% of the total abundance). If False, the relative abundance distribution of the organisms will be almost homogeneous.

#place to store the scripts
export SCRIPT_DIR="$PWD/scripts"
export WORKER_DIR="$SCRIPT_DIR/workers" 
# User informations
export QUEUE="standard"
export GROUP="bhurwitz"
export MAIL_USER="aponsero@email.arizona.edu"
export MAIL_TYPE="bea"

#
# --------------------------------------------------
function init_dir {
    for dir in $*; do
        if [ -d "$dir" ]; then
            rm -rf $dir/*
        else
            mkdir -p "$dir"
        fi
    done
}

# --------------------------------------------------
function lc() {
    wc -l $1 | cut -d ' ' -f 1
}
