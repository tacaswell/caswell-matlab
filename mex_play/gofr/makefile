objects = new_gofr.o general.o particle.o grid.o grid_box.o t_mex.o

INCLUDE    = -I$(MATLABHOME)/extern/include


MEXSUFFIX  = mexa64
MATLABHOME = /usr/local/matlab
MEX        = mex
CXX        = g++
CXXFLAGS   =   -ansi -D_GNU_SOURCE -fPIC -fno-omit-frame-pointer -pthread  -DMX_COMPAT_32 $(INCLUDE)
LIBS       = -lm

MEXFLAGS   = -cxx CC='$(CXX)' CXX='$(CXX)' LD='$(CXX)'
CXXLIBS    = -Wl,-rpath-link,/usr/local/matlab/bin/glnxa64 -L/usr/local/matlab/bin/glnxa64 -lmx -lmex -lmat -lm



new_gofr: $(objects)
	g++ -g -o new_gofr $(objects)

new_gofr.o: particle.h grid.h grid_box.h t_mex.h
general.o: general.h
particle.o:particle.h general.h 
grid.o: particle.h grid.h grid_box.h t_mex.h grid_box2.h
grid_box.o: particle.h grid_box.h
t_mex.o: t_mex.h

new_gofr.$(MEXSUFFIX): $(objects)
	  $(MEX) $(MEXFLAGS) $(LIBS) -output new_gofr $^


.PHONY : clean
clean :
	-rm $(objects) new_gofr new_gofr.mexglx
