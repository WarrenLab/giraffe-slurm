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

library_id=$(head -n $SLURM_ARRAY_TASK_ID $SCRATCH_DIR/libraries.txt | tail -n 1)

vg surject -t $SLURM_CPUS_PER_TASK \
    -x $SCRATCH_DIR/indices/pangenome.gbz \
    -b $SCRATCH_DIR/out/gam/${library_id}.gam \
    | samtools sort -@ $SLURM_CPUS_PER_TASK - \
    > $SCRATCH_DIR/out/bam/${library_id}.bam
samtools view -H $SCRATCH_DIR/out/bam/${library_id}.bam \
    | sed 's/bGalGal1b#0#//' > $SCRATCH_DIR/out/bam/${library_id}.header.txt
samtools reheader \
    $SCRATCH_DIR/out/bam/${library_id}.header.txt \
    $SCRATCH_DIR/out/bam/${library_id}.bam \
    > $SCRATCH_DIR/out/bam/${library_id}.reheadered.bam
mv $SCRATCH_DIR/out/bam/${library_id}.reheadered.bam \
    $SCRATCH_DIR/out/bam/${library_id}.bam
rm $SCRATCH_DIR/out/bam/${library_id}.header.txt
samtools index -@ $SLURM_CPUS_PER_TASK \
    $SCRATCH_DIR/out/bam/${library_id}.bam
