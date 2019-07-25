#!/bin/bash

#SBATCH --job-name=pi_hybrid

#SBATCH --output=pi_hybrid.out

# this job requests 4 MPI processes
#SBATCH --ntasks=4

# and request 8 cpus per task for OpenMP threads
#SBATCH --cpus-per-task=5

# this job will run in the broadwl partition on Midway
#SBATCH --partition=broadwl

# load the openmpi default module
module load openmpi

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

mpirun ./pi_hybrid.exec
