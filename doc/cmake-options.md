# robotology-superbuild: CMake Options

Table of Contents
=================
  * [Superbuild CMake options](#superbuild-cmake-options)
    * [Profile CMake options](#profile-cmake-options)
    * [Dependencies CMake options](#dependencies-cmake-options)
    * [Platform Support table](#platform-support-table)
  * [Profile-specific documentation](#profile-specific-documentation)
    * [Core profile](#core)
    * [Robot Testing profile](#robot-testing)
    * [Dynamics profile](#dynamics)
    * [Dynamics full deps profile](#dynamics-full-deps)
    * [iCub Head profile](#icub-head)
    * [iCub Basic Demos profile](#icub-basic-demos)
    * [Teleoperation profile](#teleoperation)
    * [Human Dynamics profile](#human-dynamics)
    * [Event-driven profile](#event-driven)
  * [Dependencies-specific documentation](#dependencies-specific-documentation)
    * [Gazebo simulator](#gazebo)
    * [Ignition](#ignition)
    * [MATLAB](#matlab)
    * [Octave](#octave)
    * [Python](#python)
    * [Oculus](#oculus)
    * [Cyberith](#cyberith)
    * [Xsens](#xsens)
    * [ESDCAN](#esdcan)


Superbuild CMake options
========================

As a huge number of software projects are developed in the `robotology` organization, and a tipical user is only interested in some of them, there are several options to
instruct  the superbuild on which packages should be built and which one should not be built. In particular, the robotology-superbuild is divided in different "profiles",
that specify the specific subset of robotology packages to build.

## Profile CMake options
The profile CMake options specify which subset of the robotology packages will be built by the superbuild.
Note that any dependencies of the included packages that is not available in the system will be downloaded, compiled and installed as well.
All these options are named `ROBOTOLOGY_ENABLE_<profile>` .

| CMake Option | Description | Main packages included | Default Value | Profile-specific documentation |
|:------------:|:-----------:|:---------------------:|:-------------:|:----:|
| `ROBOTOLOGY_ENABLE_CORE` | The core robotology software packages, necessary for most users. | [`YARP`](https://github.com/robotology/yarp), [`ICUB`](https://github.com/robotology/icub-main), [`ICUBcontrib`](https://github.com/robotology/icub-contrib-common), [`icub-models`](https://github.com/robotology/icub-models) and  [`robots-configurations`](https://github.com/robotology/robots-configuration). [`GazeboYARPPlugins`](https://github.com/robotology/GazeboYARPPlugins) and [`icub-gazebo`](https://github.com/robotology/icub-gazebo) if the `ROBOTOLOGY_USES_GAZEBO` option is enabled. [`gym-ignition`](https://github.com/robotology/gym-ignition) if the `ROBOTOLOGY_USES_IGNITION` option is enabled. | `ON` | [Documentation on Core profile.](#core) |
| `ROBOTOLOGY_ENABLE_ROBOT_TESTING` | The robotology software packages related to robot testing. |  [`RobotTestingFramework`](https://github.com/robotology/robot-testing-framework), [`icub-tests`](https://github.com/robotology/icub-tests), [`blocktest`](https://github.com/robotology/blocktest) and [`blocktest-yarp-plugins`](https://github.com/robotology/blocktest-yarp-plugins) | `OFF` | [Documentation on Robot Testing profile.](#robot-testing)  |
| `ROBOTOLOGY_ENABLE_DYNAMICS` | The robotology software packages related to balancing, walking and force control. | [`iDynTree`](https://github.com/robotology/idyntree), [`blockfactory`](https://github.com/robotology/blockfactory), [`wb-Toolbox`](https://github.com/robotology/wb-Toolbox), [`whole-body-controllers`](https://github.com/robotology/whole-body-controllers), [`walking-controllers`](https://github.com/robotology/walking-controllers), [`matioCpp`](https://github.com/dic-iit/matio-cpp), [`robometry`](https://github.com/robotology/robometry). Furthermore, [`osqp-matlab`](https://github.com/dic-iit/osqp-matlab-cmake-buildsystem) and [`matlab-whole-body-simulator`](https://github.com/dic-iit/matlab-whole-body-simulator) if `ROBOTOLOGY_USES_MATLAB` option is enabled. | `OFF` | [Documentation on Dynamics profile.](#dynamics)  |
| `ROBOTOLOGY_ENABLE_DYNAMICS_FULL_DEPS` | [`bipedal-locomotion-framework`](https://github.com/dic-iit/bipedal-locomotion-framework) and its dependencies. |  [`bipedal-locomotion-framework`](https://github.com/dic-iit/bipedal-locomotion-framework), [`manif`](https://github.com/artivis/manif), [`qhull`](https://github.com/qhull/qhull), [`casadi`](https://github.com/casadi/casadi). [`CppAD`](https://github.com/coin-or/CppAD). [`robot-log-visualizer`](https://github.com/ami-iit/robot-log-visualizer) if `ROBOTOLOGY_USES_PYTHON` option is enabled. | `OFF` | [Documentation on Dynamics full deps profile.](#dynamics-full-deps)  |
| `ROBOTOLOGY_ENABLE_ICUB_HEAD` | The robotology software packages needed on the system that is running on the head of the iCub robot, or in general to communicate directly with iCub low-level devices. | [`icub-firmware`](https://github.com/robotology/icub-firmware), [`icub-firmware-shared`](https://github.com/robotology/icub-firmware-shared), [`diagnostic-daemon`](https://github.com/robotology/diagnostic-daemon). Furthermore, several additional devices are compiled in `YARP` and `ICUB` if this option is enabled. | `OFF` | [Documentation on iCub Head profile.](#icub-head)  |
| `ROBOTOLOGY_ENABLE_ICUB_BASIC_DEMOS` | The robotology software packages needed to run basic demonstrations with the iCub robot. | [`icub-basic-demos`](https://github.com/robotology/icub-basic-demos), [`speech`](https://github.com/robotology/speech),  [`funny-things`](https://github.com/robotology/funny-things). | `OFF` | [Documentation on iCub Basic Demos profile.](#icub-basic-demos)  |
| `ROBOTOLOGY_ENABLE_TELEOPERATION` | The robotology software packages related to teleoperation. | [`walking-teleoperation`](https://github.com/robotology/walking-teleoperation), [`https://github.com/ami-iit/yarp-openvr-trackers`](https://github.com/ami-iit/yarp-openvr-trackers) and [`https://github.com/ami-iit/yarp-device-openxrheadset`](https://github.com/ami-iit/yarp-device-openxrheadset). To use Oculus or Cyberith Omnidirectional Treadmill enable `ROBOTOLOGY_USES_OCULUS_SDK` and `ROBOTOLOGY_USES_CYBERITH_SDK` options. | `OFF` | [Documentation on teleoperation profile.](#teleoperation)  |
| `ROBOTOLOGY_ENABLE_HUMAN_DYNAMICS` | The robotology software packages related to human dynamics estimation. | [`human-dynamics-estimation`](https://github.com/robotology/human-dynamics-estimation), [`wearables`](https://github.com/robotology/wearables), [`yarp-devices-forcetorque`](https://github.com/robotology/yarp-devices-forcetorque). For options check the profile documentation. | `OFF` | [Documentation on human dynamics profile.](#human-dynamics)  |
| `ROBOTOLOGY_ENABLE_EVENT_DRIVEN` | The robotology software packages related to event-driven. | [`event-driven`](https://github.com/robotology/event-driven) | `OFF` | [Documentation on event-driven profile.](#event-driven)  |

If any of the packages required by the selected profiles is already available in the system (i.e. it can be found by the [`find_package` CMake command](https://cmake.org/cmake/help/v3.5/command/find_package.html) ), it will be neither downloaded, nor compiled, nor installed. In `robotology-superbuild`, this check is done by the [`find_or_build_package` YCM command](http://robotology.github.io/ycm/gh-pages/git-master/module/FindOrBuildPackage.html) in the main [`CMakeLists.txt`](https://github.com/robotology/robotology-superbuild/blob/db0f68300439ccced8497db4c321cd63416cf1c0/CMakeLists.txt#L108) of the superbuild.

By default, the superbuild will use the package already available in the system. If the user wants to ignore those packages and have two different versions of them, then he/she should set the CMake variable `USE_SYSTEM_<PACKAGE>` to `FALSE.` For further details, please refer to [YCM Superbuild Manual for Developers](http://robotology.github.io/ycm/gh-pages/git-master/manual/ycm-superbuild.7.html#ycm-superbuild-manual-for-developers).

## Dependencies CMake options
The dependencies CMake options specify if the packages dependending on something installed in the system should be installed or not. All these options are named `ROBOTOLOGY_USES_<dependency>`.

| CMake Option | Description | Default Value | Dependency-specific documentation |
|:------------:|:-----------:|:-------------:|:---------------------------------:|
| `ROBOTOLOGY_USES_GAZEBO`  | Include software and plugins that depend on the [Gazebo Classic simulator](http://gazebosim.org/).  | `ON` on Linux and macOS, `OFF` on Windows   | [Documentation on Gazebo Classic dependency.](#gazebo) |
| `ROBOTOLOGY_USES_IGNITION` | Include software that depends on [Ignition](ignitionrobotics.org/). | `OFF` | [Documentation on Ignition Gazebo dependency.](#ignition) |
| `ROBOTOLOGY_USES_MATLAB`  | Include software and plugins that depend on the [Matlab](https://mathworks.com/products/matlab.html). | `OFF` | [Documentation on MATLAB dependency.](#matlab) |
| `ROBOTOLOGY_USES_OCTAVE`  | Include software and plugins that depend on [Octave](https://www.gnu.org/software/octave/).  | `OFF` |  [Documentation on Octave dependency.](#octave) |
| `ROBOTOLOGY_USES_PYTHON`  | Include software that depends on [Python](https://www.python.org/).  | `OFF` |  [Documentation on Python dependency.](#python) |
| `ROBOTOLOGY_USES_OCULUS_SDK`  | Include software and plugins that depend on [Oculus](https://www.oculus.com/).  | `OFF` |  [Documentation on Oculus dependency.](#oculus) |
| `ROBOTOLOGY_USES_CYBERITH_SDK`  | Include software and plugins that depend on [Cyberith](https://www.cyberith.com/).  | `OFF` |  [Documentation on Cyberith dependency.](#cyberith) |
| `ROBOTOLOGY_USES_CFW2CAN`  | Include software and plugins that depend on [CFW2 CAN custom board](http://wiki.icub.org/wiki/CFW_card).  | `OFF` | No specific documentation is available for this  option, as it is just used with the [iCub Head profile](#icub-head), in which the related documentation can be found.  |
| `ROBOTOLOGY_USES_XSENS_MVN_SDK`  | Include software and plugins that depend on [Xsens MVN SDK](https://www.xsens.com/products/).  | `OFF` | [Documentation on Xsens MVN dependency](#xsens)  |
| `ROBOTOLOGY_USES_ESDCAN`  | Include software and plugins that depend on [Esd Can bus](http://wiki.icub.org/wiki/Esd_Can_Bus).  | `OFF` | [Documentation on ESDCAN dependency](#esdcan)  |

## Platform Support Table

Not all options are supported on all platforms. The following table provides a recap of which options are supported on each platform.

| Option | Ubuntu/Debian, dependencies: apt |  macOS, dependencies: Homebrew | Windows, dependencies: vcpkg | conda on Linux, dependencies: conda-forge |  conda on macOS, dependencies: conda-forge | conda on Windows, dependencies: conda-forge |
|:------:|:---------------------------------:|:----------------------------:|:-----------------------------:|:--------------------------------:|:-----------------------------:|:--------------------------------:|
| `ROBOTOLOGY_ENABLE_CORE` |  ✔️           |        ✔️                     |             ✔️                |                 ✔️              |              ✔️                |                 ✔️              |
| `ROBOTOLOGY_ENABLE_ROBOT_TESTING`<sup id="a2">[2!](#f2)</sup>  | ✔️   |        ✔️                     |             ✔️                |                 ✔️              |              ✔️                |                 ✔️              |
| `ROBOTOLOGY_ENABLE_DYNAMICS`  | ✔️   |        ✔️                     |             ✔️                |                 ✔️              |              ✔️                |                 ✔️              |
| `ROBOTOLOGY_ENABLE_DYNAMICS_FULL_DEPS`<sup id="a1">[1!](#f1)</sup>  | ✔️   |        ✔️                     |             ✔️                |                 ✔️              |              ✔️                |                 ✔️              |
| `ROBOTOLOGY_ENABLE_ICUB_HEAD`  | ✔️   |        ✔️                     |             ✔️                |                 ✔️              |              ✔️                |                 ✔️              |
| `ROBOTOLOGY_ENABLE_ICUB_BASIC_DEMOS`  | ✔️   |        ✔️                     |             ✔️                |                 ✔️              |              ✔️                |                 ✔️              |
| `ROBOTOLOGY_ENABLE_TELEOPERATION`<sup id="a4">[4!](#f4)</sup>  | ✔️   |        ❌                     |             ❌                |                 ✔️              |              ❌                |                 ✔️              |
| `ROBOTOLOGY_ENABLE_HUMAN_DYNAMICS`  | ✔️   |        ✔️                     |             ✔️                |                 ✔️              |              ✔️                |                 ✔️              |
| `ROBOTOLOGY_ENABLE_EVENT_DRIVEN`  | ✔️   |        ✔️                     |             ❌                |                 ✔️              |              ✔️                |                 ❌              |
| `ROBOTOLOGY_USES_GAZEBO` |  ✔️           |        ❌                     |             ✔️                |                 ✔️              |              ✔️                |                 ✔️              |
| `ROBOTOLOGY_USES_IGNITION` |  ❌           |        ❌                     |             ❌                |                 ✔️              |              ❌                |                 ❌              |
| `ROBOTOLOGY_USES_MATLAB` |  ✔️           |        ✔️                     |             ❌                |                 ✔️              |              ✔️                |                 ✔️              |
| `ROBOTOLOGY_USES_OCTAVE` |  ✔️           |        ✔️                     |              ❌                |                  ❌              |               ❌                |                  ❌              |
| `ROBOTOLOGY_USES_PYTHON`<sup id="a3">[3!](#f3)</sup> |  ✔️           |         ❌                     |              ❌                |                  ✔️              |               ✔️               |                  ✔️              |
| `ROBOTOLOGY_USES_OCULUS_SDK` |   ❌          |         ❌                     |             ✔️                |                  ❌              |               ❌                |                  ❌            |
| `ROBOTOLOGY_USES_CYBERITH_SDK` |   ❌           |         ❌                     |            ✔️                  |                  ❌              |               ❌                |                 ✔️              |
| `ROBOTOLOGY_USES_CFW2CAN` |  ✔️           |        ❌                      |             ❌                 |                 ✔️              |              ❌                 |                 ❌               |
| `ROBOTOLOGY_USES_XSENS_MVN_SDK` |  ❌            |        ❌                      |             ✔️                |                 ❌               |              ❌                 |                 ❌               |
| `ROBOTOLOGY_USES_ESDCAN` |  ❌           |        ❌                      |             ✔️                |                 ❌               |              ❌                 |                 ✔️               |

<b id="f1">1!</b>:Since 2021.05, `ROBOTOLOGY_ENABLE_DYNAMICS_FULL_DEPS` does not support building with apt dependencies on Ubuntu 18.04 .

<b id="f2">2!</b>:Since 2021.11, `ROBOTOLOGY_ENABLE_ROBOT_TESTING` does not support building with apt dependencies on Ubuntu 18.04 .

<b id="f3">3!</b>:Since 2021.11, `ROBOTOLOGY_USES_PYTHON` does not support building with apt dependencies on Ubuntu 18.04 .

<b id="f4">4!</b>:Since 2022.05, `ROBOTOLOGY_USES_TELEOPERATION` does not support building with apt dependencies on Ubuntu 18.04 and Debian Buster .


Profile-specific documentation
===================================

## Core
This profile is enabled by the `ROBOTOLOGY_ENABLE_CORE` CMake option.

### System Dependencies
The steps necessary to install the system dependencies of the Core profile are provided in
[operating system-specific installation documentation](../README.md#linux-from-source-with-dependencies-provided-by-apt).

### Check the installation
Follow the steps in http://wiki.icub.org/wiki/Check_your_installation to verify if your installation was successful.

## Robot Testing
This profile is enabled by the `ROBOTOLOGY_ENABLE_ROBOT_TESTING` CMake option.

On Windows, this profile creates some long paths during the build process. If you enable it, it is recommended  to
keep the total path length of the robotology-superbuild build directory below 50 characters, or to enable the support for
long path in Windows following the instructions in the [official Windows documentation](https://docs.microsoft.com/en-us/windows/win32/fileio/maximum-file-path-limitation#enable-long-paths-in-windows-10-version-1607-and-later).

### System Dependencies
The steps necessary to install the system dependencies of the Robot Testing profile are provided in
[operating system-specific installation documentation](../README.md#linux-from-source-with-dependencies-provided-by-apt), and no additional required system dependency is required.

### Check the installation
If the profile has been correctly enabled and compiled, you should be able to run the `robottestingframework-testrunner` and `blocktestrunner` executable from the command line.


## Dynamics
This profile is enabled by the `ROBOTOLOGY_ENABLE_DYNAMICS` CMake option.

### System Dependencies
The steps necessary to install the system dependencies of the Dynamics profile are provided in
[operating system-specific installation documentation](../README.md#linux-from-source-with-dependencies-provided-by-apt), and no additional required system dependency is required.

## Dynamics full deps
This profile is enabled by the `ROBOTOLOGY_ENABLE_DYNAMICS_FULL_DEPS` CMake option.

### System Dependencies
The steps necessary to install the system dependencies of the Dynamics full deps profile are provided in
[operating system-specific installation documentation](../README.md#linux-from-source-with-dependencies-provided-by-apt), and no additional required system dependency is required.

**Since 2021.05, `ROBOTOLOGY_ENABLE_DYNAMICS_FULL_DEPS` is not supported with apt dependencies on Ubuntu 18.04.**

## iCub Head

This profile is enabled by the `ROBOTOLOGY_ENABLE_ICUB_HEAD` CMake option. It is used in the system installed on iCub head,
or if you are a developer that needs to access iCub hardware devices directly without passing through the iCub head.

**Warning: the migration of existing iCub setups to use the robotology-superbuild is an ongoing process, and it is possible
that your iCub still needs to be migrated. For any doubt, please get in contact with [icub-support](https://github.com/robotology/icub-support).**

The configuration and compilation of this profile is supported on Linux, macOS and Windows systems.

On Linux all the software necessary to communicate with boards contained in the robot, including CAN devices via [esd's CAN USB bridges](https://esd.eu/en/products/can-usb2), is already included.

On Windows to communicate with CAN devices via [esd's CAN USB bridges](https://esd.eu/en/products/can-usb2) you need to set to ON the Windows-only CMake option [`ROBOTOLOGY_ENABLE_ESDCAN`](#esdcan).

On macOS, communication with [esd's CAN USB bridges](https://esd.eu/en/products/can-usb2) is not supported and `diagnosticdaemon` is not available because of https://github.com/robotology/robotology-superbuild/issues/439.

This section documents the iCub Head profile as any other profile, in a way agnostic of the specific machine in which it is installed. To get information on how to use the robotology-superbuild to install software on the machine mounted in the head of physical iCub robots, please check the documentation in [the official iCub documentation](https://icub-tech-iit.github.io/documentation/sw_installation/icub_head_superbuild/).

### System Dependencies
The steps necessary to install the system dependencies of the iCub Head profile are provided in
[operating system-specific installation documentation](../README.md#linux-from-source-with-dependencies-provided-by-apt), and no additional required system dependency is required.

On old iCub systems equipped with the [CFW2 CAN board](http://wiki.icub.org/wiki/CFW_card), it may be necessary to have the cfw2can driver
installed on the iCub head (it is tipically already pre-installed in the OS image installed in the system in the iCub head). In that
case, you also need to enable the `ROBOTOLOGY_USES_CFW2CAN` option to compile the software that depends on cfw2can. In case of doubt,
please always get in contact with [icub-support](https://github.com/robotology/icub-support).

### Check the installation
The `ROBOTOLOGY_ENABLE_ICUB_HEAD` installs several YARP devices for communicating directly with embedded boards of the iCub.
To check if the installation was correct, you can list all the available YARP devices using the `yarpdev --list` command,
and check if devices whose name is starting with `embObj` are present in the list. If those devices are present, then the installation
should be working correctly. Furthermore, if the profile has been correctly enabled and compiled, you should be able to run the `diagnosticdaemon` executable from the command line.


## iCub Basic Demos

This profile is enabled by the `ROBOTOLOGY_ENABLE_ICUB_BASIC_DEMOS` CMake option.

### System Dependencies
The steps necessary to install the system dependencies of the iCub Basic Demos profile are provided in
[operating system-specific installation documentation](../README.md#linux-from-source-with-dependencies-provided-by-apt), and no additional required system dependency is required.

### Check the installation
If the iCub Basic Demos profile have been correctly installed, you should be able to find in your PATH and execute the `demoYoga` or `demoRedBall` executables.

## Teleoperation
This profile is enabled by the `ROBOTOLOGY_ENABLE_TELEOPERATION` CMake option.

### System Dependencies
To run a teleoperation scenario, with real robot or in simulation, at least we need a Windows machine and Linux/macOS machine. If you are using iCub, the linux/macOS source code can be placed on the robot head. The teleoperation dependencies are also related to the teleoperation scenario you want to perform.

#### Teleoperation without Cyberith treadmill
In this scenario, we only use [Oculus](#oculus) for teleoperation, and we do not use Cyberith treadmill. In this case, the user can give the command for robot walking through the Oculus joypads. The dependencies for this scenario are as following:
* Windows: [Oculus](#oculus).
* Linux/macOS: [walking controller](https://github.com/robotology/walking-controllers).

#### Teleoperation with Cyberith treadmill
In this scenario, we use both [Oculus](#oculus) and [cyberith treadmill](#cyberith) for teleopration. In this case, the user can give the command for robot walking through walking on cyberith treadmill. The dependencies for this scenario are as follwoing:
* Windows: [Oculus](#oculus), [Cyberith](#cyberith).
* Linux/macOS: [walking controller](https://github.com/robotology/walking-controllers).

## Human Dynamics
This profile is enabled by the `ROBOTOLOGY_ENABLE_HUMAN_DYNAMICS` CMake option.

### System Dependencies
To run a human dynamics estimation scenario, we need a Windows machine to install the Xsens suit SDK for getting the sensory information of the human motions from [Xsens](https://www.xsens.com/) and [ESD USB CAN driver](https://esd.eu/en/products/can-usb2) to get the FTShoes/FTSkShoes sensory information. Refer to [Xsens](#xsens) and [ESDCAN](#esdcan) for more information about the dependencies.

## Event-driven
This profile is enabled by the `ROBOTOLOGY_ENABLE_EVENT_DRIVEN` CMake option. For the moment, Windows is not a supported platform.

### System Dependencies
The steps necessary to install the system dependencies of the Event-driven profile are provided in
[operating system-specific installation documentation](../README.md#linux-from-source-with-dependencies-provided-by-apt).

Dependencies-specific documentation
===================================

## Gazebo

Support for this dependency is enabled by the `ROBOTOLOGY_USES_GAZEBO` CMake option, that enables the software that depends on "Classic Gazebo".

### System Dependencies

#### Linux with apt
On Linux with apt dependencies install Gazebo, if you are on:
* Ubuntu 20.04
* Buster 10

follow the instructions available at https://gazebosim.org/tutorials?tut=install_ubuntu . Make sure to install also the development files, i.e. `libgazebo*-dev` on Debian/Ubuntu.

Otherwise, if you are on other supported Debian/Ubuntu systems, just install the system provided gazebo package with:
~~~~
sudo apt install libgazebo-dev
~~~~

#### Linux/macOS/Windows with conda
If you install your dependencies with `conda`, just make sure to install the `gazebo` package.

#### Windows with vcpkg
On Windows with vcpkg dependencies, make sure that you install the Windows dependencies using the `vcpkg-robotology-with-gazebo.zip` archive and you set
the correct enviroment variables as documented in [`robotology-superbuild-dependencies-vcpkg` documentation](https://github.com/robotology/robotology-superbuild-dependencies-vcpkg).

#### macOS with Homebrew
This option is not supported when using Homebrew to install your dependencies.

### Check the installation
Follow the steps in  https://github.com/robotology/icub-models#use-the-models-with-gazebo to check if the Gazebo-based iCub simulation works fine.

## Ignition
Support for this dependency is enabled by the `ROBOTOLOGY_USES_IGNITION` CMake option.
This option is set to `OFF` on all platforms as it is still experimental.

### System Dependencies

Different Ignition distributions can be installed alongside.
The projects included in the superbuild might require different distributions.
From the superbuild point of view, we currently do not allow enabling projects that only support a specific Ignition distribution, therefore all required distributions have to be found in the system.

#### Using conda

Follow [the source installation with conda-forge provided dependencies](https://github.com/robotology/robotology-superbuild/blob/master/doc/conda-forge.md#source-installation) and, after creating and environment and installing the default dependencies, execute:

```bash
conda install -c conda-forge libignition-gazebo6
```

#### Using official instructions

Follow the official instructions to install Ignition on your platform, available at https://ignitionrobotics.org/docs.

Note: this installation method is not currently tested in Continuous Integration.

## MATLAB
Support for this dependency is enabled by the `ROBOTOLOGY_USES_MATLAB` CMake option.

**Warning: differently from other optional dependencies, MATLAB is a commercial product that requires a license to be used.**

### System Dependencies
If MATLAB is not installed on your computer, install it following the instruction in https://mathworks.com/help/install/ .
Once you installed it, make sure that the directory containing the `matlab` executable is present in the `PATH` of your system,
as [CMake's FindMatlab module](https://cmake.org/cmake/help/v3.5/module/FindMatlab.html) relies on this to find MATLAB.

**Note: tipically we assume that a user that selects the `ROBOTOLOGY_USES_MATLAB` also has Simulink installed in his computer.
If this is not the case, you can enable the advanced CMake option `ROBOTOLOGY_NOT_USE_SIMULINK` to compile all the subprojects that depend on MATLAB, but disable the subprojecs that depend on Simulink (i.e. the
[wb-toolbox](https://github.com/robotology/wb-toolbox) Simulink Library) if you have enabled the `ROBOTOLOGY_ENABLE_DYNAMICS` CMake options.**

### Configuration
If [MATLAB](mathworks.com/products/matlab/) is installed on your computer, the robotology-superbuild
can install some projects that depend on MATLAB, among the others:
 * the MATLAB bindings of the [iDynTree](https://github.com/robotology/idyntree) library,
 * the native MATLAB bindings of YARP, contained in the [yarp-matlab-bindings](https://github.com/robotology-playground/yarp-matlab-bindings/) repository,
 * The [WB-Toolbox](https://github.com/robotology/WB-Toolbox) Simulink toolbox,
 * The [whole-body-controllers](https://github.com/robotology/whole-body-controllers) Simulink-based balancing controllers. Note that whole-body-controllers can be installed and compiled also without MATLAB, but its functionalities are reduced.
 * The [matlab-whole-body-simulator](https://github.com/dic-iit/matlab-whole-body-simulator) Simulink-based whole-body dynamics simulator with contacts handling.

To use this software, you can simply enable its compilation using the `ROBOTOLOGY_USES_MATLAB` CMake option.
Once this software has been compiled by the superbuild, you just need to add some directories of the robotology-superbuild install (typically `$ROBOTOLOGY_SUPERBUILD_SOURCE_DIR/build/install`) to [the MATLAB path](https://www.mathworks.com/help/matlab/matlab_env/what-is-the-matlab-search-path.html).
In particular you need to add to the MATLAB path:
 * the `$ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX/mex` directory,
 * the `$ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX/share/WBToolbox` directory and all its subdirectories (except the packages which are folder names starting with "+"),
 * the library `$ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX/mex/+wbc/simulink`,
 * the controller model examples `$ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX/mex/+wbc/examples`.

#### Start MATLAB from the launcher or the application menu

You could add this line to your MATLAB script that uses the robotology-superbuild matlab software, substituting `<ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX>` with the `install` folder inside the build directory of the superbuild:

~~~
    addpath(['<ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX>' '/mex'])
    addpath(['<ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX>' '/mex/+wbc/simulink'])
    addpath(['<ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX>' '/mex/+wbc/examples'])
    addpath(['<ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX>' '/share/WBToolbox'])
    addpath(['<ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX>' '/share/WBToolbox/images'])
~~~

Another way is to run (only once) the script `startup_robotology_superbuild.m` in the `$ROBOTOLOGY_SUPERBUILD_SOURCE_DIR/build` folder. This should be enough to permanently add the required paths for all the toolbox that use MATLAB.

#### Start MATLAB from the terminal

You can add the folders by modifying the `startup.m` or the `MATLABPATH` environmental variable [as described in official MATLAB documentation](https://www.mathworks.com/help/matlab/matlab_env/add-folders-to-matlab-search-path-at-startup.html).
If you are using the `setup.sh` or `setup.bat` script for configuring your environment, `MATLABPATH` is automatically populated with these directories.

For more info on configuring MATLAB software with the robotology-superbuild, please check the [wb-toolbox README](https://github.com/robotology/wb-toolbox).

### Check the installation
To verify that the compilation of `ROBOTOLOGY_USES_MATLAB` option was successful, try to run a script that uses
the Matlab bindings of `yarp` and see if it executes without any error, for example:
~~~matlab
yarpVec = yarp.Vector();
yarpVec.resize(3);
yarpVec.fromMatlab([1;2;3]);
yarpVec.toMatlab()
~~~~
This scripts should print a `1 2 3` vector, but only if the `yarp` bindings are working correctly.


## Octave
Support for this dependency is enabled by the `ROBOTOLOGY_USES_OCTAVE` CMake option.

### System Dependencies

#### Linux
Install octave and the necessary development files using the following command:
~~~
sudo apt-get install liboctave-dev
~~~

#### macOS
Install octave using the following command:
~~~
brew install octave
~~~

#### Windows
The `ROBOTOLOGY_USES_OCTAVE` option is not supported on Windows, see https://github.com/robotology/robotology-superbuild/issues/139 for more info.

### Configuration
Add the `$ROBOTOLOGY_SUPERBUILD_SOURCE_DIR/build/install/octave` directory to your [Octave path](https://www.gnu.org/software/octave/doc/interpreter/Manipulating-the-Load-Path.html).

### Check the installation
To verify that the compilation of `ROBOTOLOGY_USES_OCTAVE` option was successful, try to run a script that uses
the Octave bindings of `yarp` and see if it executes without any error, for example:
~~~matlab
yarpVec = yarp.Vector();
yarpVec.resize(3);
yarpVec.fromMatlab([1;2;3]);
yarpVec.toMatlab()
~~~~
This scripts should print a `1 2 3` vector, but only if the `yarp` bindings are working correctly.


## Python

Support for this dependency is enabled by the `ROBOTOLOGY_USES_PYTHON` CMake option.

### System Dependencies

#### Ubuntu using apt
Install Python and the necessary development files using the following command:
~~~
cd robotology-superbuild
sudo bash ./scripts/install_apt_python_dependencies.sh
~~~

#### Conda
To install python and the other required dependencies when using `conda-forge` provided dependencies, use:
~~~
mamba install -c conda-forge python numpy swig pybind11 pyqt matplotlib h5py tornado u-msgpack-python pyzmq ipython
~~~

### Check the installation
Open a python interpreter and try to import modules, for example verify that `import yarp` works.

## Oculus
Support for this dependency is enabled by the `ROBOTOLOGY_USES_OCULUS_SDK` CMake option.

**Warning: at the moment the Oculus SDK does not support macOS and Linux, so this option is only supported
on Windows.**

### System Dependencies
To check and install the Oculus SDK please follow the steps for Oculus SDK mentioned [here](https://github.com/robotology/walking-teleoperation/blob/master/docs/Dependencies.md).

### Configuration
To configure the Oculus SDK follow the steps for Oculus SDK mentioned [here](https://github.com/robotology/walking-teleoperation/blob/master/docs/Dependencies.md).

## Cyberith
Support for this dependency is enabled by the `ROBOTOLOGY_USES_CYBERITH_SDK` CMake option.

**Warning: at the moment the Cyberith SDK does not support macOS and Linux, so this option is only supported on Windows.**

### System Dependencies
To check and install the Cyberith SDK, please follow the steps for Cyberith SDK mentioned in [here](https://github.com/robotology/walking-teleoperation/blob/master/docs/Dependencies.md).

### Configuration
To configure the Cyberith SDK please follow the steps for Cyberith SDK mentioned in [here](https://github.com/robotology/walking-teleoperation/blob/master/docs/Dependencies.md).

## Xsens
Support for `ROBOTOLOGY_USES_XSENS_MVN_SDK` option is only enabled when the `ROBOTOLOGY_ENABLE_HUMAN_DYNAMICS` CMake option is set to ON.

**Warning: at the moment the Xsens MVN SDK does not support macOS and Linux, so this option is only supported
on Windows.**

### System Dependencies
To check and install the Xsens MVN SDK, please follow the steps for Xsens MVN SDK mentioned in [here](https://github.com/robotology/human-dynamics-estimation/wiki/Set-up-Machine-for-running-HDE#xsens-only-for-windows).

### Configuration
To configure the Xsens MVN SDK please follow the steps for Xsens MVN SDK mentioned in [here](https://github.com/robotology/human-dynamics-estimation/wiki/Set-up-Machine-for-running-HDE#xsens-only-for-windows).

## ESDCAN
The `ROBOTOLOGY_USES_ESDCAN` option is used to enable support for interacting with [esd CAN devices](https://esd.eu/en/products/can-usb2) on Windows. On Linux no special option is necessary, as the interconnection with esd CAN device is supported  using the default [SocketCAN](https://www.kernel.org/doc/Documentation/networking/can.txt) Linux driver. Use of [esd CAN devices](https://esd.eu/en/products/can-usb2) is not supported in macOS .

### System Dependencies
To compile the software enabled by the `ROBOTOLOGY_USES_ESDCAN` option (such as the `icub-main`'s [`ecan`](http://www.icub.org/software_documentation/classyarp_1_1dev_1_1EsdCan.html) YARP driver) you need to install the esd CAN C library.
To install this library in conda, just run `mamba install -c conda-forge -c robotology esdcan` inside your conda environment. If you installed `icub-main` from conda binary packages, the `ecan` YARP driver enabled by the `ROBOTOLOGY_USES_ESDCAN` option is already included.

To actually run the software that uses the esd CAN devices, you also need to install the esd CAN Driver for your specific esd CAN device.
The installers for the esd CAN Driver should have been provided by esd, so ask for them to who provided you with the esd CAN device you want to use.

### Configuration
No additional configuration is required to use the software installed by the  `ROBOTOLOGY_USES_ESDCAN`

### Check the installation
Open a terminal, and check that amoung the device listed by `yarpdev --list` the `ecan` YARP device is listed.
