#!/bin/bash
#
# Install dependencies of robotology-superbuild
# using apt on Ubuntu or Debian

set -e

# Get location of the script
SCRIPT_DIR=$(cd "$(dirname "$BASH_SOURCE")"; cd -P "$(dirname "$(readlink "$BASH_SOURCE" || echo .)")"; pwd)

apt-get update
xargs -r -a "${SCRIPT_DIR}/../apt.txt" apt-get install -y

# Gazebo packages are distributed through the OSRF repository. Select a
# release supported both by the Ubuntu version and by gz-sim-yarp-plugins:
# gz-sim8 on Jammy and the unversioned gz-sim >= 10 package on Noble.
source /etc/os-release

if [[ "${ID:-}" != "ubuntu" ]]; then
    echo "Skipping Gazebo installation: automatic installation is supported only on Ubuntu."
    exit 0
fi

case "${VERSION_CODENAME:-}" in
    jammy)
        GAZEBO_PACKAGE="gz-harmonic" # gz-sim8
        ;;
    noble)
        GAZEBO_PACKAGE="gz-jetty" # gz-sim10
        ;;
    *)
        echo "Skipping Gazebo installation: unsupported Ubuntu release '${VERSION_CODENAME:-unknown}'."
        exit 0
        ;;
esac

curl -fsSL https://packages.osrfoundation.org/gazebo.gpg \
    --output /usr/share/keyrings/pkgs-osrf-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/pkgs-osrf-archive-keyring.gpg] https://packages.osrfoundation.org/gazebo/ubuntu-stable ${VERSION_CODENAME} main" \
    > /etc/apt/sources.list.d/gazebo-stable.list

apt-get update
apt-get install -y "${GAZEBO_PACKAGE}"
