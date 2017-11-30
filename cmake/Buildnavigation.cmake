# Copyright (C) 2017  iCub Facility, Istituto Italiano di Tecnologia
# Authors: Silvio Traversaro <silvio.traversaro@iit.it>
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(YARP QUIET)
find_or_build_package(ICUB QUIET)
find_or_build_package(ICUBcontrib QUIET)

ycm_ep_helper(navigation TYPE GIT
                         STYLE GITHUB
                         REPOSITORY robotology/navigation.git
                         TAG master
                         COMPONENT navigation
                         FOLDER robotology
                         DEPENDS YARP
                                 ICUB
                                 ICUBcontrib)
