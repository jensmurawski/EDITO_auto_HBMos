#!/bin/bash
module load singularity
WRK=/gpfs/scratch/ehpc29/dmet577222/singularity_working
CONTAINER_LOCATION="/gpfs/projects/ehpc29/EDITO/containers/processor_self_contained.sif"
CONTAINER_ARGS="-B $WRK/out:/out -B $WRK/working:/working:rw -B $WRK/test_data:/test_data"

singularity run \
  $CONTAINER_ARGS \
  "${CONTAINER_LOCATION}" > singularity_log.txt 2>&1
