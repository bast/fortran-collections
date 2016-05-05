cmake_minimum_required(VERSION 2.8 FATAL_ERROR)

project(collections)

enable_language(CXX)
enable_language(Fortran)

add_library(collections src/collections.f90 src/collections.cpp)

add_executable(test test/test.f90)
add_dependencies(test collections)

target_link_libraries(test collections)
