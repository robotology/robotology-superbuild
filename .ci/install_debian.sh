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
# bullseye is not supported by OpenRobotics' repo, but it has already 
# the right version of Gazebo in its repo, so we just skip everything
if [[ ("sid" != "$dist_version" && "bullseye" != "$dist_version" && "bookworm" != "$dist_version" && "trixie" != "$dist_version" && "jammy" != "$dist_version") ]]; then
    mkdir -p /etc/apt/sources.list.d
    echo deb http://packages.osrfoundation.org/gazebo/$lsb_dist\-stable $dist_version main > /etc/apt/sources.list.d/gazebo-stable.list
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys D2486D2DD83DB69272AFE98867170598AF249743
    apt-get update
    apt-get install -y libgazebo11-dev
# See https://github.com/robotology/robotology-superbuild/issues/944
elif [[ ("bookworm" != "$dist_version") ]]; then
    apt-get install -y libgazebo-dev
fi

# Workaround for https://github.com/robotology/robotology-superbuild/pull/998#issuecomment-1015415833
if [[ ("jammy" == "$dist_version") ]]; then
    apt-get install -y libsdformat9-dev
fi
