#!/bin/sh
set -e

apt-get update

# noninteractive tzdata ( https://stackoverflow.com/questions/44331836/apt-get-install-tzdata-noninteractive )
export DEBIAN_FRONTEND=noninteractive

# CI specific packages
apt-get install -y clang valgrind ccache ninja-build

# Core dependencies
apt-get install -y build-essential cmake cmake-curses-gui coinor-libipopt-dev freeglut3-dev git libace-dev libboost-filesystem-dev libboost-system-dev libboost-thread-dev libedit-dev libeigen3-dev libgsl0-dev libjpeg-dev liblua5.1-dev libode-dev libopencv-dev libsdl1.2-dev libtinyxml-dev libv4l-dev libxml2-dev lua5.1 qml-module-qt-labs-folderlistmodel qml-module-qt-labs-settings qml-module-qtmultimedia qml-module-qtquick-controls qml-module-qtquick-dialogs qml-module-qtquick-window2 qml-module-qtquick2 qtbase5-dev qtdeclarative5-dev qtmultimedia5-dev swig

# Python
apt-get install -y python3-dev python3-numpy

# Octave
apt-get install -y liboctave-dev

# Gazebo (use distro packages to support both Ubuntu and Debian)
apt-get install -y libgazebo*-dev
