# Copyright (C) Fondazione Istituto Italiano di Tecnologia

include(YCMEPHelper)

# At the moment we pass BUILD_WITH_VECTORIZATION_SUPPORT as the simde dependency
# is available out of the box just on Ubuntu 22.04, and because anyhow casadi
# will link the non-vectorized version
# However, as the superbuild is tipically compiled in the same machine in
# which the binaries run, it could make sense to actualize support vectorization
ycm_ep_helper(proxsuite TYPE GIT
              STYLE GITHUB
              REPOSITORY Simple-Robotics/proxsuite.git
              TAG main
              COMPONENT external
              FOLDER src
              CMAKE_ARGS -DBUILD_TESTING:BOOL=OFF -DINSTALL_DOCUMENTATION:BOOL=OFF -DBUILD_PYTHON_INTERFACE:BOOL=OFF -DBUILD_WITH_VECTORIZATION_SUPPORT:BOOL=OFF)

set(proxsuite_CONDA_PKG_CONDA_FORGE_OVERRIDE ON)
