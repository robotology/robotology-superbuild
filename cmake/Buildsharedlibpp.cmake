# SPDX-FileCopyrightText: Fondazione Istituto Italiano di Tecnologia (IIT)
# SPDX-License-Identifier: BSD-3-Clause

include(YCMEPHelper)

find_or_build_package(YCM QUIET)

ycm_ep_helper(sharedlibpp TYPE GIT
              STYLE GITHUB
              REPOSITORY ami-iit/sharedlibpp.git
              TAG main
              COMPONENT dynamics
              FOLDER src
              DEPENDS YCM
              CMAKE_ARGS)

set(sharedlibpp_CONDA_PKG_NAME sharedlibpp)
set(sharedlibpp_CONDA_PKG_CONDA_FORGE_OVERRIDE ON)
