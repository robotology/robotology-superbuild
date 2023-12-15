# Copyright (C) 2023 iCub Tech, Istituto Italiano di Tecnologia
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(YARP QUIET)

set(ergocub-software_OPTIONAL_CMAKE_ARGS "")

ycm_ep_helper(ergocub-software
              TYPE GIT
              STYLE GITHUB
              REPOSITORY icub-tech-iit/ergocub-software.git
              TAG master
              DEPENDS YARP
              COMPONENT core
              FOLDER src
              CMAKE_ARGS ${ergocub-software_OPTIONAL_CMAKE_ARGS})
