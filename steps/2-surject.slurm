#!/bin/bash

set -e

source ../config.sh

library_id=$(head -n $SLURM_ARRAY_TASK_ID libraries_scratch.tsv | tail -n 1 | cut -f1)

vg surject -t $SLURM_CPUS_PER_TASK \
    -x $SCRATCH_DIR/indices/pangenome.gbz \
    -b $SCRATCH_DIR/out/gam/${library_id}.gam \
    > $SCRATCH_DIR/out/bam/${library_id}.bam
