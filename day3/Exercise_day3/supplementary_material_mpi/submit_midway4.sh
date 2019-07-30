#!/bin/bash -l

#SBATCH --ntasks=16

#SBATCH --time=00:02:00

#SBATCH --output=approx_pi.out
#SBATCH --error=approx_pi.err

# load the openmpi module
module load openmpi

### MPI executable
	mpirun ./approx_pi.exec
