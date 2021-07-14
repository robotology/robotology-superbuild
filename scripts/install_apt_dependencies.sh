#!/bin/bash
#
# Install dependencies of robotology-superbuild 
# using apt on Ubuntu or Debian 

set -euo pipefail

# Get location of the script
scriptDirectory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )" 

xargs -a ${scriptDirectory}/../apt.txt apt-get install

echo 'install_apt_dependencies: success'
