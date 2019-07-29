#!/bin/bash

#SBATCH --job-name=pi_hybrid
#SBATCH --cpus-per-task=8
#SBATCH --output=pi_hybrid.out

# this job will run in the broadwl partition on Midway
#SBATCH --partition=broadwl

# load the openmpi default module
module load openmpi

localhost slots=25

for i in `seq 1 3`; do
    for j in `seq 8 10`; do
        echo "This uses $i MPI processors and $j OMP threads:"
        export OMP_NUM_THREADS=$j
        #SBATCH --ntasks=$i
        mpirun --hostfile hostfile -np $i ./pi_hybrid.exec
        echo "\n"
    done
done

