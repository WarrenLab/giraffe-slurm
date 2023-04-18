#!/bin/bash

set -e

if [[ -v $SLURM_CLUSTERS ]]; then
    SCRIPT_DIR=$(dirname $(scontrol -M $SLURM_CLUSTERS show job $SLURM_JOBID \
        | awk -F= '/Command=/{print $2}') | head -n 1)
else
    SCRIPT_DIR=$(dirname $(scontrol show job $SLURM_JOBID \
        | awk -F= '/Command=/{print $2}') | head -n 1)
fi
source ${SCRIPT_DIR}/../config.sh

library_id=$(head -n $SLURM_ARRAY_TASK_ID $SCRATCH_DIR/libraries.tsv | tail -n 1 | cut -f1)

vg surject -t $SLURM_CPUS_PER_TASK \
    -x $SCRATCH_DIR/indices/pangenome.gbz \
    -b $SCRATCH_DIR/out/gam/${library_id}.gam \
    > $SCRATCH_DIR/out/bam/${library_id}.bam
