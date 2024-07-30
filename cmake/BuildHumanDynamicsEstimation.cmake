# Copyright (C) 2018  iCub Facility, Istituto Italiano di Tecnologia
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(YARP QUIET)
find_or_build_package(ICUB QUIET)
find_or_build_package(iDynTree QUIET)
find_or_build_package(wearables QUIET)
find_or_build_package(osqp QUIET)
find_or_build_package(OsqpEigen QUIET)

if(ROBOTOLOGY_BUILD_SEPARATE_YARP_ROS)
  find_or_build_package(yarp-ros QUIET)
  list(APPEND HumanDynamicsEstimation_OPTIONAL_DEPS yarp-ros)
endif()

ycm_ep_helper(HumanDynamicsEstimation TYPE GIT
              STYLE GITHUB
              REPOSITORY robotology/human-dynamics-estimation.git
              TAG master
              COMPONENT human_dynamics
              FOLDER src
              CMAKE_ARGS -DHUMANSTATEPROVIDER_ENABLE_VISUALIZER:BOOL=ON
              DEPENDS iDynTree
                      YARP
                      wearables
                      osqp
                      OsqpEigen
                      ICUB
                      ${HumanDynamicsEstimation_OPTIONAL_DEPS})

set(HumanDynamicsEstimation_CONDA_DEPENDENCIES eigen)
