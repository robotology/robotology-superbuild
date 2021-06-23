# Copyright (C) 2020 Fondazione Istituto Italiano di Tecnologia
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)

find_or_build_package(YARP QUIET)
find_or_build_package(ICUB QUIET)
find_or_build_package(ICUBcontrib QUIET)

ycm_ep_helper(icub-basic-demos TYPE GIT
                               STYLE GITHUB
                               REPOSITORY robotology/icub-basic-demos.git
                               TAG master
                               COMPONENT ICUB_BASIC_DEMOS
                               FOLDER src
                               DEPENDS YARP
                                       ICUB
                                       ICUBcontrib)

set(icub-basic-demos_CONDA_DEPENDENCIES libopencv qt)
