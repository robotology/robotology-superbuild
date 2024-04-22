# Copyright (C) Fondazione Istituto Italiano di Tecnologia
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(YARP QUIET)

ycm_ep_helper(yarp-device-keyboard-joypad TYPE GIT
                                          STYLE GITHUB
                                          REPOSITORY ami-iit/yarp-device-keyboard-joypad.git
                                          TAG master
                                          COMPONENT dynamics
                                          FOLDER src
                                          DEPENDS YCM
                                                  YARP)
