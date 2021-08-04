cmake_minimum_required(VERSION 3.12)

project(cmake_playground)

set(CMAKE_CXX_STANDARD 17)

if (WIN32)
  set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
  add_definitions(/bigobj)
endif(WIN32)

set(CMAKE_VERBOSE_MAKEFILE OFF)

find_package(Threads REQUIRED)
set(THREADS_PREFER_PTHREAD_FLAG ON)

file(GLOB HEADERS "*.h")

add_executable(example example.cc ${HEADERS})

include(CTest)

include(FetchContent)
FetchContent_Declare(
  googletest
  URL https://github.com/google/googletest/archive/609281088cfefc76f9d0ce82e1ff6c30cc3591e5.zip
)
FetchContent_MakeAvailable(googletest)

enable_testing()

file(GLOB tests "${CMAKE_CURRENT_SOURCE_DIR}/test_*.cc")
foreach(i ${tests})
  get_filename_component(test_src "${i}" NAME)
  get_filename_component(test_bin "${i}" NAME_WE)
  add_executable(${test_bin} ${test_src} ${HEADERS})
  target_link_libraries(${test_bin} PRIVATE Threads::Threads gtest_main)
  add_test(NAME ${test_bin} COMMAND ${test_bin})
endforeach()
