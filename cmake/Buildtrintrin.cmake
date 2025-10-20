# Copyright (C) 2018  iCub Facility, Istituto Italiano di Tecnologia
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(YARP QUIET)

if(ROBOTOLOGY_USES_PYTHON) 
  # If we are not generating a conda recipe, the bindings need to go in the ROBOTOLOGY_SUPERBUILD_PYTHON_INSTALL_DIR
  list(APPEND TRINTRIN_OPTIONAL_CMAKE_ARGS "-DTRINTRIN_PYTHON_INSTALL_DIR=${ROBOTOLOGY_SUPERBUILD_PYTHON_INSTALL_DIR}")
endif()


ycm_ep_helper(trintrin TYPE GIT
              STYLE GITHUB
              REPOSITORY ami-iit/trintrin.git
              TAG main
              COMPONENT dynamics
              FOLDER src
              CMAKE_ARGS-DTRINTRIN_COMPILE_PYTHON_BINDINGS:BOOL=${ROBOTOLOGY_USES_PYTHON} ${TRINTRIN_OPTIONAL_CMAKE_ARGS}
              DEPENDS YARP)

set(TRINTRIN_CONDA_PKG_NAME trintrin)
set(TRINTRIN_CONDA_PKG_CONDA_FORGE_OVERRIDE ON)
