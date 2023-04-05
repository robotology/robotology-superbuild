# Copyright (C) Fondazione Istituto Italiano di Tecnologia

include(YCMEPHelper)

ycm_ep_helper(proxsuite TYPE GIT
              STYLE GITHUB
              REPOSITORY Simple-Robotics/proxsuite.git
              TAG main
              COMPONENT external
              FOLDER src
              CMAKE_ARGS -DBUILD_TESTING:BOOL=OFF -DINSTALL_DOCUMENTATION:BOOL=OFF -DBUILD_PYTHON_INTERFACE:BOOL=OFF)

set(proxsuite_CONDA_PKG_CONDA_FORGE_OVERRIDE ON)
