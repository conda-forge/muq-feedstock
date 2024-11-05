#!/bin/bash

PYTHON_INCLUDE_DIR=$($PYTHON -c 'import sysconfig, sys; sys.stdout.write(sysconfig.get_paths()["include"])')
PYTHON_LIBRARY=$($PYTHON -c 'from sysconfig import get_config_var; import os, sys; sys.stdout.write(os.path.join(get_config_var("LIBDIR"),get_config_var("LDLIBRARY")))')

mkdir -p build
cd build

cmake \
    -DMUQ_USE_GTEST=OFF \
    -DMUQ_ENABLEGROUP_DEFAULT=ON \
    -DMUQ_USE_PYTHON=ON \
    -DCMAKE_INSTALL_PREFIX=$PREFIX \
    -DPYTHON_INSTALL_PREFIX=$SP_DIR \
    -DBoost_DIR=$PREFIX \
    -DEigen3_DIR=$PREFIX/include \
    -DHDF5_DIR=$PREFIX \
    -DNANOFLANN_DIR=$PREFIX \
    -DSUNDIALS_DIR=$PREFIX \
    -DNLopt_DIR=$PREFIX \
    -Dnanoflann_DIR=$PREFIX \
    -Dstanmath_SRC_DIR=$SRC_DIR/external/math-2.18.0 \
    -DPYTHON_INCLUDE_DIR=$PYTHON_INCLUDE_DIR \
    -DPYTHON_LIBRARY=$PYTHON_LIBRARY \
    -DPYTHON_EXECUTABLE=$PYTHON \
    -DCMAKE_INCLUDE_PATH=$PREFIX/include \
    $SRC_DIR

make -j$CPU_COUNT
make install
