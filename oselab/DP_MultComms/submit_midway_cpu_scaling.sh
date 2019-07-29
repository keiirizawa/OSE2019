#!/bin/bash
# a sample job submission script to submit a hybrid MPI/OpenMP job to the sandyb 
# partition on Midway1 please change the --partition option if you want to use 
# another partition on Midway1

#SBATCH --time=00:01:00

# set the job name to hello-hybrid
#SBATCH --job-name=DP_scaling

# send output to hello-hybrid.out
#SBATCH --output=DP_scaling.out

# this job requests 5 MPI processes
#SBATCH --ntasks=5

# and request 16 cpus per task for OpenMP threads
#SBATCH --cpus-per-task=16

# this job will run in the sandyb partition on Midway1
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

