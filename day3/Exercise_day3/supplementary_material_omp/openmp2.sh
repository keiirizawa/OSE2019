#!/bin/bash -l

#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=10

#SBATCH --time=00:01:00

#SBATCH --job-name=dot_prod
#SBATCH --output=dot_prod.out
#SBATCH --error=dot_prod.err
#SBATCH --partition=broadwl

for i in `seq 1 8`; do
    echo "This uses $i number of threads:"
    export OMP_NUM_THREADS=$i
    ./dot_prod.exec
done

