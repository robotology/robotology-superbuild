# Copyright (C) 2020 iCub Facility, Istituto Italiano di Tecnologia
# Authors: Giulio Romualdi <gulio.romualdi@iit.it>
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)

ycm_ep_helper(qhull TYPE GIT
              STYLE GITHUB
              REPOSITORY qhull/qhull.git
              TAG master
              COMPONENT external
              CMAKE_ARGS -DCMAKE_POSITION_INDEPENDENT_CODE:BOOL=ON)
