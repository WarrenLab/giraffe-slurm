#!/bin/bash

if [[ -v $SLURM_CLUSTERS ]]; then
    SCRIPT_DIR=$(dirname $(scontrol -M $SLURM_CLUSTERS show job $SLURM_JOBID \
        | awk -F= '/Command=/{print $2}') | head -n 1)
else
    SCRIPT_DIR=$(dirname $(scontrol show job $SLURM_JOBID \
        | awk -F= '/Command=/{print $2}') | head -n 1)
fi
source ${SCRIPT_DIR}/../config.sh

library_id=$(head -n $SLURM_ARRAY_TASK_ID $SCRATCH_DIR/libraries.txt | tail -n 1)
r1Reads="$SCRATCH_DIR/reads/${library_id}_R1.fastq.gz"
r2Reads="$SCRATCH_DIR/reads/${library_id}_R2.fastq.gz"

vg giraffe -t $SLURM_CPUS_PER_TASK -p \
    -Z $SCRATCH_DIR/indices/pangenome.gbz \
    -m $SCRATCH_DIR/indices/pangenome.min \
    -d $SCRATCH_DIR/indices/pangenome.dist \
    -f $r1Reads -f $r2Reads \
    -N $library_id -R $library_id \
    > $SCRATCH_DIR/out/gam/${library_id}.gam
