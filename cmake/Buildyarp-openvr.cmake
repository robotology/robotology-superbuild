# SPDX-FileCopyrightText: 2022 Fondazione Istituto Italiano di Tecnologia (IIT)
# SPDX-License-Identifier: BSD-3-Clause

include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(YARP QUIET)
find_or_build_package(OpenVR QUIET)

ycm_ep_helper(yarp-openvr TYPE GIT
              STYLE GITHUB
              REPOSITORY ami-iit/yarp-openvr.git
              TAG master
              COMPONENT dynamics
              FOLDER src
              DEPENDS YARP
                      OpenVR)
