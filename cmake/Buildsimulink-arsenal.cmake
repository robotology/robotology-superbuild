# SPDX-FileCopyrightText: Fondazione Istituto Italiano di Tecnologia (IIT)
# SPDX-License-Identifier: BSD-3-Clause

include(YCMEPHelper)
include(FindOrBuildPackage)

ycm_ep_helper(simulink-arsenal TYPE GIT
              STYLE GITHUB
              REPOSITORY icub-tech-iit/simulink-arsenal.git
              COMPONENT iCub
              FOLDER src
              # Just some dummy commands that exists on all operating systems
              # as we do not actually want to build anything for this repo,
              # just to clone it
              CONFIGURE_COMMAND ${CMAKE_COMMAND} --version
              BUILD_COMMAND ${CMAKE_COMMAND} --version
              INSTALL_COMMAND ${CMAKE_COMMAND} --version
)
