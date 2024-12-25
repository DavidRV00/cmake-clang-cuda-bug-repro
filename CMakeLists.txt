cmake_minimum_required(VERSION 3.24 FATAL_ERROR)

if(NOT DEFINED CMAKE_CUDA_ARCHITECTURES)
	set(CMAKE_CUDA_ARCHITECTURES 86)
endif()

PROJECT(bugrepro LANGUAGES C CXX CUDA)

add_library(mycudalib SHARED kernel.cu)
