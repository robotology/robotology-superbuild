# Copyright (C) 2018  iCub Facility, Istituto Italiano di Tecnologia
# Authors: Stefano Dafarra <stefano.dafarra@iit.it>
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT
include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(osqp QUIET)

ycm_ep_helper(OsqpEigen TYPE GIT
              STYLE GITHUB
              REPOSITORY robotology/osqp-eigen.git
              TAG master
              COMPONENT dynamics
              FOLDER src
              CMAKE_ARGS -DBUILD_TESTING:BOOL=OFF
              DEPENDS osqp)
