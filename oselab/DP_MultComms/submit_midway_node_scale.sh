#!/bin/bash -l
#SBATCH --ntasks=8
#SBATCH --job-name=DP_node_scale
#SBATCH --cpus-per-task=28
#SBATCH --output=DP_node_scale.out

# this job will run in the broadwl partition on Midway
#SBATCH --partition=broadwl

# load the openmpi default module
module load openmpi


for i in `seq 1 5`; do
    echo "This uses $i MPI processors and 28 OMP threads:"
    export SLURM_NTASKS=$i
    export OMP_NUM_THREADS=$j
    mpirun -np $SLURM_NTASKS ./pi_hybrid.exec
    echo "\n"
done


