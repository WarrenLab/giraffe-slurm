#!/bin/bash

set -e

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source ${SCRIPT_DIR}/../config.sh

reads_dir="$SCRATCH_DIR/reads"
mkdir -p $reads_dir
while read line; do
    library_id=$(echo "$line" | cut -f1)
    r1_reads=$(echo "$line" | cut -f2)
    r2_reads=$(echo "$line" | cut -f3)

    echo "copying: $library_id" 1>&2

    newloc_r1_reads="$reads_dir/${library_id}_R1.fastq.gz"
    newloc_r2_reads="$reads_dir/${library_id}_R2.fastq.gz"

    if [[ $r1_reads == *","* ]]; then
        cat $(echo $r1_reads | tr ',' ' ') > $newloc_r1_reads
        cat $(echo $r2_reads | tr ',' ' ') > $newloc_r2_reads
    else
        cp $r1_reads $newloc_r1_reads
        cp $r2_reads $newloc_r2_reads
    fi

    echo -e "$library_id\t$newloc_r1_reads\t$newloc_r2_reads"
done < $LIBRARIES_LIST > $SCRATCH_DIR/libraries.tsv

mkdir -p $SCRATCH_DIR/out/gam
mkdir -p $SCRATCH_DIR/out/bam

echo "Copying indices..." 1>&2
mkdir -p $SCRATCH_DIR/indices
cp $INDEX_DIR/* $SCRATCH_DIR/indices/
