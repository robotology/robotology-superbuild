# Copyright (C) Fondazione Istituto Italiano di Tecnologia
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT
include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(mujoco QUIET)

ycm_ep_helper(mujoco-simulink-blockset TYPE GIT
              STYLE GITHUB
              REPOSITORY ami-iit/mujoco-simulink-blockset-cmake-buildsystem.git
              TAG main
              COMPONENT dynamics
              FOLDER src
              DEPENDS mujoco)

# Metadata for conda package generation
# If we do not set the package name, by default the repo name would be used
# so in this case mujoco-simulink-blockset-cmake-buildsystem that is not descriptive of the
# generated artifact that is contained in the conda package
set(mujoco-simulink-blockset_CONDA_PKG_NAME "mujoco-simulink-blockset")
