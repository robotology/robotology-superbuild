# Copyright (C) 2023 Fondazione Istituto Italiano di Tecnologia

include(YCMEPHelper)

include(FindOrBuildPackage)

set(mujoco_DEPENDS "")

ycm_ep_helper(mujoco TYPE GIT
              STYLE GITHUB
              REPOSITORY ami-iit/mujoco.git
              TAG integration235
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
