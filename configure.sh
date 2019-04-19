#!/usr/bin/env bash

set -e

# Warn user if build folder already exists
if [ -d "build" ]; then
      echo "$0 error: build directory already exists"
      exit 1
fi

# Determine the path to the target virtual environment dir
venvDir=$1
if [ -z $venvDir ]; then
      # path not given, so request it as input from the user
      read -e -p "Virtual environment directory: " venvDir
      venvDir="${venvDir/#\~/$HOME}"
fi
venvDir=${venvDir%/}  # remove trailing slash
if [[ ! -d $venvDir ]]; then
      echo "$0 error: invalid virtual environment directory: $venvDir"
      exit 1
fi

# Does the user want to build the OpenCV examples too?
read -p "Build OpenCV examples? [y/N] " buildExamples
case $buildExamples in
  [Yy]* ) buildExamples=1 ;;
  * ) buildExamples=0 ;;
esac

# Specify OpenCV version
cvVersion="3.4"

# Specify Python version
pyVersion="3.6"

# Clean build directories
rm -rf opencv/build
rm -rf opencv_contrib/build

# Save current working directory
cwd=$(pwd)

# For Ubuntu 17.10
sudo add-apt-repository "deb http://security.ubuntu.com/ubuntu xenial-security main"

# Update system
sudo apt -y update
sudo apt -y upgrade
sudo apt -y remove x264 libx264-dev
 
# Install dependencies
sudo apt -y install build-essential checkinstall cmake pkg-config yasm
sudo apt -y install git gfortran
sudo apt -y install libjpeg8-dev libjasper-dev libpng12-dev
sudo apt -y install libtiff5-dev
sudo apt -y install libtiff-dev
sudo apt -y install libavcodec-dev libavformat-dev libswscale-dev libdc1394-22-dev
sudo apt -y install libxine2-dev libv4l-dev

cd /usr/include/linux
sudo ln -s -f ../libv4l1-videodev.h videodev.h
cd $cwd
 
sudo apt -y install libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev
sudo apt -y install libgtk2.0-dev libtbb-dev qt5-default
sudo apt -y install libatlas-base-dev
sudo apt -y install libfaac-dev libmp3lame-dev libtheora-dev
sudo apt -y install libvorbis-dev libxvidcore-dev
sudo apt -y install libopencore-amrnb-dev libopencore-amrwb-dev
sudo apt -y install libavresample-dev
sudo apt -y install x264 v4l-utils
 
# Optional dependencies
sudo apt -y install libprotobuf-dev protobuf-compiler
sudo apt -y install libgoogle-glog-dev libgflags-dev
sudo apt -y install libgphoto2-dev libeigen3-dev libhdf5-dev doxygen
sudo apt -y install python3-dev python3-pip python3-venv
sudo apt -y install python3-testresources

# Now install python libraries within this virtual environment
source $venvDir/bin/activate
pip install numpy

# Create build folder
cd $cwd
mkdir build
cd build

# Set flags to build/ install examples
_BUILD_EXAMPLES="OFF"
_INSTALL_C_EXAMPLES="OFF"
_INSTALL_PYTHON_EXAMPLES="OFF"
if [ buildExamples ]; then
      _BUILD_EXAMPLES="ON"
      _INSTALL_C_EXAMPLES="ON"
      _INSTALL_PYTHON_EXAMPLES="ON"
fi

# Finally execute cmake
cmake -D CMAKE_BUILD_TYPE=RELEASE \
      -D OPENCV_EXTRA_MODULES_PATH=../opencv_contrib/modules \
      -D CMAKE_INSTALL_PREFIX=$venvDir/local/ \
      -D OPENCV_PYTHON_INSTALL_PATH=$venvDir/lib/python$pyVersion/site-packages \
      -D BUILD_EXAMPLES=$_BUILD_EXAMPLES \
      -D INSTALL_C_EXAMPLES=$_INSTALL_C_EXAMPLES \
      -D INSTALL_PYTHON_EXAMPLES=$_INSTALL_PYTHON_EXAMPLES \
      -D WITH_TBB=ON \
      -D WITH_V4L=ON \
      -D WITH_QT=ON \
      -D WITH_OPENGL=ON \
      -D OPENCV_ENABLE_NONFREE=ON ../opencv

# Other potentially useful options:
# -D OPENCV_PYTHON3_INSTALL_PATH
# -D PYTHON_PACKAGES_PATH
# -D PYTHON_EXECUTABLE
# -D PYTHON_INCLUDE
# -D PYTHON_LIBRARY
# -D PYTHON_NUMPY_INCLUDE_DIR

# make -j4
# make install