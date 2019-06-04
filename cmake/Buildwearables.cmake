# Copyright (C) 2018  iCub Facility, Istituto Italiano di Tecnologia
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(YARP QUIET)

set(WEARABLES_DEPENDS "")
list(APPEND WEARABLES_DEPENDS YARP)

if(WIN32)
    find_or_build_package(ICUB QUIET)
    find_or_build_package(icub-firmware-shared QUIET)
    find_or_build_package(forcetorque-yarp-devices QUIET)

    list(APPEND WEARABLES_DEPENDS ICUB)
    list(APPEND WEARABLES_DEPENDS icub-firmware-shared)
    list(APPEND WEARABLES_DEPENDS forcetorque-yarp-devices)
endif()

ycm_ep_helper(wearables TYPE GIT
              STYLE GITHUB
              REPOSITORY robotology/wearables.git
              TAG master
              COMPONENT human_dynamics
              FOLDER robotology
              DEPENDS ${WEARABLES_DEPENDS})
