# SPDX-FileCopyrightText: Fondazione Istituto Italiano di Tecnologia (IIT)
# SPDX-License-Identifier: BSD-3-Clause

include(YCMEPHelper)
include(FindOrBuildPackage)

ycm_ep_helper(ResolveRoboticsURICpp TYPE GIT
                                    STYLE GITHUB
                                    REPOSITORY ami-iit/resolve-robotics-uri-cpp.git
                                    COMPONENT core
                                    FOLDER src)

set(ResolveRoboticsURICpp_CONDA_PKG_NAME libresolve-robotics-uri-cpp)
set(ResolveRoboticsURICpp_CONDA_PKG_CONDA_FORGE_OVERRIDE ON)
