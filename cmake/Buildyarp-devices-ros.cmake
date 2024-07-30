# Copyright (C) Fondazione Istituto Italiano di Tecnologia
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(YARP QUIET)

if(ROBOTOLOGY_SUPERBUILD_BUILD_SEPARATE_YARP_ROS)
  find_or_build_package(yarp-ros QUIET)
  list(APPEND YDR_OPTIONAL_DEPS yarp-ros)
endif()

ycm_ep_helper(yarp-devices-ros TYPE GIT
                                    STYLE GITHUB
                                    REPOSITORY robotology/yarp-devices-ros.git
                                    TAG master
                                    COMPONENT core
                                    FOLDER src
                                    DEPENDS YARP ${YDR_OPTIONAL_DEPS})
