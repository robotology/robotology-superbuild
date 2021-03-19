# Copyright (C) Fondazione Istituto Italiano di Tecnologia
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT
include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(osqp QUIET)

ycm_ep_helper(osqp-matlab TYPE GIT
              STYLE GITHUB
              REPOSITORY dic-iit/osqp-matlab-cmake-buildsystem.git
              TAG master
              COMPONENT dynamics
              FOLDER src
              CMAKE_ARGS -DOSQP_MATLAB_USES_MATLAB:BOOL=${ROBOTOLOGY_USES_MATLAB}
              DEPENDS osqp)

# Metadata for conda package generation 
# If we do not set the package name, by default the repo name would be used
# so in this case osqp-matlab-cmake-buildsystem that is not descriptive of the
# generated artifact that is contained in the conda package
set(osqp-matlab_CONDA_PKG_NAME "osqp-matlab")
