#!/bin/bash

module load singularity

CONTAINER_LOCATION="/gpfs/projects/ehpc29/EDITO/containers/processor_self_contained.sif"
CONTAINER_ARGS="-B out:/out -B working:/working:rw"

singularity exec \
  "${CONTAINER_LOCATION}" \
  ${CONTAINER_ARGS}

echo "OK!"
