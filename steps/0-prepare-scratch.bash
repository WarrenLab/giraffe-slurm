#!/bin/bash

set -e

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source ${SCRIPT_DIR}/../config.sh

reads_dir="$SCRATCH_DIR/reads"
mkdir -p $reads_dir
while read line; do
    library_id=$line

    echo "copying: $library_id" 1>&2

    cat $(find $LIBRARIES_DIR -name "${library_id}*_1.fq.gz") \
        > "$reads_dir/${library_id}_R1.fastq.gz"
    cat $(find $LIBRARIES_DIR -name "${library_id}*_2.fq.gz") \
        > "$reads_dir/${library_id}_R2.fastq.gz"
done < $LIBRARIES_LIST
cp $LIBRARIES_LIST $SCRATCH_DIR/libraries.txt

mkdir -p $SCRATCH_DIR/out/gam
mkdir -p $SCRATCH_DIR/out/bam

echo "Copying indices..." 1>&2
mkdir -p $SCRATCH_DIR/indices
cp $INDEX_DIR/* $SCRATCH_DIR/indices/
