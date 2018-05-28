#!/bin/sh

sudo apt-get update
# Install the required libraries that are available as debs.
sudo apt-get install -y \
    cmake \
    g++ \
    git \
    google-mock \
    libboost-all-dev \
    libcairo2-dev \
    libeigen3-dev \
    libgflags-dev \
    libgoogle-glog-dev \
    liblua5.2-dev \
    libsuitesparse-dev \
    ninja-build \
    python-sphinx

#build and install the protobuf

cd ${HOME}/cartographer_slam/src/protobuf
mkdir build
cd build
cmake -G Ninja \
  -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
  -DCMAKE_BUILD_TYPE=Release \
  -Dprotobuf_BUILD_TESTS=OFF \
  ../cmake
ninja
sudo ninja install

#build and install ceres
cd ${HOME}/cartographer_slam/src/ceres-solver
mkdir build
cd build
cmake .. -G Ninja -DCXX11=ON
ninja
CTEST_OUTPUT_ON_FAILURE=1 ninja test
sudo ninja install

#build and install cartographer
cd ${HOME}/cartographer_slam/src/cartographer
mkdir build
cd build
cmake .. -G Ninja
ninja
CTEST_OUTPUT_ON_FAILURE=1 ninja test
sudo ninja install

#catkin_make_isolated
cd cd ${HOME}/cartographer_slam/
catkin_make_isolated
