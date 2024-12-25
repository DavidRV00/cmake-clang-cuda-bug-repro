cmake_minimum_required(VERSION 3.24 FATAL_ERROR)

# Needs to be specified before PROJECT
if(NOT DEFINED CMAKE_CUDA_ARCHITECTURES)
	set(CMAKE_CUDA_ARCHITECTURES 86)
endif()

PROJECT(bugrepro VERSION 0.0.1 LANGUAGES C CXX CUDA)

add_library(myclib src/myclib.c)
add_library(mycudalib SHARED src/kernel.h src/kernel.cu)
target_link_libraries(myclib mycudalib)
