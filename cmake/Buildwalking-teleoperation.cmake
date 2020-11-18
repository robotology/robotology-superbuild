# Copyright (C) 2018  iCub Facility, Istituto Italiano di Tecnologia
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(YARP QUIET)
find_or_build_package(ICUB QUIET)
find_or_build_package(iDynTree QUIET)

ycm_ep_helper(walking-teleoperation TYPE GIT
              STYLE GITHUB
              REPOSITORY robotology/walking-teleoperation.git
              TAG master
              COMPONENT teleoperation
              FOLDER robotology
              DEPENDS iDynTree
                      ICUB
                      YARP)
