cmake_minimum_required(VERSION 3.24 FATAL_ERROR)

if(NOT DEFINED CMAKE_CUDA_ARCHITECTURES)
	set(CMAKE_CUDA_ARCHITECTURES 86)
endif()

PROJECT(
    aoc2024
    VERSION 0.0.1
	LANGUAGES C CXX CUDA
)

CMAKE_MINIMUM_REQUIRED(VERSION 3.24)

set(CMAKE_VERBOSE_MAKEFILE on)

option(BUILD_SHARED_LIBS "Build using shared libraries" ON)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
include(CMakePrintHelpers)

file(GLOB_RECURSE SOURCES src/*.c)
add_library(
    myclib
    ${SOURCES}
)

add_library(
    cudalib SHARED
    src/kernel.h src/kernel.cu
)
set_target_properties(
    cudalib
    PROPERTIES
        CUDA_RUNTIME_LIBRARY Shared
)
target_link_libraries(myclib cudalib)

target_include_directories(myclib PRIVATE src)

INCLUDE_DIRECTORIES(${CMAKE_CURRENT_SOURCE_DIR})
