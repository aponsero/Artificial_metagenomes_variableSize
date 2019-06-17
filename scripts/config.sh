export CWD=$PWD
# where programs are
export GEMSIM=""
# where the dataset to prepare is
export LIST_GENOMES=""
export GENOMES_DIR="" #GemSim won't work if this is not relative to $GEMSIM
export RESULT_DIR=""
# parameters
export NB_READS="1000000" #nb reads to generate
export NB_METAGENOMES=60 #nb metagenomes to generate
export MODEL="models/ill100v4_p.gzip" #error/legth model to use
export MINI=5 #nb minimum of organisms in the metagenomes
export MAXI=50 #nb maximum of organisms in the metagenomes
#place to store the scripts
export SCRIPT_DIR="$PWD/scripts"
export WORKER_DIR="$SCRIPT_DIR/workers" 
# User informations
export QUEUE="standard"
export GROUP=""
export MAIL_USER=""
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
