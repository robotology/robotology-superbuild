# Copyright (C) 2018  iCub Facility, Istituto Italiano di Tecnologia
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(YARP QUIET)
find_or_build_package(iDynTree QUIET)
find_or_build_package(YARP_telemetry QUIET)

set(WEARABLES_CMAKE_ARGS "")
if(WIN32)
    list(APPEND WEARABLES_CMAKE_ARGS -DENABLE_XsensSuit:BOOL=${ROBOTOLOGY_USES_XSENS_MVN_SDK} )
endif()

ycm_ep_helper(wearables TYPE GIT
              STYLE GITHUB
              REPOSITORY robotology/wearables.git
              TAG master
              COMPONENT human_dynamics
              FOLDER src
              DEPENDS YARP
                      iDynTree
                      YARP_telemetry
              CMAKE_ARGS ${WEARABLES_CMAKE_ARGS})
