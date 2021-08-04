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

add_executable(test_one test_one.cc ${HEADERS})
target_link_libraries(test_one PRIVATE Threads::Threads gtest_main)

add_executable(test_two test_two.cc ${HEADERS})
target_link_libraries(test_two PRIVATE Threads::Threads gtest_main)

add_test(NAME test_one COMMAND test_one)
add_test(NAME test_two COMMAND test_two)
