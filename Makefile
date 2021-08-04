.PHONY: all configure build run test clean

SRCS=$(wildcard *.cc)
HEADERS=$(wildcard *.h)
BUILD_DIR=../cmake_playground_build

all: configure build test

configure: ${BUILD_DIR}/configure.ok
build: ${BUILD_DIR}/build.ok

${BUILD_DIR}/configure.ok: CMakeLists.txt
	cmake -B ${BUILD_DIR} -Wno-dev
	touch ${BUILD_DIR}/configure.ok

${BUILD_DIR}/build.ok: ${BUILD_DIR}/configure.ok ${SRCS} ${HEADERS}
	cmake --build ${BUILD_DIR} -j $(shell nproc)
	touch ${BUILD_DIR}/build.ok

test: ${BUILD_DIR}/build.ok
	(cd ${BUILD_DIR}; ctest -vv)

run: ${BUILD_DIR}/build.ok ${BUILD_DIR}/example ${SRCS} ${HEADERS}
	${BUILD_DIR}/example
	
clean:
	rm -rf ${BUILD_DIR} .vs/
