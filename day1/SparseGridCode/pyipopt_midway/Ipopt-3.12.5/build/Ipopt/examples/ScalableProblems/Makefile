# Copyright (C) 2005, 2010 International Business Machines and others.
# All Rights Reserved.
# This file is distributed under the Eclipse Public License.

# $Id: Makefile.in 2016 2011-06-15 08:53:32Z stefan $

# Directory to the sources for the (example) problem definition files
SRCDIR = ../../../../Ipopt/examples/ScalableProblems
VPATH = ../../../../Ipopt/examples/ScalableProblems

# Compiler and options
CXX = g++
CXXFLAGS = -O3 -pipe -DNDEBUG -pedantic-errors -Wparentheses -Wreturn-type -Wcast-qual -Wall -Wpointer-arith -Wwrite-strings -Wconversion -Wno-unknown-pragmas -Wno-long-long   -DIPOPT_BUILD

# Archiver for C++ object files (e.g., needed to build a library on AIX to
# avoid multiply defined symbols for templates)
CXXAR = ar cru

# additional C++ Compiler options for linking
CXXLINKFLAGS =  -Wl,--rpath -Wl,/home/kirizawa/OSE2019/day1/SparseGridCode/pyipopt_midway/Ipopt-3.12.5/build/lib

# Include directories (we use the CYGPATH_W variables to allow compilation with Windows compilers)
INCL = `PKG_CONFIG_PATH=/home/kirizawa/OSE2019/day1/SparseGridCode/pyipopt_midway/Ipopt-3.12.5/build/lib64/pkgconfig:/home/kirizawa/OSE2019/day1/SparseGridCode/pyipopt_midway/Ipopt-3.12.5/build/lib/pkgconfig:/home/kirizawa/OSE2019/day1/SparseGridCode/pyipopt_midway/Ipopt-3.12.5/build/share/pkgconfig:/software/python-2.7.12-el7-x86_64/lib/pkgconfig:/software/openmpi-2.0.1-el7-x86_64/lib/pkgconfig:/software/serf-1.3.9-el7-x86_64/lib/pkgconfig pkg-config --cflags ipopt` $(ADDINCFLAGS) -I. -DHAVE_CONFIG_H
#INCL = -I`$(CYGPATH_W) /home/kirizawa/OSE2019/day1/SparseGridCode/pyipopt_midway/Ipopt-3.12.5/build/include/coin`  $(ADDINCFLAGS) -I. -DHAVE_CONFIG_H

LIB = libscalexamples.a

# Linker flags
LIBS = $(LIB) `PKG_CONFIG_PATH=/home/kirizawa/OSE2019/day1/SparseGridCode/pyipopt_midway/Ipopt-3.12.5/build/lib64/pkgconfig:/home/kirizawa/OSE2019/day1/SparseGridCode/pyipopt_midway/Ipopt-3.12.5/build/lib/pkgconfig:/home/kirizawa/OSE2019/day1/SparseGridCode/pyipopt_midway/Ipopt-3.12.5/build/share/pkgconfig:/software/python-2.7.12-el7-x86_64/lib/pkgconfig:/software/openmpi-2.0.1-el7-x86_64/lib/pkgconfig:/software/serf-1.3.9-el7-x86_64/lib/pkgconfig pkg-config --libs ipopt`
##LIBS = $(LIB) -link -libpath:`$(CYGPATH_W) /home/kirizawa/OSE2019/day1/SparseGridCode/pyipopt_midway/Ipopt-3.12.5/build/lib` libipopt.lib -llapack -lblas -lm  -ldl
#LIBS = $(LIB) -L/home/kirizawa/OSE2019/day1/SparseGridCode/pyipopt_midway/Ipopt-3.12.5/build/lib -lipopt -llapack -lblas -lm  -ldl

# Name of the executable
EXE = solve_problem

# List of all object files
MAINOBJ =  solve_problem.o

# List of all object files
LIBOBJS =  \
	MittelmannDistCntrlNeumA.o \
        MittelmannDistCntrlNeumB.o \
        MittelmannDistCntrlDiri.o \
        MittelmannBndryCntrlDiri.o \
        MittelmannBndryCntrlDiri3D.o \
        MittelmannBndryCntrlDiri3D_27.o \
        MittelmannBndryCntrlDiri3Dsin.o \
        MittelmannBndryCntrlNeum.o \
        LuksanVlcek1.o \
        LuksanVlcek2.o \
        LuksanVlcek3.o \
        LuksanVlcek4.o \
        LuksanVlcek5.o \
        LuksanVlcek6.o \
        LuksanVlcek7.o \
        RegisteredTNLP.o

all: $(EXE)

# Dependencies
LuksanVlcek1.o : LuksanVlcek1.hpp
LuksanVlcek2.o : LuksanVlcek2.hpp
LuksanVlcek3.o : LuksanVlcek3.hpp
LuksanVlcek4.o : LuksanVlcek4.hpp
LuksanVlcek5.o : LuksanVlcek5.hpp
LuksanVlcek6.o : LuksanVlcek6.hpp
LuksanVlcek7.o : LuksanVlcek7.hpp
MittelmannDistCntrlNeumA.o: MittelmannDistCntrlNeumA.hpp
MittelmannDistCntrlNeumB.o: MittelmannDistCntrlNeumB.hpp
MittelmannDistCntrlDiri.o: MittelmannDistCntrlDiri.hpp
MittelmannBndryCntrlDiri.o: MittelmannBndryCntrlDiri.hpp
MittelmannBndryCntrlDiri3D.o: MittelmannBndryCntrlDiri3D.hpp
MittelmannBndryCntrlDiri3D_27.o: MittelmannBndryCntrlDiri3D_27.hpp
MittelmannBndryCntrlDiri3Dsin.o: MittelmannBndryCntrlDiri3Dsin.hpp
MittelmannBndryCntrlNeum.o: MittelmannBndryCntrlNeum.hpp

solve_problem.o: \
	LuksanVlcek1.hpp \
	LuksanVlcek2.hpp \
	LuksanVlcek3.hpp \
	LuksanVlcek4.hpp \
	LuksanVlcek5.hpp \
	LuksanVlcek6.hpp \
	LuksanVlcek7.hpp \
	MittelmannDistCntrlNeumA.hpp \
	MittelmannDistCntrlNeumB.hpp \
	MittelmannDistCntrlDiri.hpp \
	MittelmannBndryCntrlDiri.hpp \
	MittelmannBndryCntrlDiri3D.hpp \
	MittelmannBndryCntrlDiri3D_27.hpp \
	MittelmannBndryCntrlDiri3Dsin.hpp \
	MittelmannBndryCntrlNeum.hpp \
	MittelmannParaCntrl.hpp

# The following is necessary under cygwin, if native compilers are used
CYGPATH_W = echo

.SUFFIXES: .cpp .c .o .obj

$(EXE): $(MAINOBJ) $(LIB)
	$(CXX) $(CXXFLAGS) $(CXXLINKFLAGS) -o $@ $(MAINOBJ) $(LIBS)

$(LIB): $(LIBOBJS)
	$(CXXAR) $(LIB) $(LIBOBJS)

clean:
	rm -rf $(EXE) $(MAINOBJ) $(LIBOBJS) $(LIB)

.cpp.o:
	$(CXX) $(CXXFLAGS) $(INCL) -c -o $@ `test -f '$<' || echo '$(SRCDIR)/'`$<


.cpp.obj:
	$(CXX) $(CXXFLAGS) $(INCL) -c -o $@ `if test -f '$<'; then $(CYGPATH_W) '$<'; else $(CYGPATH_W) '$(SRCDIR)/$<'; fi`
