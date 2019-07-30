#######################################################################
all: broadcast.o allreduce.o scatter.o approx_pi.o

#######################################################################

broadcast.o: broadcast.cpp
	mpicxx -O3 broadcast.cpp -o broadcast.exec

allreduce.o: allreduce.cpp
	mpicxx -O3 allreduce.cpp -o allreduce.exec

scatter.o: scatter.cpp
	mpicxx -O3 scatter.cpp -o scatter.exec

approx_pi.o: approx_pi.cpp
	mpicxx -std=c++11 approx_pi.cpp -o approx_pi.exec
