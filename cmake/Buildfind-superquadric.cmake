# Copyright (C) 2022  iCub Tech Facility, Istituto Italiano di Tecnologia
# Authors: Ugo Pattacini <ugo.pattacini@iit.it>
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(YARP QUIET)
find_or_build_package(ICUB QUIET)

ycm_ep_helper(find-superquadric TYPE GIT
                                STYLE GITHUB
                                REPOSITORY robotology/find-superquadric.git
                                DEPENDS YARP
                                        ICUB
                                COMPONENT grasping
                                FOLDER src)
