#!/bin/bash
#
# Install dependencies of robotology-superbuild 
# using apt on Ubuntu or Debian 

# Get location of the script
SCRIPT_DIR=$(cd "$(dirname "$BASH_SOURCE")"; cd -P "$(dirname "$(readlink "$BASH_SOURCE" || echo .)")"; pwd)

xargs -a ${SCRIPT_DIR}/../apt.txt apt-get install -y

# Handle libdc1394 package (see https://github.com/robotology/robotology-superbuild/issues/854)
# On Ubuntu 20.04 install libdc1394-22-dev, otherwise libdc1394-dev
# Remove once Ubuntu 20.04 compatibility is dropped
ROBSUP_DISTRO_NAME=$(lsb_release -i | cut -d: -f2 | sed s/'^\t'//)
ROBSUP_DISTRO_VERSION=$(lsb_release -r | cut -d: -f2 | sed s/'^\t'//)
ROBSUP_DISTRO_CODENAME=$(lsb_release -c | cut -d: -f2 | sed s/'^\t'//)

echo "ROBSUP_DISTRO_NAME: ${ROBSUP_DISTRO_NAME}"
echo "ROBSUP_DISTRO_VERSION: ${ROBSUP_DISTRO_VERSION}"
echo "ROBSUP_DISTRO_CODENAME: ${ROBSUP_DISTRO_CODENAME}"
if [[ ("$ROBSUP_DISTRO_NAME" == "Ubuntu" && "$ROBSUP_DISTRO_VERSION" == "20.04") ]]
then
  apt-get install -y libdc1394-22-dev
else
  apt-get install -y libdc1394-dev
fi
