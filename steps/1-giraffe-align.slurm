#!/bin/bash

source ../config.sh

library_id=$(head -n $SLURM_ARRAY_TASK_ID libraries_scratch.tsv | tail -n 1 | cut -f1)
r1Reads=$(head -n $SLURM_ARRAY_TASK_ID libraries_scratch.tsv | tail -n 1 | cut -f2)
r2Reads=$(head -n $SLURM_ARRAY_TASK_ID libraries_scratch.tsv | tail -n 1 | cut -f3)

vg giraffe -t $SLURM_CPUS_PER_TASK -p \
    -Z $SCRATCH_DIR/indices/pangenome.gbz \
    -m $SCRATCH_DIR/indices/pangenome.min \
    -d $SCRATCH_DIR/indices/pangenome.dist \
    -f $r1Reads -f $r2Reads \
    -N $library_id -R $library_id \
    > $SCRATCH_DIR/out/gam/${library_id}.gam
