# Copyright (C) 2019 iCub Facility, Istituto Italiano di Tecnologia
# Authors: Diego Ferigo <diego.ferigo@iit.it>
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)

if(ROBOTOLOGY_USES_MATLAB AND NOT ROBOTOLOGY_NOT_USE_SIMULINK)
  set(BLOCKFACTORY_USES_SIMULINK ON)
else()
  set(BLOCKFACTORY_USES_SIMULINK OFF)
endif()

find_or_build_package(sharedlibpp QUIET)

ycm_ep_helper(BlockFactory TYPE GIT
              STYLE GITHUB
              REPOSITORY robotology/blockfactory.git
              TAG master
              COMPONENT dynamics
              FOLDER src
              DEPENDS sharedlibpp
              CMAKE_ARGS -DUSES_MATLAB:BOOL=${BLOCKFACTORY_USES_SIMULINK}
                         -DBLOCKFACTORY_USES_SYSTEM_SHAREDLIBPP:BOOL=ON
                         -DENABLE_WARNINGS:BOOL=OFF)
