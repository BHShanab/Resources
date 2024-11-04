#!/bin/bash
## tc-wave.sh  -  demo Ansys Fluent batch job for Tinkercliffs
## Usage: set input file below, then "sbatch tc-fluent.sh"
#SBATCH --time=024:00:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=128
#SBATCH --cpus-per-task=1
#SBATCH --partition=normal_q
#SBATCH --account=leizuovt


module reset
module load ANSYS/22.1

cd $SLURM_SUBMIT_DIR

NODEFILE="$(pwd)/slurmhosts.$SLURM_JOB_ID.txt"
srun hostname -s &> $NODEFILE

ansysFile="ARC_Wave.wbpj"

fluent 3ddp -g -t $SLURM_NTASKS -cnf=$NODEFILE -mpi=intel -i $ansysFile > out_wNodeList.txt

echo "Normal end of execution."