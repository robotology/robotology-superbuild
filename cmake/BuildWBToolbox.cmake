# Copyright (C) 2017  iCub Facility, Istituto Italiano di Tecnologia
# Authors: Silvio Traversaro <silvio.traversaro@iit.it>
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(YARP QUIET)
find_or_build_package(ICUB QUIET)
find_or_build_package(iDynTree QUIET)
find_or_build_package(wholeBodyInterface QUIET)
find_or_build_package(yarpWholeBodyInterface QUIET)

ycm_ep_helper(WBToolbox TYPE GIT
              STYLE GITHUB
              REPOSITORY robotology/WB-Toolbox.git
              TAG master
              COMPONENT robotology
              DEPENDS YARP
                      ICUB
                      iDynTree
                      wholeBodyInterface
                      yarpWholeBodyInterface)
