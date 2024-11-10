# SPDX-FileCopyrightText: Fondazione Istituto Italiano di Tecnologia (IIT)
# SPDX-License-Identifier: BSD-3-Clause

include(YCMEPHelper)
include(FindOrBuildPackage)

set(QpSolversEigen_DEPENDS "")
find_or_build_package(sharedlibpp QUIET)
list(APPEND QpSolversEigen_DEPENDS sharedlibpp)
find_or_build_package(YCM QUIET)
list(APPEND QpSolversEigen_DEPENDS YCM)
find_or_build_package(OsqpEigen QUIET)
list(APPEND QpSolversEigen_DEPENDS OsqpEigen)


# proxqp only supports MSVC Toolset v143, i.e. Visual Studio 2022
if(NOT MSVC OR MSVC_VERSION VERSION_GREATER_EQUAL 1930)
  find_or_build_package(proxsuite QUIET)
  list(APPEND QpSolversEigen_DEPENDS proxsuite)
  set(QPSOLVERSEIGEN_ENABLE_PROXQP ON)
else()
  set(QPSOLVERSEIGEN_ENABLE_PROXQP OFF)
endif()

ycm_ep_helper(QpSolversEigen TYPE GIT
              STYLE GITHUB
              REPOSITORY ami-iit/qpsolvers-eigen.git
              TAG main
              COMPONENT dynamics
              FOLDER src
              CMAKE_ARGS -DBUILD_TESTING:BOOL=OFF
                         -DQPSOLVERSEIGEN_USES_SYSTEM_SHAREDLIBPP:BOOL=ON
                         -DQPSOLVERSEIGEN_USES_SYSTEM_YCM:BOOL=ON
                         -DQPSOLVERSEIGEN_ENABLE_OSQP:BOOL=ON
                         -DQPSOLVERSEIGEN_ENABLE_PROXQP:BOOL=${QPSOLVERSEIGEN_ENABLE_PROXQP}
              DEPENDS ${QpSolversEigen_DEPENDS})

set(QpSolversEigen_CONDA_PKG_NAME qpsolvers-eigen)
set(QpSolversEigen_CONDA_PKG_CONDA_FORGE_OVERRIDE ON)
