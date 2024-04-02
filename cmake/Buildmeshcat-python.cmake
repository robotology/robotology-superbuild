# SPDX-FileCopyrightText: 2022 Fondazione Istituto Italiano di Tecnologia
# SPDX-License-Identifier: BSD-3-Clause

include(RobSupPurePythonYCMEPHelper)

find_or_build_package(pyngrok QUIET)

rob_sup_pure_python_ycm_ep_helper(meshcat-python
                                  REPOSITORY rdeits/meshcat-python.git
                                  DEPENDS pyngrok
                                  TAG master
                                  COMPONENT dynamics
                                  FOLDER src
                                  PYTHON_PACKAGE_NAME meshcat)


set(meshcat-python_CONDA_PKG_NAME meshcat-python)
set(meshcat-python_CONDA_PKG_CONDA_FORGE_OVERRIDE ON)
