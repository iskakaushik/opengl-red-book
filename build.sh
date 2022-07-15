#!/bin/bash
set -Exe

rm -rf build
cmake -DCMAKE_TOOLCHAIN_FILE=$PWD/vcpkg/scripts/buildsystems/vcpkg.cmake -S. -Bbuild
cmake --build build


