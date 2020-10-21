# Copyright (C) 2020  iCub Facility, Istituto Italiano di Tecnologia
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(YARP QUIET)
find_or_build_package(YCM QUIET)

ycm_ep_helper(event-driven TYPE GIT
              STYLE GITHUB
              REPOSITORY robotology/event-driven.git
              DEPENDS	YARP
              	      	YCM
              COMPONENT event-driven
              FOLDER robotology)
