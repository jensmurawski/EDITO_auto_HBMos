# Script 1: Original script
#!/bin/bash
module load singularity
WRK=/gpfs/projects/ehpc29/EDITO/containers
CONTAINER_LOCATION="/gpfs/projects/ehpc29/EDITO/containers/processor_self_contained.sif"
CONTAINER_ARGS_PRE="--bind $WRK/working:/working,$WRK/out:/out,$WRK/test_data/:/test_data/"
singularity exec \
  $CONTAINER_ARGS_PRE \
  "${CONTAINER_LOCATION}"
  
