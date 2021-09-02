#!/bin/sh
set -e

apt-get update

# noninteractive tzdata ( https://stackoverflow.com/questions/44331836/apt-get-install-tzdata-noninteractive )
export DEBIAN_FRONTEND=noninteractive

# CI specific packages
apt-get install -y clang valgrind ccache ninja-build

# Dependencies
# Get location of the script
SCRIPT_DIR=$(cd "$(dirname "$BASH_SOURCE")"; cd -P "$(dirname "$(readlink "$BASH_SOURCE" || echo .)")"; pwd)

source ${SCRIPT_DIR}/../scripts/install_apt_dependencies.sh

# Python
apt-get install -y python3-dev python3-numpy python3-pybind11 pybind11-dev

# Octave
apt-get install -y liboctave-dev

# Gazebo
lsb_dist="$(. /etc/os-release && echo "$ID")"
dist_version="$(. /etc/os-release && echo "$VERSION_CODENAME")"
# bullseye is not supported by OpenRobotics' repo, but it has already 
# the right version of Gazebo in its repo, so we just skip everything
if [ "sid" != "$dist_version" ]; then
    mkdir -p /etc/apt/sources.list.d
    echo deb http://packages.osrfoundation.org/gazebo/$lsb_dist\-stable $dist_version main > /etc/apt/sources.list.d/gazebo-stable.list
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys D2486D2DD83DB69272AFE98867170598AF249743
fi

apt-get update
apt-get install -y libgazebo11-dev
