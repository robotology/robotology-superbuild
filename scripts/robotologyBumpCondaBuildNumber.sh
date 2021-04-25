#!/bin/bash

# Script to automatically update the CONDA_BUILD_NUMBER parameter in
# the conda/cmake/CondaGenerationOptions.cmake file
# after a successful build and upload of Conda binaries

# To run it locally, make sure that you have awk installed, and execute it
# from the root of the robotology-superbuild:
# cd robotology-superbuild
# ./scripts/robotologyBumpCondaBuildNumber.sh 

# Inspired from https://superuser.com/questions/198143/increment-one-value-in-a-text-line-using-script
cp ./conda/cmake/CondaGenerationOptions.cmake /tmp/CondaGenerationOptions.cmake
awk '{if ($1 == "set(CONDA_BUILD_NUMBER") printf("%s %d)\n", $1, $2 + 1); else print $0;}' /tmp/CondaGenerationOptions.cmake > ./conda/cmake/CondaGenerationOptions.cmake