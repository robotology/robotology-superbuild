# Copyright (C) 2019  iCub Facility, Istituto Italiano di Tecnologia
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(YARP QUIET)

ycm_ep_helper(forcetorque-yarp-devices TYPE GIT
                                   STYLE GITHUB
                                   REPOSITORY robotology/forcetorque-yarp-devices.git
                                   TAG master
                                   COMPONENT iCub
                                   FOLDER robotology
                                   DEPENDS YARP
                                   CMAKE_CACHE_ARGS -DENABLE_ftshoe:BOOL=ON)

