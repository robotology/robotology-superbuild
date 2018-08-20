#!/bin/sh
set -e

apt-get update
apt-get install -y build-essential cmake coinor-libipopt-dev libboost-system-dev libboost-filesystem-dev libboost-thread-dev libeigen3-dev libtinyxml-dev libace-dev libgsl0-dev libopencv-dev libode-dev liblua5.1-dev lua5.1 git swig qtbase5-dev qtdeclarative5-dev qtmultimedia5-dev libqt5opengl5-dev libqcustomplot-dev
