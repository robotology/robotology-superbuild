# Copyright (C) 2019 iCub Facility, Istituto Italiano di Tecnologia
# Authors: Diego Ferigo <diego.ferigo@iit.it>
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)

ycm_ep_helper(BlockFactory TYPE GIT
              STYLE GITHUB
              REPOSITORY robotology/blockfactory.git
              TAG master
              COMPONENT dynamics
              FOLDER robotology
              CMAKE_ARGS -DUSES_MATLAB:BOOL=${ROBOTOLOGY_USES_MATLAB}
                         -DENABLE_WARNINGS:BOOL=OFF)
