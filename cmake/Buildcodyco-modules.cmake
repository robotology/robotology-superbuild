# Copyright (C) 2017  iCub Facility, Istituto Italiano di Tecnologia
# Authors: Silvio Traversaro <silvio.traversaro@iit.it>
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(YARP QUIET)
find_or_build_package(ICUB QUIET)
find_or_build_package(iDynTree QUIET)
find_or_build_package(wholeBodyInterface QUIET NO_CMAKE_PACKAGE_REGISTRY)
find_or_build_package(yarpWholeBodyInterface QUIET)

set(codyco-module_DEPENDS)

list(APPEND codyco-module_DEPENDS YARP)
list(APPEND codyco-module_DEPENDS ICUB)
list(APPEND codyco-module_DEPENDS iDynTree)
list(APPEND codyco-module_DEPENDS wholeBodyInterface)
list(APPEND codyco-module_DEPENDS yarpWholeBodyInterface)

ycm_ep_helper(codyco-modules TYPE GIT
              STYLE GITHUB
              REPOSITORY robotology/codyco-modules.git
              TAG master
              COMPONENT robotology
              DEPENDS ${codyco-module_DEPENDS}
              CMAKE_ARGS -DCODYCO_USES_KDL:BOOL=OFF)
