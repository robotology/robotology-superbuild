# Copyright (C) Fondazione Istituto Italiano di Tecnologia
# CopyPolicy: Released under the terms of the LGPLv2.1 or later, see LGPL.TXT

# Detect if robotology-superbuild is being configured under a conda environment
if(DEFINED ENV{CONDA_PREFIX})
  set(ROBOTOLOGY_CONFIGURING_UNDER_CONDA ON)
else()
  set(ROBOTOLOGY_CONFIGURING_UNDER_CONDA OFF)
endif()

# Core
if(ROBOTOLOGY_ENABLE_CORE)
  find_or_build_package(YARP)
  find_or_build_package(ICUB)
  find_or_build_package(ICUBcontrib)
  find_or_build_package(icub-models)
  find_or_build_package(robots-configuration)
  if(ROBOTOLOGY_USES_GAZEBO)
    find_or_build_package(GazeboYARPPlugins)
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
  find_or_build_package(qpOASES)
  find_or_build_package(BlockFactory)
  find_or_build_package(WBToolbox)
  find_or_build_package(osqp)
  find_or_build_package(OsqpEigen)
  find_or_build_package(UnicyclePlanner)
  find_or_build_package(walking-controllers)
  find_or_build_package(whole-body-estimators)
  find_or_build_package(whole-body-controllers)
  find_or_build_package(matio-cpp)
  find_or_build_package(bipedal-locomotion-framework)
  find_or_build_package(YARP_telemetry)
  if(ROBOTOLOGY_USES_MATLAB)
    find_or_build_package(osqp-matlab)
  endif()
endif()

# Teleoperation
if(ROBOTOLOGY_ENABLE_TELEOPERATION)
  find_or_build_package(walking-teleoperation)
endif()

# Human Dynamics Estimation
if(ROBOTOLOGY_ENABLE_HUMAN_DYNAMICS)
  find_or_build_package(forcetorque-yarp-devices)
  find_or_build_package(wearables)
  find_or_build_package(human-dynamics-estimation)
  find_or_build_package(human-gazebo)
endif()

# Grasping
if(ROBOTOLOGY_ENABLE_GRASPING)
  find_or_build_package(icub-grasp-demo)
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
  if(NOT APPLE AND NOT ROBOTOLOGY_CONFIGURING_UNDER_CONDA)
    find_or_build_package(diagnosticdaemon)
  endif()
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

# R1 Robot
if(ROBOTOLOGY_ENABLE_R1_ROBOT)
  find_or_build_package(navigation)
  find_or_build_package(cer)
endif()

if(ROBOTOLOGY_USES_OCULUS_SDK)
  find_or_build_package(yarp-device-ovrheadset)
endif()
