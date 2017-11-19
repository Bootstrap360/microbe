cmake_minimum_required (VERSION 2.6)
set ( CMAKE_CXX_STANDARD 14)
project ( microbe )

set ( CMAKE_CXX_STANDARD 14)

find_package( CUDA QUIET REQUIRED )

include_directories ( ${PROJECT_SOURCE_DIR}/include )

file (GLOB SRC_FILES 
    ${PROJECT_SOURCE_DIR}/inclde/*.h
    ${PROJECT_SOURCE_DIR}/src/*.cpp
    ${PROJECT_SOURCE_DIR}/src/*.cu
    )

cuda_add_executable ( microbe main.cu ${SRC_FILES} )