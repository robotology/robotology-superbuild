# Copyright (C) Fondazione Istituto Italiano di Tecnologia
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(YCM QUIET)
find_or_build_package(YARP QUIET)

ycm_ep_helper(yarp-devices-ros2 TYPE GIT
                                     STYLE GITHUB
                                     REPOSITORY robotology/yarp-devices-ros2.git
                                     TAG master
                                     COMPONENT core
                                     FOLDER src
                                     DEPENDS YCM YARP)
