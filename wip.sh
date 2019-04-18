#!/bin/sh

set -e

# Specify OpenCV version
cvVersion="3.4"

# Clean build directories
rm -rf opencv/build
rm -rf opencv_contrib/build

# # Create directory for installation
# mkdir installation
# mkdir installation/OpenCV-"$cvVersion"

# Save current working directory
cwd=$(pwd)

# # For Ubuntu 17.10
# sudo add-apt-repository "deb http://security.ubuntu.com/ubuntu xenial-security main"

# sudo apt -y update
# sudo apt -y upgrade

# sudo apt -y remove x264 libx264-dev
 
# # Install dependencies
# sudo apt -y install build-essential checkinstall cmake pkg-config yasm
# sudo apt -y install git gfortran
# sudo apt -y install libjpeg8-dev libjasper-dev libpng12-dev
 
# sudo apt -y install libtiff5-dev
 
# sudo apt -y install libtiff-dev
 
# sudo apt -y install libavcodec-dev libavformat-dev libswscale-dev libdc1394-22-dev
# sudo apt -y install libxine2-dev libv4l-dev
# cd /usr/include/linux
# sudo ln -s -f ../libv4l1-videodev.h videodev.h
# cd $cwd
 
# sudo apt -y install libgstreamer1.0-dev libgstreamer-plugins-base1.0-dev
# sudo apt -y install libgtk2.0-dev libtbb-dev qt5-default
# sudo apt -y install libatlas-base-dev
# sudo apt -y install libfaac-dev libmp3lame-dev libtheora-dev
# sudo apt -y install libvorbis-dev libxvidcore-dev
# sudo apt -y install libopencore-amrnb-dev libopencore-amrwb-dev
# sudo apt -y install libavresample-dev
# sudo apt -y install x264 v4l-utils
 
# # Optional dependencies
# sudo apt -y install libprotobuf-dev protobuf-compiler
# sudo apt -y install libgoogle-glog-dev libgflags-dev
# sudo apt -y install libgphoto2-dev libeigen3-dev libhdf5-dev doxygen

# sudo apt -y install python3-dev python3-pip python3-venv
# # sudo -H pip3 install -U pip numpy
# sudo apt -y install python3-testresources

# cd $cwd
# ############ For Python 3 ############
# # create virtual environment
# python3 -m venv OpenCV-"$cvVersion"-py3
# source "$cwd"/OpenCV-"$cvVersion"-py3/bin/activate

# # now install python libraries within this virtual environment
# pip install numpy
 
# # quit virtual environment
# # deactivate
# ######################################

# git clone https://github.com/opencv/opencv.git
# cd opencv
# git checkout "$cvVersion"
# cd ..
 
# git clone https://github.com/opencv/opencv_contrib.git
# cd opencv_contrib
# git checkout "$cvVersion"
# cd ..

cd opencv
mkdir build
cd build

cmake -D CMAKE_BUILD_TYPE=RELEASE \
      -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
      -D CMAKE_INSTALL_PREFIX=$cwd/OpenCV-$cvVersion-py3/local/ \
      -D OPENCV_PYTHON_INSTALL_PATH=$cwd/OpenCV-$cvVersion-py3/lib/python3.6/site-packages \
      # -D OPENCV_PYTHON3_INSTALL_PATH=$cwd/OpenCV-$cvVersion-py3/lib/python3.6/site-packages \
      -D INSTALL_C_EXAMPLES=ON \
      -D INSTALL_PYTHON_EXAMPLES=ON \
      -D WITH_TBB=ON \
      -D WITH_V4L=ON \
      -D WITH_QT=ON \
      -D WITH_OPENGL=ON \
      -D OPENCV_ENABLE_NONFREE=ON \
      -D BUILD_EXAMPLES=ON ..



      # -D PYTHON_EXECUTABLE=~/.virtualenvs/cv/bin/python \


# cmake -D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib-3.3.0/modules \
#       -D PYTHON_EXECUTABLE=~/.virtualenvs/cv/bin/python \
#       ..

# cmake -D PYTHON_EXECUTABLE=$VIRTUAL_ENV/bin/python \
#       -D PYTHON_PACKAGES_PATH=$VIRTUAL_ENV/lib/python2.7/site-packages \
#       ..

# PYTHON_EXECUTABLE=/usr/bin/python2.7/
# PYTHON_INCLUDE=/usr/include/python2.7/
# PYTHON_LIBRARY=/usr/lib/libpython2.7.a    //or .so for shared library
# PYTHON_PACKAGES_PATH=/usr/local/lib/python2.7/site-packages/
# # PYTHON_NUMPY_INCLUDE_DIR=/usr/local/lib/python2.7/dist-packages/numpy/core/include







# make -j4
# make install