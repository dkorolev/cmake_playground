.PHONY: run all configure build test clean indent

SRCS=$(wildcard *.cc)
HEADERS=$(wildcard *.h)
BUILD_DIR=../cmake_playground_build

run: ${SRCS} ${HEADERS} ${BUILD_DIR}/configure.ok
	@cmake --build ${BUILD_DIR} -j $(shell nproc) --target example -- --no-print-directory
	@${BUILD_DIR}/example
	
all: configure build test

configure: ${BUILD_DIR}/configure.ok
build: ${BUILD_DIR}/build.ok

${BUILD_DIR}/configure.ok: CMakeLists.txt
	cmake -B ${BUILD_DIR} -Wno-dev
	@touch ${BUILD_DIR}/configure.ok

${BUILD_DIR}/build.ok: ${BUILD_DIR}/configure.ok ${SRCS} ${HEADERS}
	cmake --build ${BUILD_DIR} -j $(shell nproc) -- --no-print-directory
	@touch ${BUILD_DIR}/build.ok

test: ${BUILD_DIR}/build.ok
	(cd ${BUILD_DIR}; ctest -vv)

clean:
	rm -rf ${BUILD_DIR} .vs/

indent:
	clang-format-10 -i ${SRCS} ${HEADERS}
