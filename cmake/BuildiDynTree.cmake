# Copyright (C) Fondazione Istituto Italiano di Tecnologia
# Authors: Silvio Traversaro <silvio.traversaro@iit.it>
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(OsqpEigen QUIET)

set(iDynTree_DEPENDS "")
list(APPEND iDynTree_DEPENDS OsqpEigen)

# For what regards Python installation, the options changes depending
# on whether we are installing YARP from source, or generating a
# conda package on Windows as in that case the installation location
# will need to be outside of CMAKE_INSTALL_PREFIX
# See https://github.com/robotology/robotology-superbuild/issues/641
set(iDynTree_OPTIONAL_CMAKE_ARGS "")
if(ROBOTOLOGY_USES_PYTHON)
  list(APPEND iDynTree_OPTIONAL_CMAKE_ARGS "-DIDYNTREE_PYTHON_INSTALL_DIR=${ROBOTOLOGY_SUPERBUILD_PYTHON_INSTALL_DIR}")
endif()

# Hack for disabling IDYNTREE_USES_IRRLICHT on vcpkg,
# remove once irrlicht+sdl is available on vcpkg,
# and https://github.com/robotology/robotology-superbuild-dependencies-vcpkg
# is modified to includ it
find_package(glfw3 QUIET)

# See https://github.com/robotology/robotology-superbuild/pull/1598#issuecomment-1942172913
if(glfw3_FOUND OR GLFW3_FOUND)
  set(IDYNTREE_USES_IRRLICHT ON)
else()
  set(IDYNTREE_USES_IRRLICHT OFF)
endif()


ycm_ep_helper(iDynTree TYPE GIT
              STYLE GITHUB
              REPOSITORY robotology/idyntree.git
              TAG master
              COMPONENT dynamics
              FOLDER src
              CMAKE_ARGS -DIDYNTREE_USES_IPOPT:BOOL=ON
                         -DIDYNTREE_USES_OSQPEIGEN:BOOL=ON
                         -DIDYNTREE_USES_IRRLICHT:BOOL=${IDYNTREE_USES_IRRLICHT}
                         -DIDYNTREE_USES_ASSIMP:BOOL=ON
                         -DCMAKE_DISABLE_FIND_PACKAGE_YARP:BOOL=ON
                         -DIDYNTREE_USES_YARP:BOOL=OFF
                         -DCMAKE_DISABLE_FIND_PACKAGE_ICUB:BOOL=ON
                         -DIDYNTREE_USES_ICUB_MAIN:BOOL=OFF
                         -DIDYNTREE_USES_MATLAB:BOOL=${ROBOTOLOGY_USES_MATLAB}
                         -DIDYNTREE_USES_PYTHON:BOOL=${ROBOTOLOGY_USES_PYTHON}
                         -DIDYNTREE_USES_OCTAVE:BOOL=${ROBOTOLOGY_USES_OCTAVE}
                         -DIDYNTREE_COMPILES_YARP_TOOLS:BOOL=OFF
                         ${iDynTree_OPTIONAL_CMAKE_ARGS}
              DEPENDS ${iDynTree_DEPENDS})

set(iDynTree_CONDA_PKG_NAME idyntree)
set(iDynTree_CONDA_PKG_CONDA_FORGE_OVERRIDE ON)
