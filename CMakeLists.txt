cmake_minimum_required(VERSION 3.22)
project(ElOS C)

set(CMAKE_C_STANDARD 99)

include_directories(includes/)

add_executable(ElOS src/kernel/kernel.c)
