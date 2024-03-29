# Copyright (C) 2020  iCub Facility, Istituto Italiano di Tecnologia
# Authors: Giulio Romualdi <giulio.romualdi@iit.it>
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT
include(YCMEPHelper)

ycm_ep_helper(matioCpp TYPE GIT
              STYLE GITHUB
              REPOSITORY ami-iit/matio-cpp.git
              TAG master
              COMPONENT dynamics
              FOLDER src
              CMAKE_ARGS -DBUILD_TESTING:BOOL=OFF)

set(matioCpp_CONDA_PKG_NAME libmatio-cpp)
set(matioCpp_CONDA_PKG_CONDA_FORGE_OVERRIDE ON)
