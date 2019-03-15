# Copyright (C) 2017  iCub Facility, Istituto Italiano di Tecnologia
# Authors: Silvio Traversaro <silvio.traversaro@iit.it>
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(YARP QUIET)
find_or_build_package(ICUBcontrib QUIET)

# This custom code is present to make sure that:
# * On iCub Head images, the behavior is to install only those specific robot files
# * On other systems (i.e. developers laptop) all the robots configuration files are installed
set(robots-configuration_CMAKE_ARGS "")
if("$ENV{YARP_ROBOT_NAME}" STREQUAL "")
    list(APPEND robots-configuration_CMAKE_ARGS "-DINSTALL_ALL_ROBOTS:BOOL=ON")
endif()


ycm_ep_helper(robots-configuration TYPE GIT
                                   STYLE GITHUB
                                   REPOSITORY robotology/robots-configuration.git
                                   DEPENDS YARP
                                           ICUBcontrib
                                   COMPONENT iCub
                                   FOLDER robotology
                                   CMAKE_ARGS ${robots-configuration_CMAKE_ARGS})
