# Copyright (C) 2017-2018  iCub Facility, Istituto Italiano di Tecnologia
# Authors: Silvio Traversaro <silvio.traversaro@iit.it>
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(YARP QUIET)
find_or_build_package(ICUB QUIET)
find_or_build_package(iDynTree QUIET)
find_or_build_package(qpOASES QUIET)
find_or_build_package(sharedlibpp QUIET)
find_or_build_package(BlockFactory QUIET)
find_or_build_package(OsqpEigen QUIET)
find_or_build_package(QpSolversEigen QUIET)

ycm_ep_helper(WBToolbox TYPE GIT
              STYLE GITHUB
              REPOSITORY robotology/wb-toolbox.git
              TAG master
              COMPONENT dynamics
              FOLDER src
              CMAKE_ARGS -DWBT_USES_MATLAB:BOOL=${ROBOTOLOGY_USES_MATLAB}
                         -DWBT_USES_ICUB:BOOL=ON
                         -DWBT_USES_QPOASES:BOOL=ON
                         -DWBT_USES_OSQPEIGEN:BOOL=ON
              DEPENDS YARP
                      ICUB
                      iDynTree
                      qpOASES
                      BlockFactory
                      OsqpEigen
                      sharedlibpp
                      QpSolversEigen)

set(WBToolbox_CONDA_DEPENDENCIES eigen) 
