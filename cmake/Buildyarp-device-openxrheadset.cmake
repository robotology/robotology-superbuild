# SPDX-FileCopyrightText: 2022 Fondazione Istituto Italiano di Tecnologia (IIT)
# SPDX-License-Identifier: BSD-3-Clause

include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(YARP QUIET)
find_or_build_package(OpenXR QUIET)
find_or_build_package(iDynTree QUIET)

ycm_ep_helper(yarp-device-openxrheadset TYPE GIT
              STYLE GITHUB
              REPOSITORY ami-iit/yarp-device-openxrheadset.git
              TAG main
              COMPONENT dynamics
              FOLDER src
              DEPENDS YARP
                      OpenXR
                      iDynTree)

set(yarp-device-openxrheadset_CONDA_DEPENDENCIES glew glm glfw xorg-xproto)
