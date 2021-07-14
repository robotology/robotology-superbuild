#!/bin/bash
#
# Install dependencies of robotology-superbuild 
# using apt on Ubuntu or Debian 

set -euo pipefail

# Get location of the script
scriptDirectory=$(dirname $(readlink --canonicalize --no-newline $BASH_SOURCE))

xargs -a ${scriptDirectory}/../apt.txt apt-get install

echo 'install_apt_dependencies: success'
