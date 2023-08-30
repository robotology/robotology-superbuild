# Copyright (C) 2023 Fondazione Istituto Italiano di Tecnologia

include(YCMEPHelper)

include(FindOrBuildPackage)

set(mujoco_DEPENDS "")

ycm_ep_helper(mujoco TYPE GIT
              STYLE GITHUB
              REPOSITORY deepmind/mujoco.git
              TAG main
              COMPONENT external
              FOLDER src
              CMAKE_ARGS -DBUILD_TESTING:BOOL=OFF
                         -DMUJOCO_BUILD_TESTS:BOOL=ON
                         -DMUJOCO_BUILD_SIMULATE:BOOL=OFF
                         -DMUJOCO_BUILD_EXAMPLES:BOOL=OFF
                         -DMUJOCO_USE_SYSTEM_qhull:BOOL=ON
                         -DMUJOCO_USE_SYSTEM_tinyxml2:BOOL=OFF
                         -DMUJOCO_USE_SYSTEM_ccd:BOOL=ON
                         -DMUJOCO_USE_SYSTEM_Eigen3:BOOL=ON
              DEPENDS ${mujoco_DEPENDS})

set(mujoco_CONDA_PKG_NAME libmujoco)
set(mujoco_CONDA_PKG_CONDA_FORGE_OVERRIDE ON)

# This is a small hack. To avoid incompatibilities between the version tagged in the ami-iit fork
# (something like 2.3.6.x) and the version available in conda-forge when generating conda metapackages
# such as robotology-distro and robotology-distro-all, we override the conda package version of mujoco
# here. This needs to be removed as soon as we stop use our fork in the superbuild 
set(mujoco_CONDA_VERSION 2.3.6)

