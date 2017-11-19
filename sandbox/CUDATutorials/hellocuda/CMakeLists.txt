cmake_minimum_required (VERSION 2.8)
set (CMAKE_CXX_STANDARD 14)

find_package(CUDA QUIET REQUIRED)

# Pass options to NVCC
# set(
#     CUDA_NVCC_FLAGS
#     ${CUDA_NVCC_FLAGS};
#     -O3 -gencode arch=compute_22,code=sm_22
#     )


# Specify binary name and source file to build it from
cuda_add_executable(
    hellocuda
    hellocuda.cu)