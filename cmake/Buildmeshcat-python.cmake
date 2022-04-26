# SPDX-FileCopyrightText: 2022 Fondazione Istituto Italiano di Tecnologia
# SPDX-License-Identifier: BSD-3-Clause

include(RobSupPurePythonYCMEPHelper)

rob_sup_pure_python_ycm_ep_helper(meshcat-python
                                  REPOSITORY rdeits/meshcat-python.git
                                  TAG master
                                  COMPONENT dynamics
                                  FOLDER src)


set(meshcat-python_CONDA_PKG_NAME meshcat-python)
set(meshcat-python_CONDA_PKG_CONDA_FORGE_OVERRIDE ON)
