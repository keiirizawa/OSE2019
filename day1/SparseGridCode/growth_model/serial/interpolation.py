#======================================================================
#
#     This routine interfaces with the TASMANIAN Sparse grid
#     The crucial part is 
#
#     aVals[iI]=solver.initial(aPoints[iI], n_agents)[0]  
#     => at every gridpoint, we solve an optimization problem
#
#     Simon Scheidegger, 11/16 ; 07/17
#======================================================================

import TasmanianSG
import numpy as np
from parameters import *
import nonlinear_solver_initial as solver
import nonlinear_solver_iterate as solveriter


#======================================================================

def sparse_grid(n_agents, iDepth, adaptive=False):
    
    grid  = TasmanianSG.TasmanianSparseGrid()

    # range of k grid 
    k_range=np.array([k_bar, k_up])

    ranges=np.empty((n_agents, 2))  # lower and upper bound for each agent (dimension)


    for i in range(n_agents):
        ranges[i]=k_range

    iDim=n_agents

    grid.makeLocalPolynomialGrid(iDim, iOut, iDepth, which_basis, "localp")
    grid.setDomainTransform(ranges)  ### Sets the lower and upper bound for each dimension

    aPoints=grid.getPoints()  
    ### returns the points needed to form the interpolant or the next
    ### level of refinement following a set***Refinement() call

    iNumP1=aPoints.shape[0]
    aVals=np.empty([iNumP1, 1])  # space to store value for value function at that interpolation evaluated point
    

    if adaptive:
        file=open("comparison0.txt", 'w')
        for i in range(refinement_level):
            grid.setSurplusRefinement(fTol, -1, "fds")   #also use fds, or other rules
            aPoints = grid.getNeededPoints()
            aVals = np.empty([aPoints.shape[0], 1])
            for iI in range(iNumP1):
                aVals[iI] = solver.initial(aPoints[iI], n_agents)[0]
                v=aVals[iI]*np.ones((1,1))
                to_print=np.hstack((aPoints[iI].reshape(1,n_agents), v))
                np.savetxt(file, to_print, fmt='%2.16f')
                
    else: 
        file=open("comparison0.txt", 'w')
        for iI in range(iNumP1):
            aVals[iI]=solver.initial(aPoints[iI], n_agents)[0]
            v=aVals[iI]*np.ones((1,1))
            to_print=np.hstack((aPoints[iI].reshape(1,n_agents), v))
            np.savetxt(file, to_print, fmt='%2.16f')
        
    file.close()
    grid.loadNeededPoints(aVals)
    
    f=open("grid.txt", 'w')
    np.savetxt(f, aPoints, fmt='% 2.16f')
    f.close()
    
    return grid
#======================================================================

