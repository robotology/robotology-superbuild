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
              CMAKE_ARGS -DUNITTESTS:BOOL=OFF)

set(osqp_CONDA_PKG_NAME libosqp)
set(osqp_CONDA_PKG_CONDA_FORGE_OVERRIDE ON)
