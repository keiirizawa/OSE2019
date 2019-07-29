#!/bin/bash -l

#SBATCH --ntasks=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=12

#SBATCH --time=00:01:00

#SBATCH --job-name=DP_scaling
#SBATCH --output=DP_scaling.out
#SBATCH --error=DP_scaling.err

# load the openmpi default module
module load openmpi

for i in `seq 1 10`; do
    echo "This uses $i number of CPU (threads):"
    export OMP_NUM_THREADS=$i
    mpirun ./VFI
    echo "\n"
done


