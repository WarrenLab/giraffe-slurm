# CONFIGURATION
#
# This file contains configuration options for the pipeline in the form of
# shell variables.

##################
# Paths to files #
##################
# SCRATCH_DIR should point to a high-speed IO directory where you want to do
# all the work. The pipeline will copy other files here at the beginning and
# then move the final results back at the end.
SCRATCH_DIR="/path/to/scratch/dir/"

# LIBRARIES_LIST is a tsv containing three columns:
# 1. The name of the sample or library
# 2. A comma-separated list of R1 fastq.gz files
# 3. A comma-separated list of R2 fastq.gz files
LIBRARIES_LIST="/path/to/libraries/list.tsv"

# INDEX_DIR should contain three index files: pangenome.gbz, pangenome.min,
# and pangenome.dist
INDEX_DIR="/path/to/index/directory/"

OUT_DIR="/path/to/out/directory/"

######################
# Cluster parameters #
######################
CLUSTER="biohpc_gen"
PARTITION="biohpc_gen_normal"

GIRAFFE_CPUS=20
GIRAFFE_MEM="50G"
GIRAFFE_TIME="12:00:00"

SURJECT_CPUS=20
SURJECT_MEM="50G"
SURJECT_TIME="6:00:00"

