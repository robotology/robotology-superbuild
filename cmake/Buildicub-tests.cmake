# Copyright (C) 2018  iCub Facility, Istituto Italiano di Tecnologia
# Authors: Diego Ferigo <diego.ferigo@iit.it>
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(RobotTestingFramework QUIET)
find_or_build_package(YARP QUIET)
find_or_build_package(ICUB QUIET)

ycm_ep_helper(icub-tests TYPE GIT
              STYLE GITHUB
              REPOSITORY robotology/icub-tests.git
              TAG master
              COMPONENT iCub
              FOLDER robotology
              DEPENDS RobotTestingFramework
                      YARP
                      ICUB)
