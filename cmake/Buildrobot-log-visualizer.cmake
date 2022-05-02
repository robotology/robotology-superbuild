# SPDX-FileCopyrightText: 2022 Fondazione Istituto Italiano di Tecnologia
# SPDX-License-Identifier: BSD-3-Clause

include(RobSupPurePythonYCMEPHelper)

find_or_build_package(icub-models QUIET)
find_or_build_package(pyqtconsole QUIET)
find_or_build_package(meshcat-python QUIET)
find_or_build_package(iDynTree QUIET)

rob_sup_pure_python_ycm_ep_helper(robot-log-visualizer
                                  REPOSITORY ami-iit/robot-log-visualizer.git
                                  DEPENDS meshcat-python
                                          pyqtconsole
                                          icub-models
                                          iDynTree
                                  TAG main
                                  COMPONENT dynamics
                                  FOLDER src)

set(robot-log-visualizer_CONDA_DEPENDENCIES numpy pyqt matplotlib h5py)
set(robot-log-visualizer_CONDA_ENTRY_POINTS "robot-log-visualizer = robot_log_visualizer.__main__:main")
