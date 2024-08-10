# Copyright (C) 2018  iCub Facility, Istituto Italiano di Tecnologia
# Authors: Stefano Dafarra <stefano.dafarra@iit.it>
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)

ycm_ep_helper(osqp TYPE GIT
              STYLE GITHUB
              REPOSITORY oxfordcontrol/osqp.git
              TAG master
              COMPONENT external
              FOLDER src
              CMAKE_ARGS -DUNITTESTS:BOOL=OFF
                         -DOSQP_BUILD_STATIC_LIB:BOOL=OFF
                         -DQDLDL_BUILD_STATIC_LIB:BOOL=OFF))

set(osqp_CONDA_PKG_NAME libosqp)
set(osqp_CONDA_PKG_CONDA_FORGE_OVERRIDE ON)
# This is a small hack. To avoid incompatibilities between the version tagged in the robotology-dependencies fork
# (something like 0.6.3.x) and the version available in conda-forge when generating conda metapackages
# such as robotology-distro and robotology-distro-all, we override the conda package version of manif
# here. This needs to be removed as soon as we stop using our fork in the superbuild 
set(osqp_CONDA_VERSION 0.6.3)
