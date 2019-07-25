all: normalize_vec.o dot_prod.o monte_pi.o
#######################################################################

# Problem 1:
normalize_vec.o: normalize_vec.cpp
	g++ -fopenmp normalize_vec.cpp -o nomalize_vec.exec
	#clang++ -Xpreprocessor -fopenmp normalize_vec.cpp -o normalize_vec.exec -lomp 

# Problem 2:
dot_prod.o: dot_prod.cpp
	g++ -fopenmp dot_prod.cpp -o dot_prod.exec
	#clang++ -Xpreprocessor -fopenmp dot_prod.cpp -o dot_prod.exec -lomp 

# Problem 3:
monte_pi.o: monte_pi.cpp
	g++ -std=c++11 -fopenmp monte_pi.cpp -o monte_pi.exec
	#clang++ -Xpreprocessor -fopenmp monte_pi.cpp -o monte_pi.exec -lomp 
#######################################################################


