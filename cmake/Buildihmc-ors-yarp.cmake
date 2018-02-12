# Copyright (C) 2017  iCub Facility, Istituto Italiano di Tecnologia
# Authors: Silvio Traversaro <silvio.traversaro@iit.it>
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(YARP QUIET)
find_or_build_package(fastcdr)

ycm_ep_helper(ihmc-ors-yarp TYPE GIT
              STYLE GITHUB
              REPOSITORY robotology-playground/ihmc-ors-yarp.git
              TAG master
              COMPONENT IHMC
              FOLDER robotology
              DEPENDS YARP
                      fastcdr)
