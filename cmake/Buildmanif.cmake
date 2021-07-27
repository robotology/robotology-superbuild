# Copyright (C) 2020  iCub Facility, Istituto Italiano di Tecnologia
# Authors: Giulio Romualdi <gulio.romualdi@iit.it>
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)

# Workaround for https://github.com/robotology/robotology-superbuild/pull/838#issuecomment-887367047
if(ROBOTOLOGY_USES_PYTHON AND NOT WIN32)
  set(BUILD_PYTHON_BINDINGS ON)
else()
  set(BUILD_PYTHON_BINDINGS OFF)
endif()

ycm_ep_helper(manif TYPE GIT
              STYLE GITHUB
              REPOSITORY artivis/manif.git
              TAG master
              COMPONENT external
              FOLDER src
              CMAKE_ARGS -DBUILD_TESTING:BOOL=OFF -DBUILD_EXAMPLES:BOOL=OFF -DBUILD_PYTHON_BINDINGS:BOOL=${BUILD_PYTHON_BINDINGS})

set(manif_CONDA_PKG_NAME manif)
set(manif_CONDA_PKG_CONDA_FORGE_OVERRIDE ON)
