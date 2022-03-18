#.rst:
# BuildqpOASES
# --------
#
# qpOASES

#=============================================================================
# Copyright 2014 iCub Facility, Istituto Italiano di Tecnologia
#   Authors: Daniele E. Domenichelli <daniele.domenichelli@iit.it>
#
# Distributed under the OSI-approved BSD License (the "License");
# see accompanying file Copyright.txt for details.
#
# This software is distributed WITHOUT ANY WARRANTY; without even the
# implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
# See the License for more information.
#=============================================================================
# (To distribute this file outside of YCM, substitute the full
#  License text for the above reference.)

# qpOASES
include(YCMEPHelper)

ycm_ep_helper(qpOASES TYPE GIT
              STYLE GITHUB
              REPOSITORY robotology-dependencies/qpOASES.git
              TAG master
              COMPONENT external
              FOLDER src
              CMAKE_ARGS -DQPOASES_BUILD_BINDINGS_MATLAB:BOOL=OFF)

set(qpOASES_CONDA_PKG_NAME "qpoases")
set(qpOASES_CONDA_PKG_CONDA_FORGE_OVERRIDE ON)
# This is a small hack. To avoid incompatibilities between the version tagged in the robotology-dependencies fork
# (something like 3.2.0.1) and the version available in conda-forge when generating conda metapackages
# such as robotology-distro and robotology-distro-all, we override the conda package version of qpOASES
# here. This needs to be removed as soon as we stop use our fork in the superbuild 
set(casadi_CONDA_VERSION 3.2.1)
