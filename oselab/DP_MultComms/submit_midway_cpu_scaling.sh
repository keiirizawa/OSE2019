#!/bin/bash -l
#SBATCH --ntasks=8
#SBATCH --job-name=DP_scale
#SBATCH --cpus-per-task=8
#SBATCH --output=DP_scale.out

# this job will run in the broadwl partition on Midway
#SBATCH --partition=broadwl

# load the openmpi default module
module load openmpi


for i in `seq 1 3`; do
    for j in `seq 8 10`; do
        echo "This uses $i MPI processors and $j OMP threads:"
        export SLURM_NTASKS=$i
        export OMP_NUM_THREADS=$j
        mpirun -np $SLURM_NTASKS ./VFI
        echo "\n"
    done
done
