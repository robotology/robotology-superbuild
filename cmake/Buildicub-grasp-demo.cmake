# Copyright (C) 2017  iCub Facility, Istituto Italiano di Tecnologia
# Authors: Silvio Traversaro <silvio.traversaro@iit.it>
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(YARP QUIET)
find_or_build_package(ICUB QUIET)
find_or_build_package(ICUBcontrib QUIET)
find_or_build_package(rfsmTools QUIET)
find_or_build_package(segmentation QUIET)
find_or_build_package(himrep QUIET)
find_or_build_package(stereo-vision QUIET)


ycm_ep_helper(icub-grasp-demo  TYPE GIT
                               STYLE GITHUB
                               REPOSITORY robotology/icub-grasp-demo.git
                               DEPENDS YARP
                                       ICUB
                                       ICUBcontrib
                                       rfsmTools
                                       segmentation
                                       himrep
                                       stereo-vision
                               COMPONENT grasping
                               FOLDER src)
