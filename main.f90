program testHDF5
  use HDF5

  implicit none


  integer, parameter :: dbleprc = kind(1.d0)
  integer, parameter :: smplprc = kind(1.0)

  real(dbleprc), allocatable, dimension(:,:)      :: data
  CHARACTER(LEN=50)                            :: filename
  CHARACTER(LEN=50)                            :: dsetname
  INTEGER(HID_T)                               :: file, dataset_id1
  INTEGER, PARAMETER                           :: rank = 2
  INTEGER(HSIZE_T), DIMENSION(2)               :: dims
  INTEGER(HID_T)                               :: dataspace

  integer              :: Nx = 50, Ny = 20, status


  !~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  !   Init DATA
  allocate(data(Nx,Ny))
  dims = (/Nx,Ny/)
  call random_number(data)

  !~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ! CREAT HDF5 file

  filename = "Datafile.h5"
  !Open the HDF5 interface
  CALL h5open_f(status)

  !creation of a new file
  CALL h5fcreate_f(filename ,H5F_ACC_TRUNC_F ,file ,status)
  !Dataspace creation
  CALL h5screate_simple_f(rank, dims, dataspace, status)


  !~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ! Creat 3 dataset with different writting options

  ! 1. Double To Real
  !Datasets creation
  dsetname = 'FromDouble'
  CALL h5dcreate_f(file, dsetname, H5T_NATIVE_REAL, dataspace, dataset_id1, status)
  CALL h5dwrite_f(dataset_id1, H5T_NATIVE_DOUBLe, real(data,dbleprc), dims, status)
  CALL h5dclose_f(dataset_id1 ,status)


  !2. Real to REAL
  dsetname = 'FromSimple'
  CALL h5dcreate_f(file, dsetname, H5T_NATIVE_REAL, dataspace, dataset_id1, status)
  CALL h5dwrite_f(dataset_id1, H5T_NATIVE_REAL, real(data,smplprc), dims, status)
  CALL h5dclose_f(dataset_id1 ,status)

  !3. double to Real with wrong option

  dsetname = 'FromdoubleTosimple'
  CALL h5dcreate_f(file, dsetname, H5T_NATIVE_REAL, dataspace, dataset_id1, status)
  CALL h5dwrite_f(dataset_id1, H5T_NATIVE_REAL, real(data,dbleprc), dims, status)
  CALL h5dclose_f(dataset_id1 ,status)

  !~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  !Closing all opened HDF5 objects
  CALL h5sclose_f(dataspace   ,status)
  CALL h5fclose_f(file        ,status)
  !close the HDF5 fortran interface
  CALL h5close_f(status)

end program testHDF5
