cmake_minimum_required (VERSION 2.6)
set ( CMAKE_CXX_STANDARD 11)
project ( microbe )

set ( CMAKE_CXX_STANDARD 11)


find_package( CUDA QUIET REQUIRED )

# LIST(APPEND CMAKE_CXX_FLAGS "-std=c++0x -O3 -ffast-math -Wall")
# nvcc flags                                                                                                                                                                                               
# set(CUDA_NVCC_FLAGS ${CUDA_NVCC_FLAGS};-gencode arch=compute_61,code=sm_61)

include_directories ( ${PROJECT_SOURCE_DIR}/include )

file (GLOB SRC_FILES 
    ${PROJECT_SOURCE_DIR}/include/*.h
    ${PROJECT_SOURCE_DIR}/src/*.cpp
    ${PROJECT_SOURCE_DIR}/src/*.cu
    )

SET(CUDA_SEPARABLE_COMPILATION ON)

cuda_add_executable ( microbe main.cu ${SRC_FILES} )