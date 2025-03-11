# Copyright (C) Fondazione Istituto Italiano di Tecnologia
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

include(YCMEPHelper)
include(FindOrBuildPackage)

find_or_build_package(YARP QUIET)
find_or_build_package(manif QUIET)
find_or_build_package(bipedal-locomotion-framework QUIET)
find_or_build_package(iDynTree QUIET)

set(BiomechanicalAnalysisFramework_DEPENDS_DEPENDS "")
list(APPEND BiomechanicalAnalysisFramework_DEPENDS YARP)
list(APPEND BiomechanicalAnalysisFramework_DEPENDS_DEPENDS manif)
list(APPEND BiomechanicalAnalysisFramework_DEPENDS_DEPENDS bipedal-locomotion-framework)
list(APPEND BiomechanicalAnalysisFramework_DEPENDS_DEPENDS iDynTree)

set(BiomechanicalAnalysisFramework_OPTIONAL_CMAKE_ARGS "")
if(ROBOTOLOGY_USES_PYTHON)
  list(APPEND BiomechanicalAnalysisFramework_OPTIONAL_CMAKE_ARGS "-DFRAMEWORK_PYTHON_INSTALL_DIR:PATH=${ROBOTOLOGY_SUPERBUILD_PYTHON_INSTALL_DIR}")
endif()

ycm_ep_helper(BiomechanicalAnalysisFramework TYPE GIT
              STYLE GITHUB
              REPOSITORY ami-iit/biomechanical-analysis-framework.git
              TAG master
              COMPONENT dynamics
              FOLDER src
              CMAKE_ARGS -DFRAMEWORK_COMPILE_YarpImplementation:BOOL=ON
                         -DFRAMEWORK_COMPILE_PYTHON_BINDINGS:BOOL=${ROBOTOLOGY_USES_PYTHON}
                         ${BiomechanicalAnalysisFramework_OPTIONAL_CMAKE_ARGS}
              DEPENDS ${BiomechanicalAnalysisFramework_DEPENDS})

set(BiomechanicalAnalysisFramework_CONDA_PKG_NAME biomechanical-analysis-framework)
set(BiomechanicalAnalysisFramework_CONDA_PKG_CONDA_FORGE_OVERRIDE ON)
