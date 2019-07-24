#!/bin/bash -l

#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=8

#SBATCH --time=00:01:00

#SBATCH --job-name=normalize_vec
#SBATCH --output=normalize_vec.out
#SBATCH --error=normalize_vec.err

for i in `seq 1 8`; do
    echo "This uses $i number of threads:"
    export OMP_NUM_THREADS=$i
    ./normalize_vec.exec


