# SPDX-FileCopyrightText: Fondazione Istituto Italiano di Tecnologia (IIT)
# SPDX-License-Identifier: BSD-3-Clause

include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(YCM QUIET)

ycm_ep_helper(ResolveRoboticsURICpp TYPE GIT
                                    STYLE GITHUB
                                    REPOSITORY ami-iit/resolve-robotics-uri-cpp.git
                                    TAG main
                                    COMPONENT core
                                    FOLDER src
                                    CMAKE_ARGS -DBUILD_TESTING:BOOL=OFF -DRRUP_USE_SYSTEM_YCM:BOOL=ON
                                    DEPENDS YCM)

set(ResolveRoboticsURICpp_CONDA_PKG_NAME libresolve-robotics-uri-cpp)
set(ResolveRoboticsURICpp_CONDA_PKG_CONDA_FORGE_OVERRIDE ON)
