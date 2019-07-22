#======================================================================
#
#     This routine solves an infinite horizon growth model 
#     with dynamic programming and sparse grids
#
#     The model is described in Scheidegger & Bilionis (2017)
#     https://papers.ssrn.com/sol3/papers.cfm?abstract_id=2927400
#
#     external libraries needed:
#     - IPOPT (https://projects.coin-or.org/Ipopt)
#     - PYIPOPT (https://github.com/xuy/pyipopt)
#     - TASMANIAN (http://tasmanian.ornl.gov/)
#
#     Simon Scheidegger, 11/16 ; 07/17
#======================================================================

import nonlinear_solver_initial as solver     #solves opt. problems for terminal VF
import nonlinear_solver_iterate_shock as solviter   #solves opt. problems during VFI
from parameters import *                      #parameters of model
import interpolation as interpol              #interface to sparse grid library/terminal VF
import interpolation_iter_shock as interpol_iter    #interface to sparse grid library/iteration
import postprocessing as post                 #computes the L2 and Linfinity error of the model

import TasmanianSG                            #sparse grid library
import numpy as np


#======================================================================
# Start with Value Function Iteration

# terminal value function
valnew_list = np.array([TasmanianSG.TasmanianSparseGrid(), TasmanianSG.TasmanianSparseGrid(), TasmanianSG.TasmanianSparseGrid(), 
                    TasmanianSG.TasmanianSparseGrid(), TasmanianSG.TasmanianSparseGrid()])

if (numstart==0):
    for i in range(len(valnew_list)):
        valnew_list[i] = interpol.sparse_grid(n_agents, iDepth)
        valnew_list.write("valnew_1." + str(numstart) + ".txt") #write file to disk for restart

# value function during iteration
else:
    valnew_list.read("valnew_1." + str(numstart) + ".txt")  #write file to disk for restart
    
valold_list=np.array([TasmanianSG.TasmanianSparseGrid(), TasmanianSG.TasmanianSparseGrid(), TasmanianSG.TasmanianSparseGrid(), 
                    TasmanianSG.TasmanianSparseGrid(), TasmanianSG.TasmanianSparseGrid()])
valold_list=valnew_list

theta_list = [0.9, 0.95, 1., 1.05, 1.1]

for i in range(numstart, numits):
    for theta in theta_list:
        print('i = {}'.format(i))
        valnew_list = np.array([TasmanianSG.TasmanianSparseGrid(), TasmanianSG.TasmanianSparseGrid(), TasmanianSG.TasmanianSparseGrid(), 
                        TasmanianSG.TasmanianSparseGrid(), TasmanianSG.TasmanianSparseGrid()])
        if i % 5 != 0:
            for i in range(len(valnew_list)):
                valnew_list[i] = interpol_iter.sparse_grid_iter(valold_list[i], theta, valold_list)
        else:
            for i in range(len(valnew_list)):
                valnew_list[i] = interpol_iter.sparse_grid_iter(valold_list[i], theta, valold_list, adaptive = True)
        
        valolds = np.array([TasmanianSG.TasmanianSparseGrid(), TasmanianSG.TasmanianSparseGrid(), TasmanianSG.TasmanianSparseGrid(), 
                        TasmanianSG.TasmanianSparseGrid(), TasmanianSG.TasmanianSparseGrid()])
        
        # valnew.plotPoints2D()
    valold_list = valnew_list
    valnew_list.write("valnew_1." + str(i+1) + ".txt")
# Does not check until threshold and instead iterates and updates valnew until numits (iteration to end)
    
#======================================================================
print( "===============================================================")
print( " " )
print( " Computation of a growth model of dimension ", n_agents ," finished after ", numits, " steps")
print( " " )
print( "===============================================================")
#======================================================================

# compute errors   
avg_err=post.ls_error(n_agents, numstart, numits, No_samples)

#======================================================================
print( "===============================================================")
print( " ")
print( " Errors are computed -- see errors.txt")
print( " ")
print( "===============================================================")
#======================================================================
