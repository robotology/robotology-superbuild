# Copyright (C) 2020  iCub Facility, Istituto Italiano di Tecnologia
# Authors: Giulio Romualdi <gulio.romualdi@iit.it>
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)

ycm_ep_helper(manif TYPE GIT
              STYLE GITHUB
              REPOSITORY artivis/manif.git
              TAG master
              COMPONENT external
              FOLDER src
              CMAKE_ARGS -DBUILD_TESTING:BOOL=OFF -DBUILD_EXAMPLES:BOOL=OFF)

set(manif_CONDA_PKG_NAME manif)
set(manif_CONDA_PKG_CONDA_FORGE_OVERRIDE ON)
