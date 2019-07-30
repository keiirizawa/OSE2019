#!/bin/bash -l

#SBATCH --ntasks=16

#SBATCH --time=00:02:00

#SBATCH --output=scatter.out
#SBATCH --error=scatter.err

# load the openmpi module
module load openmpi

### MPI executable
	mpirun ./scatter.exec
