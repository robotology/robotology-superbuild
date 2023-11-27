# Copyright (C) 2023 Fondazione Istituto Italiano di Tecnologia
# Authors: Silvio Traversaro <silvio.traversaro@iit.it>
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(YARP QUIET)

ycm_ep_helper(yarp-ros TYPE GIT
              STYLE GITHUB
              REPOSITORY robotology/yarp-ros.git
              TAG master
              COMPONENT core
              FOLDER src
              DEPENDS YARP)
