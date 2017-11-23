# Copyright (C) 2017  iCub Facility, Istituto Italiano di Tecnologia
# Authors: Silvio Traversaro <silvio.traversaro@iit.it>
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(YARP QUIET)
find_or_build_package(ICUB QUIET)
find_or_build_package(iDynTree QUIET)
find_or_build_package(wholeBodyInterface QUIET)

ycm_ep_helper(yarpWholeBodyInterface TYPE GIT
              STYLE GITHUB
              REPOSITORY robotology/yarp-wholebodyinterface.git
              TAG master
              COMPONENT robotology
              CMAKE_ARGS -DYARPWBI_USES_KDL:BOOL=OFF
              DEPENDS YARP
                      ICUB
                      iDynTree
                      wholeBodyInterface)
