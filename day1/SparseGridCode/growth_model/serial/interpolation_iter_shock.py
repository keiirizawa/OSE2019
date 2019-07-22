#======================================================================
#
#     This routine interfaces with the TASMANIAN Sparse grid
#     The crucial part is 
#
#     aVals[iI]=solveriter.iterate(aPoints[iI], n_agents)[0]  
#     => at every gridpoint, we solve an optimization problem
#
#     Simon Scheidegger, 11/16 ; 07/17
#======================================================================

import TasmanianSG
import numpy as np
from parameters import *
import nonlinear_solver_iterate_shock as solveriter

#======================================================================

def sparse_grid_iter(grid, theta, valold_list, adaptive=False):
    
    # grid  = TasmanianSG.TasmanianSparseGrid()

    # k_range=np.array([k_bar, k_up])

    # ranges=np.empty((n_agents, 2))


    # for i in range(n_agents):
    #     ranges[i]=k_range

    # iDim=n_agents
    # iOut=1

    # grid.makeLocalPolynomialGrid(iDim, iOut, iDepth, which_basis, "localp")
    # grid.setDomainTransform(ranges)  ### Sets the lower and upper bound for each dimension

    aPoints=grid.getPoints()
    iNumP1=aPoints.shape[0]
    #if adaptive:
        #print('aPoints', aPoints)
    

    if adaptive:
        print('adapt iterloop')
        # file=open("comparison1.txt", 'w')
        for i in range(1):
            grid.setSurplusRefinement(fTol, -1, "fds")   #also use fds, or other rules
            #print('grid', grid)
            aPoints = grid.getNeededPoints()
            aVals = np.empty([aPoints.shape[0], 1])
            #print('aP', aPoints)
            #print('aVals', aVals)
            for iI in range(iNumP1):
                aVals[iI] = solveriter.iterate(aPoints[iI], theta, n_agents, valold_list)[0]
                v=aVals[iI]*np.ones((1,1))
                # to_print=np.hstack((aPoints[iI].reshape(1,n_agents), v))
                # np.savetxt(file, to_print, fmt='%2.16f')

            # file.close()
            grid.loadNeededPoints(aVals)


                
    else:
        print('dont adapt iterloop')
        aVals=np.empty([iNumP1, 1]) 
        # file=open("comparison1.txt", 'w')
        for iI in range(iNumP1):
            aVals[iI]=solveriter.iterate(aPoints[iI], theta, n_agents, valold_list)[0]
            v=aVals[iI]*np.ones((1,1))
            # to_print=np.hstack((aPoints[iI].reshape(1,n_agents), v))
            # np.savetxt(file, to_print, fmt='%2.16f')
        
        #file.close()
        grid.loadNeededPoints(aVals)
    
    f=open("grid_iter.txt", 'w')
    np.savetxt(f, aPoints, fmt='% 2.16f')
    f.close()
    
    return grid

#======================================================================
