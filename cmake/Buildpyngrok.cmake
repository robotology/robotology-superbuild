# SPDX-FileCopyrightText: Fondazione Istituto Italiano di Tecnologia
# SPDX-License-Identifier: BSD-3-Clause

include(RobSupPurePythonYCMEPHelper)

rob_sup_pure_python_ycm_ep_helper(pyngrok
                                  REPOSITORY alexdlaird/pyngrok.git
                                  TAG master
                                  COMPONENT dynamics
                                  FOLDER src
                                  PYTHON_PACKAGE_NAME pyngrok)

set(pyngrok_CONDA_PKG_NAME pyngrok)
set(pyngrok_CONDA_PKG_CONDA_FORGE_OVERRIDE ON)
