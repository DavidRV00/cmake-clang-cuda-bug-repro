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
PROJECT(MySwigInterface)

set(CMAKE_VERBOSE_MAKEFILE on)

FIND_PACKAGE(SWIG REQUIRED)
INCLUDE(${SWIG_USE_FILE})

option(BUILD_SHARED_LIBS "Build using shared libraries" ON)

set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
include(CMakePrintHelpers)

file(GLOB_RECURSE SOURCES src/*.c)
add_library(
    myclib
    ${SOURCES}
)

set_target_properties(myclib PROPERTIES PUBLIC_HEADER include/myclib.h)

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

target_include_directories(myclib PRIVATE include)
target_include_directories(myclib PRIVATE src)

set(Python_FIND_VIRTUALENV FIRST)
set(Python_ADDITIONAL_VERSIONS 3.12)
find_package(Python3 3.12 COMPONENTS Interpreter Development NumPy REQUIRED)
INCLUDE_DIRECTORIES(${PYTHON_INCLUDE_PATH})

include_directories(${PYTHON_INCLUDE_DIRS})
target_link_libraries(myclib ${PYTHON_LIBRARIES} Python3::NumPy)

INCLUDE_DIRECTORIES(${CMAKE_CURRENT_SOURCE_DIR})

SET(CMAKE_SWIG_FLAGS "")

set(SWIG_SOURCE_FILE_EXTENSIONS ".i")

SET_SOURCE_FILES_PROPERTIES(
    myclib.i
    PROPERTIES SWIG_FLAGS "-includeall")

SET_SOURCE_FILES_PROPERTIES(
    myclib.i
    PROPERTIES SWIG_MODULE_NAME "myclib_python")

SWIG_ADD_LIBRARY(
    myclib_python
    TYPE MODULE
    LANGUAGE python
    SOURCES myclib.i
)

SWIG_LINK_LIBRARIES(myclib_python ${PYTHON_LIBRARIES} myclib)
