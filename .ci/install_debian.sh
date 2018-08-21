#!/bin/sh
set -e

apt-get update

# noninteractive tzdata ( https://stackoverflow.com/questions/44331836/apt-get-install-tzdata-noninteractive )
export DEBIAN_FRONTEND=noninteractive

# CI specific packages
apt-get install -y clang valgrind

# Core dependencies
apt-get install -y build-essential cmake clang coinor-libipopt-dev libboost-system-dev libboost-filesystem-dev libboost-thread-dev libeigen3-dev libtinyxml-dev libace-dev libgsl0-dev libopencv-dev libode-dev liblua5.1-dev lua5.1 git swig qtbase5-dev qtdeclarative5-dev qtmultimedia5-dev libqt5opengl5-dev libqcustomplot-dev

# IHMC dependencies
apt-get install -y libasio-dev

# Python
apt-get install -y python-dev

# Octave
apt-get install -y liboctave-dev




