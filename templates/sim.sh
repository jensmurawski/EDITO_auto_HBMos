#!/bin/bash
module load singularity
WRK=/gpfs/projects/ehpc29/EDITO/containers
CONTAINER_LOCATION="/gpfs/projects/ehpc29/EDITO/containers/processor_self_contained.sif"
CONTAINER_ARGS="-B out:/out -B working:/working:rw -B test_data:/test_data"

singularity run \
  $CONTAINER_ARGS \
  "${CONTAINER_LOCATION}" > singularity_log.txt 2>&1
