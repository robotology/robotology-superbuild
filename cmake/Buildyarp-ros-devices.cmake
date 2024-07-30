# Copyright (C) Fondazione Istituto Italiano di Tecnologia

include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(YARP QUIET)

ycm_ep_helper(yarp-ros-devices TYPE GIT
              STYLE GITHUB
              REPOSITORY robotology/yarp-ros-devices.git
              TAG master
              COMPONENT core
              FOLDER src
              DEPENDS YARP)
