# Copyright (C) 2020  iCub Facility, Istituto Italiano di Tecnologia
# Authors: Giulio Romualdi <gulio.romualdi@iit.it>
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)

include(FindOrBuildPackage)
find_or_build_package(osqp QUIET)

ycm_ep_helper(casadi TYPE GIT
              STYLE GITHUB
              REPOSITORY GiulioRomualdi/casadi.git
              TAG feature/support_osqp_0.6.0
              COMPONENT external
              FOLDER src
              CMAKE_ARGS -DWITH_IPOPT:BOOL=ON
                         -DWITH_OSQP:BOOL=ON
                         -DUSE_SYSTEM_WISE_OSQP:BOOL=ON
                         -DINCLUDE_PREFIX:PATH=include
                         -DCMAKE_PREFIX:PATH=lib/cmake/casadi
                         -DLIB_PREFIX:PATH=lib
                         -DBIN_PREFIX:PATH=bin
              DEPENDS osqp)
