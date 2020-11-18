# Copyright (C) 2019-2020 Fondazione Istituto Italiano di Tecnologia
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(YARP QUIET)

ycm_ep_helper(yarp-device-xsensmt TYPE GIT
              STYLE GITHUB
              REPOSITORY robotology/yarp-device-xsensmt.git
              TAG master
              COMPONENT iCub
              FOLDER robotology
              DEPENDS YARP)
