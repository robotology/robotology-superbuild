# Copyright (C) Fondazione Istituto Italiano di Tecnologia
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

# Detect if robotology-superbuild is being configured under a conda environment
if(DEFINED ENV{CONDA_PREFIX})
  set(ROBOTOLOGY_CONFIGURING_UNDER_CONDA ON)
else()
  set(ROBOTOLOGY_CONFIGURING_UNDER_CONDA OFF)
endif()


# We only build qhull on Ubuntu 20.04, not on any other platform
# See https://github.com/robotology/robotology-superbuild/issues/1269#issuecomment-1257811559
# See https://stackoverflow.com/questions/26919334/detect-underlying-platform-flavour-in-cmake
if(ROBOTOLOGY_CONFIGURING_UNDER_CONDA OR APPLE OR WIN32)
  set(ROBOTOLOGY_BUILD_QHULL OFF)
else()
  find_program(ROBSUB_LSB_RELEASE lsb_release)
  if(ROBSUB_LSB_RELEASE)
    execute_process(COMMAND lsb_release -cs
      OUTPUT_VARIABLE LSB_RELEASE_CODENAME
      OUTPUT_STRIP_TRAILING_WHITESPACE
    )
  endif()
  if(LSB_RELEASE_CODENAME STREQUAL "focal")
    set(ROBOTOLOGY_BUILD_QHULL ON)
  else()
    set(ROBOTOLOGY_BUILD_QHULL OFF)
  endif()
endif()

# On conda-forge we get tomlplusplus from conda-forge, otherwise we build it
if(ROBOTOLOGY_CONFIGURING_UNDER_CONDA)
  set(ROBOTOLOGY_BUILD_tomlplusplus OFF)
else()
  set(ROBOTOLOGY_BUILD_tomlplusplus ON)
endif()

# I (@traversaro) am not particularly happy about this, but Ubuntu 24.04
# got released with a version of swig (4.2.0) that contained several bugs.
# The bugs were reported and fixed by swig authors (a huge thanks), and released
# as swig 4.2.1 but the Ubuntu 24.04 sync with Debian happened exactly when
# swig 4.2.0 was packaged in Debian, so now Ubuntu 24.04 contains a swig
# that does not work with YARP. As swig is a tool just used as build time,
# as workaround just for Ubuntu 24.04 with apt dependencies we download
# a custom build of swig 4.2.1 locally
if(LSB_RELEASE_CODENAME STREQUAL "noble" AND NOT ROBOTOLOGY_CONFIGURING_UNDER_CONDA)
  include(FetchContent)
  FetchContent_Declare(
    robotology_superbuild_local_noble_swig_4_2_1
    URL "https://github.com/robotology/robotology-vcpkg-ports/releases/download/storage/swig_4_2_1_ubuntu_24_04.zip")

  FetchContent_GetProperties(robotology_superbuild_local_noble_swig_4_2_1)
  if(NOT robotology_superbuild_local_noble_swig_4_2_1_POPULATED)
    message(STATUS "Downloading robotology_superbuild_local_noble_swig_4_2_1 binaries.")
    FetchContent_Populate(robotology_superbuild_local_noble_swig_4_2_1)
    message(STATUS "Downloaded a local copy of swig 4.2.1 in ${robotology_superbuild_local_noble_swig_4_2_1_SOURCE_DIR}")
  endif()
  set(ROBOTOLOGY_SUPERBUILD_USING_LOCAL_SWIG_4_2_1_WORKAROUND_ON_NOBLE ON)
  list(APPEND YARP_OPTIONAL_CMAKE_ARGS "-DSWIG_EXECUTABLE=${robotology_superbuild_local_noble_swig_4_2_1_SOURCE_DIR}/bin/swig")
  list(APPEND YARP_OPTIONAL_CMAKE_ARGS "-DSWIG_DIR=${robotology_superbuild_local_noble_swig_4_2_1_SOURCE_DIR}/share/swig/4.2.1")
else()
  set(ROBOTOLOGY_SUPERBUILD_USING_LOCAL_SWIG_4_2_1_WORKAROUND_ON_NOBLE OFF)
endif()

# Core
if(ROBOTOLOGY_ENABLE_CORE)
  find_or_build_package(YARP)
  if(ROBOTOLOGY_SUPERBUILD_BUILD_SEPARATE_YARP_ROS)
    find_or_build_package(yarp-ros)
  endif()
  find_or_build_package(yarp-devices-ros)
  find_or_build_package(ICUB)
  find_or_build_package(ICUBcontrib)
  find_or_build_package(icub-models)
  find_or_build_package(ergocub-software)
  find_or_build_package(robots-configuration)
  if(ROBOTOLOGY_USES_GAZEBO)
    find_or_build_package(GazeboYARPPlugins)
  endif()
  if(ROBOTOLOGY_USES_GZ)
    find_or_build_package(gz-sim-yarp-plugins)
  endif()
  if(ROBOTOLOGY_USES_IGNITION)
    find_or_build_package(gym-ignition)
  endif()
  if(ROBOTOLOGY_USES_MATLAB OR ROBOTOLOGY_USES_OCTAVE)
    find_or_build_package(yarp-matlab-bindings)
  endif()
endif()

# Robot Testing
if(ROBOTOLOGY_ENABLE_ROBOT_TESTING)
  find_or_build_package(RobotTestingFramework)
  find_or_build_package(icub-tests)
  find_or_build_package(blocktestcore)
  find_or_build_package(blocktest-yarp-plugins)
endif()

# Dynamics
if(ROBOTOLOGY_ENABLE_DYNAMICS)
  find_or_build_package(iDynTree)
  # If we are generating conda-recipes, then we also need to build idyntree-matlab-bindings
  # as the iDynTree package provided by conda-forge does not have MATLAB bindings, so we generate
  # this package in the robotology channel
  if(ROBOTOLOGY_GENERATE_CONDA_RECIPES AND ROBOTOLOGY_USES_MATLAB)
    find_or_build_package(idyntree-matlab-bindings)
  endif()
  find_or_build_package(OsqpEigen QUIET)
  find_or_build_package(idyntree-yarp-tools)
  find_or_build_package(qpOASES)
  find_or_build_package(BlockFactory)
  find_or_build_package(WBToolbox)
  find_or_build_package(osqp)
  find_or_build_package(OsqpEigen)
  find_or_build_package(UnicyclePlanner)
  find_or_build_package(whole-body-estimators)
  find_or_build_package(whole-body-controllers)
  find_or_build_package(matioCpp)
  find_or_build_package(robometry)
  if(ROBOTOLOGY_USES_MATLAB)
    find_or_build_package(osqp-matlab)
    find_or_build_package(matlab-whole-body-simulator)
  endif()
  if(ROBOTOLOGY_ENABLE_DYNAMICS_FULL_DEPS)
    find_or_build_package(BayesFilters)
    find_or_build_package(bipedal-locomotion-framework)
    find_or_build_package(yarp-device-keyboard-joypad)
    find_or_build_package(walking-controllers)
    if(ROBOTOLOGY_USES_MATLAB)
      find_or_build_package(casadi-matlab-bindings)
    endif()
    if(ROBOTOLOGY_USES_PYTHON)
      find_or_build_package(robot-log-visualizer)
      find_or_build_package(resolve-robotics-uri-py)
    endif()
  endif()
endif()

# Teleoperation
if(ROBOTOLOGY_ENABLE_TELEOPERATION)
  find_or_build_package(walking-teleoperation)
  if(NOT APPLE)
    find_or_build_package(yarp-device-openxrheadset)
    find_or_build_package(yarp-openvr-trackers)
  endif()
endif()

# Human Dynamics Estimation
if(ROBOTOLOGY_ENABLE_HUMAN_DYNAMICS)
  find_or_build_package(yarp-devices-forcetorque)
  find_or_build_package(wearables)
  find_or_build_package(HumanDynamicsEstimation)
  find_or_build_package(human-gazebo)
endif()

# Grasping
if(ROBOTOLOGY_ENABLE_GRASPING)
  if(ROBOTOLOGY_USES_PCL_AND_VTK)
    find_or_build_package(find-superquadric)
  else()
    message(FATAL_ERROR "If ROBOTOLOGY_ENABLE_GRASPING is enabled you must also enable ROBOTOLOGY_USES_PCL_AND_VTK.")
  endif()
endif()

# Event-driven
if(ROBOTOLOGY_ENABLE_EVENT_DRIVEN)
  find_or_build_package(event-driven)
endif()

# IOL
if(ROBOTOLOGY_ENABLE_IOL)
  if(NOT ROBOTOLOGY_USES_LUA)
    message(FATAL_ERROR "Impossible to set ROBOTOLOGY_ENABLE_IOL to TRUE if ROBOTOLOGY_USES_LUA is set to false")
  endif()
  find_or_build_package(iol)
endif()

# iCub Robot
if(ROBOTOLOGY_ENABLE_ICUB_HEAD)
  find_or_build_package(icub_firmware_shared)
  find_or_build_package(ICUB)
  find_or_build_package(icub-firmware-build)
  if((NOT WIN32) AND (NOT APPLE))
    find_or_build_package(yarp-device-xsensmt)
  endif()
endif()

# iCub Basic Demos
if(ROBOTOLOGY_ENABLE_ICUB_BASIC_DEMOS)
  find_or_build_package(icub-basic-demos)
  find_or_build_package(speech)
  find_or_build_package(funny-things)
endif()

# MuJoCo
if(ROBOTOLOGY_USES_MUJOCO)
  find_or_build_package(mujoco)
  if(ROBOTOLOGY_USES_MATLAB AND NOT ROBOTOLOGY_NOT_USE_SIMULINK)
    find_or_build_package(mujoco-simulink-blockset)
  endif()
endif()

# R1 Robot
if(ROBOTOLOGY_ENABLE_R1_ROBOT)
  find_or_build_package(navigation)
  find_or_build_package(cer)
endif()

# Dummy option used to only clone repos to update them 
# via update-latest-releases.yml GitHub Action
if(ROBOTOLOGY_INTERNAL_CLONE_ALL_REPOS_FOR_UPDATE)
  find_or_build_package(icub-firmware)
  find_or_build_package(icub-firmware-models)
endif()
