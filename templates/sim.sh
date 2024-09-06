#!/bin/bash

module load singularity

CONTAINER_LOCATION="/gpfs/projects/ehpc29/EDITO/containers/processor.sif"
CONTAINER_ARGS="from-env"

singularity exec \
  "${CONTAINER_LOCATION}" \
  ${CONTAINER_ARGS}

echo "OK!"
