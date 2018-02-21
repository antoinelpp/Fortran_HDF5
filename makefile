#FF= mpiifort
FF= mpif90

DBG = -ffree-line-length-0 -Wno-error #-traceback -g -debug -check all
#DBG = -g -fdump-core -fbacktrace -Warray-bounds -Wall -Wextra -fcheck=all -pedantic-errors -pedantic
OPT = #-O2

HDF5_DIR = /usr/lib/x86_64-linux-gnu/hdf5/mpich

LIBS = -lm
LIB  = -L$(HDF5_DIR) -lhdf5hl_fortran -lhdf5_hl -lhdf5_fortran -lhdf5

INCLUDE    = -I/usr/include/hdf5/mpich

a.bin: main.o
	            $(FF) $(WARN) $(DBG) $(OPT)   $^ -o $@ $(FLAGS) $(LIB) $(LIBE)# ${PETSC_KSP_LIB}

main.o: main.f90
	           $(FF)  $(DBG) $(OPT)  $(LIB) $<  -c $(INCLUDE)

clean:
	rm -fv *.o *.mod *~ chibre.bin
##############################
