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
source ${SCRIPT_DIR}/../scripts/install_apt_python_dependencies.sh

# Octave
apt-get install -y liboctave-dev

# Gazebo
lsb_dist="$(. /etc/os-release && echo "$ID")"
dist_version="$(lsb_release -c | cut -d: -f2 | sed s/'^\t'//)"
echo "lsb_dist: ${lsb_dist}"
echo "dist_version: ${dist_version}"
# Just a limited amount of distros are supported by OSRF repos, for all the other we use the 
# gazebo packages in regular repos
if [[ ("bionic" == "$dist_version" || "focal" == "$dist_version" || "buster" == "$dist_version") ]]; then
    mkdir -p /etc/apt/sources.list.d
    echo deb http://packages.osrfoundation.org/gazebo/$lsb_dist\-stable $dist_version main > /etc/apt/sources.list.d/gazebo-stable.list
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys D2486D2DD83DB69272AFE98867170598AF249743
    apt-get update
    apt-get install -y libgazebo11-dev
else
    apt-get install -y libgazebo-dev
fi

# PCL and VTK
apt-get install -y libpcl-dev


