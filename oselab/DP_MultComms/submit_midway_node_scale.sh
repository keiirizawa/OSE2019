#!/bin/bash -l
#SBATCH --ntasks=15
#SBATCH --job-name=DP_node_scale
#SBATCH --cpus-per-task=28
#SBATCH --output=DP_node28_15_scale.out

# this job will run in the broadwl partition on Midway
#SBATCH --partition=broadwl

# load the openmpi default module
module load openmpi

export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

for i in `seq 1 15`; do
    echo "This uses $i MPI processors and 28 OMP threads:"
    export SLURM_NTASKS=$i
    mpirun -np $SLURM_NTASKS ./VFI
    echo "\n"
done


