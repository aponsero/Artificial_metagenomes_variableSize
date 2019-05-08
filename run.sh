#!/bin/sh
set -u
#
# Checking args
#

source scripts/config.sh

if [[ ! -d "$RESULT_DIR" ]]; then
  echo "$RESULT_DIR does not exist. Directory created"
  mkdir $RESULT_DIR
fi

if [[ "$MINI" -gt "$MAXI" ]]; then
    echo "provide a MINI argument inferior to MAXI"
    exit 1
fi

NUM_CHECK=cat $ | wc -l 
#check nb of lines in the document and compare to MINI
if [[ "$MINI" -gt "$NUM_CHECK" ]]; then
    echo "provide a MINI argument inferior to the number of genomes in the list"
    exit 1
fi

#check nb of lines in the document and compare to MAXI
if [[ "$MAXI" -gt "$NUM_CHECK" ]]; then
    echo "MAXI argument superior to inferior to the number of genomes in the list. The Maximum is set to the number of genomes in the list"
fi


#
# Job submission
#

PREV_JOB_ID=""
ARGS="-q $QUEUE -W group_list=$GROUP -M $MAIL_USER -m $MAIL_TYPE"

#
## 01-run abundance vectors
#

PROG="01-run-vectors"
export STDERR_DIR="$SCRIPT_DIR/err/$PROG"
export STDOUT_DIR="$SCRIPT_DIR/out/$PROG"

init_dir "$STDERR_DIR" "$STDOUT_DIR"

echo "launching $SCRIPT_DIR/run_abundance_vectors.sh "


JOB_ID=`qsub $ARGS -v WORKER_DIR,LIST_GENOMES,MINI,MAXI,NB_METAGENOMES,RESULT_DIR,STDERR_DIR,STDOUT_DIR -N run_vectors -e "$STDERR_DIR" -o "$STDOUT_DIR"  $SCRIPT_DIR/run_abundance_vectors.sh`

if [ "${JOB_ID}x" != "x" ]; then
    echo Job: \"$JOB_ID\"
    PREV_JOB_ID=$JOB_ID  
else
    echo Problem submitting job. Job terminated
fi
    
echo "job successfully submited"

#
## 02-run gemSim
#

PROG="02-run_GemSim"
export STDERR_DIR2="$SCRIPT_DIR/err/$PROG"
export STDOUT_DIR2="$SCRIPT_DIR/out/$PROG"

init_dir "$STDERR_DIR2" "$STDOUT_DIR2"

export SPLIT_LIST="$RESULT_DIR/profiles/files.list"

echo "launching $SCRIPT_DIR/run_GemSim.sh "

JOB_ID=`qsub $ARGS -v SPLIT_LIST,GENOMES_DIR,NB_READS,MODEL,REL_OUT,WORKER_DIR,STDERR_DIR2,STDOUT_DIR2 -N run_gemsim -e "$STDERR_DIR2" -o "$STDOUT_DIR2" -W depend=afterok:$PREV_JOB_ID -J 1-$NB_METAGENOMES $SCRIPT_DIR/run_GemSim.sh`

if [ "${JOB_ID}x" != "x" ]; then
    echo Job: \"$JOB_ID\"
    PREV_JOB_ID=$JOB_ID
else
    echo Problem submitting job. Job terminated
fi

echo "job successfully submited"
