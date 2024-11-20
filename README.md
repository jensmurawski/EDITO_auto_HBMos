# EDITO-auto-HBMos
This project was created for the `hbm.sif` singularity container
developed by DMI / John Lavelle. It was successfully tested 
on MareNostrum 5 and used in the EuroHPC project EHPC-BEN-2024B06-038 
`HBM benchmarking for EDITO On-demand modelling`. The HBMos model was
successfully deployed from EDITO-Model Lab using Autosubmit workflow
manager.   

The EuroHPC project EHPC-BEN-2024B06-038 `HBM benchmarking for EDITO
On-demand modelling` fulfills a technical milestone of the EDITO project, 
to configure and deploy HBMos from EDITO-Model Lab, and to run it 
on EuroHPC (MareNostrum 5) using Singularity and Autosubmit Workflow
manager. In the 2-nd phase of the project, the HBMos on-demand mode was run 
for a number of ocean-model configurations on MareNostrum 5 using
hybrid OpenMP-MPI paralelisations to evaluate the scalability of the code
on the new EuroHPC infrastructure for benchmarking accessments. 

The EDITO-auto-HBMos project is structured like the auto-schism2 project
which was developed by BSC and HEREON to demonstrate the functionality
of Autosubmit workflow manager. 

# auto-schism2

This project was created as a demo, for the `schism2.sif` singularity
container provided by Hereon / Benjamin. It was successfully tested
on MareNostrum 5 using a personal laptop with Autosubmit, and also
using EDITO Model Lab.

## Instructions

```bash
$ # Create a new Autosubmit experiment using this project
$ autosubmit expid \
    --HPC MN5 \
    --description "Benjamin Schism test" \
    --minimal_configuration \
    --git_repo https://earth.bsc.es/gitlab/bdepaula/auto-schism2.git \
    --git_branch main \
    --git_as_conf "conf/"
Autosubmit is running with 4.1.9
The new experiment "a000" has been registered.
Generating folder structure...
Experiment folder: /home/kinow/autosubmit/a000
Generating config files...
Experiment a000 created
```

Modify the `minimal.yml` created for your experiment, in this example:
`~/autosubmit/a000/conf/minimal.yml`. Please, add the following to
your file (indentation matters here).

 ```yaml
# These settings are not necessary for your experiment, but are required
# by Autosubmit: https://earth.bsc.es/gitlab/es/autosubmit/-/issues/1091
EXPERIMENT:
  DATELIST: "20000101"
  MEMBERS: "fc0"
  CHUNKSIZEUNIT: month
  CHUNKSIZE: "4"
  NUMCHUNKS: "2"
  CHUNKINI: ''
  CALENDAR: standard

PLATFORMS:
  MN5:
    TYPE: slurm
    HOST: glogin1.bsc.es
    PROJECT: bsc32
    # You need a valid BSC user, in this case from bsc, or adjust
    # the project above and maybe the scratch dir below if needed.
    # Write your username replacing <BSC32_USER>.
    USER: <BSC32_USER>
    QUEUE: gp_debug
    SCRATCH_DIR: /gpfs/scratch
    ADD_PROJECT_TO_HOST: false
    MAX_WALLCLOCK: 48:00
    TEMP_DIR: ''
 ```

Now run `autosubmit create a000`, followed by `autosubmit run a000`.

After some minutes, you should have successfully executed the workflow
locally, that submits a `SIM` to MareNostrum 5 (note that there is
no platform defined, but the `expid` command was called with `--HPC MN5`
to set the default platform).

You can verify the output log of the `SIM` task (copied to your local
environment by Autosubmit after the successful run of `SIM`) with:

 ```bash
$ autosubmit cat-log -f o a000_SIM
Autosubmit is running with 4.1.9
[INFO] JOBID=3779706

 
 schism develop
 git hash 4511e7e
OK!
 ```

This shows the version of Autosubmit used, and the ID of the Slurm job
executed, followed by the output of the Singularity execution.

For a real execution of the model, adjust the parameters of passed to
the Singularity container. Finally, if you are running this on another
platform, adjust the location of the container.

If you would like to confirm the Slurm jobs were executed, you can
also use the `JOBID` above to query for information, e.g.

```bash
$ sacct -j 3779706 -o jobid,submit,start,end,state
JobID                     Submit               Start                 End      State 
------------ ------------------- ------------------- ------------------- ---------- 
3779706      2024-07-10T13:28:15 2024-07-10T13:28:16 2024-07-10T13:28:20  COMPLETED 
3779706.bat+ 2024-07-10T13:28:16 2024-07-10T13:28:16 2024-07-10T13:28:20  COMPLETED 
3779706.ext+ 2024-07-10T13:28:16 2024-07-10T13:28:16 2024-07-10T13:28:20  COMPLETED 

```

You should also have logs copied to the computer where `autosubmit`
was launched from, e.g. `~/autosubmit/a000/tmp/{LOG_a000,ASLOGS}`.
