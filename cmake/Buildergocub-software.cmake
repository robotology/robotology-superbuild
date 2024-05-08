# Copyright (C) 2023 iCub Tech, Istituto Italiano di Tecnologia
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(YARP QUIET)

find_package(OpenCV QUIET)
if(DEFINED OpenCV_VERSION AND OpenCV_VERSION VERSION_GREATER_EQUAL "4.5.2")
  set(COMPILE_ergoCubEmotions ON)
else()
  set(COMPILE_ergoCubEmotions OFF)
endif()

ycm_ep_helper(ergocub-software
              TYPE GIT
              STYLE GITHUB
              REPOSITORY icub-tech-iit/ergocub-software.git
              TAG master
              DEPENDS YARP
              COMPONENT core
              FOLDER src
              DEPENDS YARP
              CMAKE_ARGS -DCOMPILE_ergoCubEmotions:BOOL=${COMPILE_ergoCubEmotions})

set(ergocub-software_CONDA_PKG_NAME ergocub-software)
set(ergocub-software_CONDA_PKG_CONDA_FORGE_OVERRIDE ON)
