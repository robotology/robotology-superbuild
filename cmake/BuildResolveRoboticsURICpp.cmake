# SPDX-FileCopyrightText: Fondazione Istituto Italiano di Tecnologia (IIT)
# SPDX-License-Identifier: BSD-3-Clause

include(YCMEPHelper)
include(FindOrBuildPackage)

ycm_ep_helper(ResolveRoboticsURICpp TYPE GIT
                                    STYLE GITHUB
                                    REPOSITORY robotology/ycm.git
                                    COMPONENT core
                                    FOLDER src)

set(YCM_CONDA_PKG_NAME resolve-robotics-uri-cpp)
set(YCM_CONDA_PKG_CONDA_FORGE_OVERRIDE ON)
