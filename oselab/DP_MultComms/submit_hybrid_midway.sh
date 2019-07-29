#!/bin/bash
# a sample job submission script to submit a hybrid MPI/OpenMP job to the sandyb 
# partition on Midway1 please change the --partition option if you want to use 
# another partition on Midway1

#SBATCH --time=00:01:00

# set the job name to hello-hybrid
#SBATCH --job-name=hello-hybrid

# send output to hello-hybrid.out
#SBATCH --output=hello-hybrid_30_2.out

# this job requests 5 MPI processes
#SBATCH --ntasks=30


# and request 16 cpus per task for OpenMP threads
#SBATCH --cpus-per-task=28

# this job will run in the sandyb partition on Midway1
#SBATCH --partition=broadwl

# load the openmpi default module
module load openmpi

# set OMP_NUM_THREADS to the number of --cpus-per-task we asked for
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

# Run the process with mpirun. Notice -n is not required. mpirun will
# automatically figure out how many processes to run from the slurm options
mpirun ./VFI


for i in `seq 1 3`; do
    for j in `seq 8 10`; do
        echo "This uses $i MPI processors and $j OMP threads:"
        export SLURM_NTASKS=$i
        export OMP_NUM_THREADS=$j
        mpirun -np $SLURM_NTASKS ./pi_hybrid.exec
        echo "\n"
    done
done
