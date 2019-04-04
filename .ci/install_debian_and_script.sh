#!/bin/sh
set -e

DIR=$(dirname "$(readlink -f "$0")")

# Enable ccache
export PATH=/usr/lib/ccache:$PATH

sh $DIR/install_debian.sh
sh $DIR/script.sh
