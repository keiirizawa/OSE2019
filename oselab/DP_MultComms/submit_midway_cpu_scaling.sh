#!/bin/bash -l
#SBATCH --ntasks=8
#SBATCH --job-name=DP_scale
#SBATCH --cpus-per-task=28
#SBATCH --output=DP_cpu_scale.out

# this job will run in the broadwl partition on Midway
#SBATCH --partition=broadwl

# load the openmpi default module
module load openmpi


for j in `seq 1 5`; do
    echo "This uses 10 MPI nodes and $j OMP threads:"
    export OMP_NUM_THREADS=$j
    mpirun ./VFI
    echo "\n"
done
