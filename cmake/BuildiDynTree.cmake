# Copyright (C) 2017  iCub Facility, Istituto Italiano di Tecnologia
# Authors: Silvio Traversaro <silvio.traversaro@iit.it>
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(YARP QUIET)
find_or_build_package(ICUB QUIET)
find_or_build_package(OsqpEigen QUIET)

set(iDynTree_DEPENDS "")
list(APPEND iDynTree_DEPENDS YARP)
list(APPEND iDynTree_DEPENDS ICUB)
list(APPEND iDynTree_DEPENDS OsqpEigen)

# For what regards Python installation, the options changes depending
# on whater we are installing YARP from source, or we are generating a
# conda package on Windows as in that case the installation location
# will need to be outside of CMAKE_INSTALL_PREFIX
# See https://github.com/robotology/robotology-superbuild/issues/641
set(iDynTree_OPTIONAL_CMAKE_ARGS "")
if(ROBOTOLOGY_USES_PYTHON AND ROBOTOLOGY_GENERATE_CONDA_RECIPES AND WIN32)
  list(APPEND iDynTree_OPTIONAL_CMAKE_ARGS "-DIDYNTREE_DETECT_ACTIVE_PYTHON_SITEPACKAGES:BOOL=ON")
endif()


ycm_ep_helper(iDynTree TYPE GIT
              STYLE GITHUB
              REPOSITORY robotology/idyntree.git
              TAG master
              COMPONENT dynamics
              FOLDER src
              CMAKE_ARGS -DIDYNTREE_USES_IPOPT:BOOL=ON
                         -DIDYNTREE_USES_YARP:BOOL=ON
                         -DIDYNTREE_USES_ICUB_MAIN:BOOL=ON
                         -DIDYNTREE_USES_OSQPEIGEN:BOOL=ON
                         -DIDYNTREE_USES_IRRLICHT:BOOL=ON
                         -DIDYNTREE_USES_MATLAB:BOOL=${ROBOTOLOGY_USES_MATLAB}
                         -DIDYNTREE_USES_PYTHON:BOOL=${ROBOTOLOGY_USES_PYTHON}
                         -DIDYNTREE_USES_OCTAVE:BOOL=${ROBOTOLOGY_USES_OCTAVE}
                         ${iDynTree_OPTIONAL_CMAKE_ARGS}
              DEPENDS ${iDynTree_DEPENDS})

set(iDynTree_CONDA_DEPENDENCIES libxml2 ipopt eigen qt irrlicht)

if(ROBOTOLOGY_USES_PYTHON)
  list(APPEND iDynTree_CONDA_DEPENDENCIES swig)
  list(APPEND iDynTree_CONDA_DEPENDENCIES python)
  list(APPEND iDynTree_CONDA_DEPENDENCIES numpy)
endif()
