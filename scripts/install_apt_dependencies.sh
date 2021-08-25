#!/bin/bash
#
# Install dependencies of robotology-superbuild 
# using apt on Ubuntu or Debian 

# Get location of the script
SCRIPT_DIR=$(cd "$(dirname "$BASH_SOURCE")"; cd -P "$(dirname "$(readlink "$BASH_SOURCE" || echo .)")"; pwd)

xargs -a ${SCRIPT_DIR}/../apt.txt apt-get install -y

# Handle libdc1394 package (see https://github.com/robotology/robotology-superbuild/issues/854)
# On Ubuntu 18.04 or Debian Buster install libdc1394-22-dev, otherwise libdc1394-dev
# Remove once Ubuntu 18.04 and Debian Buster compatibility is dropped
ROBSUP_DISTRO_NAME=$(lsb_release -i | cut -d: -f2 | sed s/'^\t'//)
ROBSUP_DISTRO_VERSION=$(lsb_release -r | cut -d: -f2 | sed s/'^\t'//)
ROBSUP_DISTRO_CODENAME=$(lsb_release -c | cut -d: -f2 | sed s/'^\t'//)

if [[ ("$ROBSUP_DISTRO_NAME" == "Ubuntu" && "$ROBSUP_DISTRO_VERSION" == "22.04") || ("$ROBSUP_DISTRO_NAME" == "Debian" && "$ROBSUP_DISTRO_CODENAME" == "bullseye") || ("$ROBSUP_DISTRO_NAME" == "Debian" && "$ROBSUP_DISTRO_CODENAME" == "bookworm") ]]
then
  apt-get install -y libdc1394-dev
else
  apt-get install -y libdc1394-22-dev
fi

# Handle nlohmann-json3-dev dependency
# Remove once Ubuntu 18.04 compatibility is dropped
if [[ ("$ROBSUP_DISTRO_NAME" == "Ubuntu" && "$ROBSUP_DISTRO_VERSION" == "18.04") ]]
then
  :
else
  apt-get install -y nlohmann-json3-dev
fi
