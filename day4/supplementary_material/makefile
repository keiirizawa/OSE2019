### CPP compiler wrapper
CXX=mpicxx

### Optimization flags
FFLAGS=-O3 -fopenmp
#FFLAGS=-O3 -Xpreprocessor -fopenmp

all: pi_hybrid.exec 

pi_hybrid.exec: pi_hybrid.cpp
	$(CXX) $(FFLAGS) pi_hybrid.cpp -fopenmp -o pi_hybrid.exec

clean:
	rm -f *.exec
