# robotology-superbuild

This is a meta repository (so-called "superbuild") that uses [CMake](https://cmake.org/) and [YCM](https://github.com/robotology/ycm) to automatically
download and compile software developed in the robotology GitHub organization, such as the YARP middleware or software used to run the iCub humanoid robot.

[CMake](https://cmake.org/) is an open-source, cross-platform family of tools designed to build, test and package software.
A [YCM Superbuild](http://robotology.github.io/ycm/gh-pages/git-master/index.html#superbuild) is a CMake project whose only goal is to download and build several other projects.
If you are familiar with ROS, it is something similar to [catkin](http://wiki.ros.org/catkin/workspaces) or [colcon workspace](https://colcon.readthedocs.io/en/released/user/quick-start.html), but using pure CMake for portability reasons and for customizing the build via CMake options. 
You can read more about the superbuild concept in [YCM documentation](http://robotology.github.io/ycm/gh-pages/latest/index.html) or in the [related IRC paper](http://lornat75.github.io/papers/2018/domenichelli-irc.pdf).

| System  | Continuous Integration Status |
|:------:|:------:|
|  Linux/macOS/Windows  |  ![GitHub Actions Status](https://github.com/robotology/robotology-superbuild/workflows/C++%20CI%20Workflow/badge.svg)     |

Table of Contents
=================
  * [Superbuild structure](#superbuild-structure)
    * [Profile CMake options](#profile-cmake-options)
    * [Dependencies CMake options](#dependencies-cmake-options)
  * [Installation](#installation)
    * [Linux](#linux)
    * [macOS](#macos)
    * [Windows](#windows)
    * [Windows Subsystem For Linux](#windows-subsystem-for-linux)
  * [Update](#update)
  * [Profile-specific documentation](#profile-specific-documentation)
    * [Core profile](#core)
    * [Robot Testing profile](#robot-testing)
    * [Dynamics profile](#dynamics)
    * [iCub Head profile](#icub-head)
    * [Teleoperation profile](#teleoperation)
    * [Human Dynamics profile](#human-dynamics)
  * [Dependencies-specific documentation](#dependencies-specific-documentation)
    * [Gazebo simulator](#gazebo)
    * [MATLAB](#matlab)
    * [Octave](#octave)
    * [Python](#python)
    * [Oculus](#oculus)
    * [Cyberith](#cyberith)
    * [Xsens](#xsens)
    * [FTShoes/FTSkShoes](#shoes)
  * [FAQs](#faqs)
  * [Mantainers](#mantainers)

Superbuild structure
====================

`robotology-superbuild` will download and build a number of software.
For each project, the repository will be downloaded in the `robotology/<package_name>` subdirectory
of the superbuild root. The build directory for a given project will be instead the `robotology/<package_name>` subdirectory
of the superbuild build directory. All the software packages are installed using the `install` directory of the build as installation prefix.
If there is any non-robotology dependency handled by the superbuild as it is not easily in the system, it will located in the `external` directory instead of the `robotology` one.


## Superbuild CMake options
As a huge number of software projects are developed in the `robotology` organization,
and a tipical user is only interested in some of them, there are several options to
instruct  the superbuild on which packages should be built and which one should not be built.

### Profile CMake options
The profile CMake options specify which subset of the robotology packages will be built by the superbuild.
Note that any dependencies of the included packages that is not available in the system will be downloaded, compiled and installed as well. All these options are named `ROBOTOLOGY_ENABLE_<profile>` .

| CMake Option | Description | Main packages included | Default Value | Profile-specific documentation |
|:------------:|:-----------:|:---------------------:|:-------------:|:----:|
| `ROBOTOLOGY_ENABLE_CORE` | The core robotology software packages, necessary for most users. | [`YARP`](https://github.com/robotology/yarp), [`ICUB`](https://github.com/robotology/icub-main), [`ICUBcontrib`](https://github.com/robotology/icub-contrib-common), [`icub-models`](https://github.com/robotology/icub-models) and  [`robots-configurations`](https://github.com/robotology/robots-configuration). [`GazeboYARPPlugins`](https://github.com/robotology/GazeboYARPPlugins) and [`icub-gazebo`](https://github.com/robotology/icub-gazebo) if the `ROBOTOLOGY_USES_GAZEBO` option is enabled. | `ON` | [Documentation on Core profile.](#core) |
| `ROBOTOLOGY_ENABLE_ROBOT_TESTING` | The robotology software packages related to robot testing. |  [`RobotTestingFramework`](https://github.com/robotology/robot-testing-framework) and [`icub-tests`](https://github.com/robotology/icub-tests)| `OFF` | [Documentation on Robot Testing profile.](#robot-testing)  |
| `ROBOTOLOGY_ENABLE_DYNAMICS` | The robotology software packages related to balancing, walking and force control. | [`iDynTree`](https://github.com/robotology/idyntree), [`blockfactory`](https://github.com/robotology/blockfactory), [`wb-Toolbox`](https://github.com/robotology/wb-Toolbox), [`whole-body-controllers`](https://github.com/robotology/whole-body-controllers), [`walking-controllers`](https://github.com/robotology/walking-controllers). [`icub-gazebo-wholebody`](https://github.com/robotology-playground/icub-gazebo-wholebody) if the `ROBOTOLOGY_USES_GAZEBO` option is enabled. | `OFF` | [Documentation on Dynamics profile.](#dynamics)  |
| `ROBOTOLOGY_ENABLE_ICUB_HEAD` | The robotology software packages needed on the system that is running on the head of the iCub robot, or in general to communicate directly with iCub low-level devices. | [`icub-firmware`](https://github.com/robotology/icub-firmware), [`icub-firmware-shared`](https://github.com/robotology/icub-firmware-shared). Furthermore, several additional devices are compiled in `YARP` and `ICUB` if this option is enabled. | `OFF` | [Documentation on iCub Head profile.](#icub-head)  |
| `ROBOTOLOGY_ENABLE_TELEOPERATION` | The robotology software packages related to teleoperation. | [`walking-teleoperation`](https://github.com/robotology/walking-teleoperation). To use Oculus or Cyberith Omnidirectional Treadmill enable `ROBOTOLOGY_USES_OCULUS_SDK` and `ROBOTOLOGY_USES_CYBERITH_SDK` options. | `OFF` | [Documentation on teleoperation profile.](#teleoperation)  |
| `ROBOTOLOGY_ENABLE_HUMAN_DYNAMICS` | The robotology software packages related to human dynamics estimation. | [`human-dynamics-estimation`](https://github.com/robotology/human-dynamics-estimation), [`wearables`](https://github.com/robotology/wearables), [`forcetorque-yarp-devices`](https://github.com/robotology/forcetorque-yarp-devices). For options check the profile documentation. | `OFF` | [Documentation on human dynamics profile.](#human-dynamics)  |

If any of the packages required by the selected profiles is already available in the system (i.e. it can be found by the [`find_package` CMake command](https://cmake.org/cmake/help/v3.5/command/find_package.html) ), it will be neither downloaded, nor compiled, nor installed. In `robotology-superbuild`, this check is done by the [`find_or_build_package` YCM command](http://robotology.github.io/ycm/gh-pages/git-master/module/FindOrBuildPackage.html) in the main [`CMakeLists.txt`](https://github.com/robotology/robotology-superbuild/blob/db0f68300439ccced8497db4c321cd63416cf1c0/CMakeLists.txt#L108) of the superbuild. 

By default, the superbuild will use the package already available in the system. If the user wants to ignore those packages and have two different versions of them, then he/she should set the CMake variable `USE_SYSTEM_<PACKAGE>` to `FALSE.` For further details, please refer to [YCM Superbuild Manual for Developers](http://robotology.github.io/ycm/gh-pages/git-master/manual/ycm-superbuild.7.html#ycm-superbuild-manual-for-developers).

### Dependencies CMake options
The dependencies CMake options specify if the packages dependending on something installed in the system should be installed or not. All these options are named `ROBOTOLOGY_USES_<dependency>`. 

| CMake Option | Description | Default Value | Dependency-specific documentation |
|:------------:|:-----------:|:-------------:|:---------------------------------:|
| `ROBOTOLOGY_USES_GAZEBO`  | Include software and plugins that depend on the [Gazebo simulator](http://gazebosim.org/).  | `ON` on Linux and macOS, `OFF` on Windows   | [Documentation on Gazebo dependency.](#gazebo) |
| `ROBOTOLOGY_USES_MATLAB`  | Include software and plugins that depend on the [Matlab](https://mathworks.com/products/matlab.html). | `OFF` | [Documentation on MATLAB dependency.](#matlab) |
| `ROBOTOLOGY_USES_OCTAVE`  | Include software and plugins that depend on [Octave](https://www.gnu.org/software/octave/).  | `OFF` |  [Documentation on Octave dependency.](#octave) |
| `ROBOTOLOGY_USES_OCULUS_SDK`  | Include software and plugins that depend on [Oculus](https://www.oculus.com/).  | `OFF` |  [Documentation on Oculus dependency.](#oculus) |
| `ROBOTOLOGY_USES_CYBERITH_SDK`  | Include software and plugins that depend on [Cyberith](https://www.cyberith.com/).  | `OFF` |  [Documentation on Cyberith dependency.](#cyberith) |
| `ROBOTOLOGY_USES_CFW2CAN`  | Include software and plugins that depend on [CFW2 CAN custom board](http://wiki.icub.org/wiki/CFW_card).  | `OFF` | No specific documentation is available for this  option, as it is just used with the [iCub Head profile](#icub-head), in which the related documentation can be found.  |
| `ROBOTOLOGY_USES_ESDCAN`  | Include software and plugins that depend on [Esd Can bus](http://wiki.icub.org/wiki/Esd_Can_Bus).  | `OFF` | [Documentation on FTShoes/FTSkShoes dependency](#shoes)  |
| `ROBOTOLOGY_USES_XSENS_MVN_SDK`  | Include software and plugins that depend on [Xsens MVN SDK](https://www.xsens.com/products/).  | `OFF` | [Documentation on Xsens MVN dependency](#xsens)  |


Installation
============
We provide different instructions on how to install robotology-superbuild, depending on your operating system:
* [**Linux**](#linux): use the superbuild with make,
* [**macOS**](#macOS): use the superbuild with Xcode or GNU make,
* [**Windows**](#windows): use the superbuild with Microsoft Visual Studio,
* [**Windows Subsystem For Linux**](#windows-subsystem-for-linux): use the superbuild with make on [Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl).

The exact versions of the operating systems supported by the robotology-superbuild follow the one supported by the YARP library, that are documented in https://github.com/robotology/yarp/blob/master/.github/CONTRIBUTING.md#supported-systems .
Complete documentation on how to use a YCM-based superbuild is available in the [YCM documentation](http://robotology.github.io/ycm/gh-pages/git-master/manual/ycm-superbuild.7.html).

## Linux
### System Dependencies
On Debian based systems (as Ubuntu) you can install the C++ toolchain, Git, CMake and Eigen (and other dependencies necessary for the software include in `robotology-superbuild`) using `apt-get`:
```
sudo apt-get install libeigen3-dev build-essential cmake cmake-curses-gui coinor-libipopt-dev libboost-system-dev libboost-filesystem-dev libboost-thread-dev libtinyxml-dev libedit-dev libace-dev libgsl0-dev libopencv-dev libode-dev liblua5.1-dev lua5.1 git swig qtbase5-dev qtdeclarative5-dev qtmultimedia5-dev qml-module-qtquick2 qml-module-qtquick-window2 qml-module-qtmultimedia qml-module-qtquick-dialogs qml-module-qtquick-controls qml-module-qt-labs-folderlistmodel qml-module-qt-labs-settings libsdl1.2-dev libxml2-dev libv4l-dev
```

For what regards CMake, the robotology-superbuild requires CMake 3.12 . If you are using a system in which the default version of CMake is older, you can easily install a newer CMake version in several ways. For the following distributions, we recommend the following methods:  
* Ubuntu 18.04 : use the latest CMake release in the [Kitware APT repository](https://apt.kitware.com/). You can find the full instructions for the installation on the website.
* Debian 9 : use the CMake 3.13.2 in the `stretch-backports` repository, following the instructions to install from backports available in  [Debian documentation](https://backports.debian.org/Instructions/).
More details can be found at https://github.com/robotology/QA/issues/364 .

If you enabled any [profile](#profile-cmake-options) or [dependency](#dependencies-cmake-options) specific CMake option you may need to install additional system dependencies, following the dependency-specific documentation (in particular, the `ROBOTOLOGY_USES_GAZEBO` option is enabled by default, so you should install Gazebo unless you plan to disable this option):
* [`ROBOTOLOGY_USES_GAZEBO`](#gazebo)


### Superbuild
If you didn't already configured your git, you have to set your name and email to sign your commits:
```
git config --global user.name FirstName LastName
git config --global user.email user@email.domain
```
Finally it is possible to install robotology software using the YCM superbuild:
```bash
git clone https://github.com/robotology/robotology-superbuild.git
cd robotology-superbuild
mkdir build
cd build
ccmake ../
make
```
You can configure the ccmake environment if you know you will use some particular set of software (put them in "ON").
See [Superbuild CMake options](#superbuild-cmake-options) for a list of available options.

### Configure your environment
Currently the YCM superbuild does not support building a global install target, so all binaries are installed in `robotology-superbuild/build/install/bin` and all libraries in `robotology-superbuild/build/install/lib`.

To use the binaries and libraries installed by the robotology-superbuild, you should update the enviroment variables of your process such as `PATH` and `CMAKE_PREFIX_PATH`.

The superbuild provides an automatically generated `setup.sh` sh script that will set
all the necessary enviromental variables. To do so automatically for any new terminal that you open, append the following line to the `.bashrc` file:
```
source <directory-where-you-downloaded-robotology-superbuild>/build/install/share/robotology-superbuild/setup.sh
```

To use the updated `.bashrc` in your terminal you should run the following command:
```bash
user@host:~$ source ~/.bashrc
```
If may also be necessary to updates the cache of the dynamic linker:
```bash
user@host:~$ sudo ldconfig
```

If for any reason you do not want to use the provided `setup.sh` script and you want to manage your enviroment variables manually, please refer to the documentation available at [`doc/environment-variables-configuration.md `](doc/environment-variables-configuration.md).

## macOS

### System Dependencies
To install the system dependencies, it is possible to use [Homebrew](http://brew.sh/):
```
brew install ace boost cmake eigen gsl ipopt jpeg libedit opencv@3 pkg-config qt5 sqlite swig tinyxml
```

Since Qt5 is not symlinked in `/usr/local` by default in the homebrew formula, `Qt5_DIR` needs to be properly set to make sure that CMake-based projects are able to find Qt5.
```
export Qt5_DIR=/usr/local/opt/qt5/lib/cmake/Qt5
```

The version of `opencv` required by [YARP is not the latest release](https://github.com/robotology/yarp/issues/1672). In case other versions are installed, it is required to link `opencv3`.
```
brew link --force opencv@3
```
Otherwise, it is possible to not use `opencv` by setting the `YARP_USE_OpenCV` YARP advanced CMake option to  `OFF`. To modify YARP-specific CMake options, you need to go with the terminal to `build/robotology/YARP`, and use the `ccmake` command to edit the YARP CMake options.

If you want to enable a [profile](#profile-cmake-options) or a [dependency](#dependencies-cmake-options) specific CMake option, you may need to install additional system dependencies following the dependency-specific documentation (in particular, the `ROBOTOLOGY_USES_GAZEBO` option is enabled by default, so you should install Gazebo unless you plan to disable this option):
* [`ROBOTOLOGY_USES_GAZEBO`](#gazebo)

### Superbuild
If you didn't already configured your git, you have to set your name and email to sign your commits:
```
git config --global user.name FirstName LastName
git config --global user.email user@email.domain
```
Finally it is possible to install robotology software using the superbuild:
```bash
git clone https://github.com/robotology/robotology-superbuild.git
cd robotology-superbuild
mkdir build
cd build
```
To use GNU Makefile generators:
```bash
cmake ../
make
```
To use Xcode project generators
```bash
cmake ../ -G Xcode
xcodebuild -configuration Release
```

### Configure your environment
Currently the YCM superbuild does not support building a global install target, so all binaries are installed in `robotology-superbuild/build/install/bin` and all libraries in `robotology-superbuild/build/install/lib`.

To use the binaries and libraries installed by the robotology-superbuild, you should update the enviroment variables of your process such as `PATH` and `CMAKE_PREFIX_PATH`.

The superbuild provides an automatically generated `setup.sh` sh script that will set
all the necessary enviromental variables. To do so automatically for any new terminal that you open, append the following line to the `.bash_profile` file:
```
source <directory-where-you-downloaded-robotology-superbuild>/build/install/share/robotology-superbuild/setup.sh
```

To use the updated `.bash_profile` in your terminal you should run the following command:
```bash
user@host:~$ source ~/.bash_profile
```
or simply open a new terminal.

If for any reason you do not want to use the provided `setup.sh` script and you want to manage your enviroment variables manually, please refer to the documentation available at [`doc/environment-variables-configuration.md `](doc/environment-variables-configuration.md).

## Windows
### Disclaimer
While the robotology software is tested to be fully compatible with Windows,
the Gazebo simulator that is widely used for simulation with robotology software [does not support Windows](https://github.com/robotology/gazebo-yarp-plugins/issues/74).

For this reason if you plan to do use the robotology software with the Gazebo simulator on Windows, 
for the time being it is easier for you to use the [Windows Subsystem for Linux](#windows-subsystem-for-linux).

### System Dependencies

As Windows does not have a widely used system [package manager](https://en.wikipedia.org/wiki/Package_manager) such as the one that are available on Linux or macOS, installing the system dependencies is slightly more compliated. However, we try to document every step necessary for the installation, but you find something that you don't understand in the documentation, please [open an issue](https://github.com/robotology/robotology-superbuild/issues/new).  

#### Visual Studio
Most of the robotology software is developed using the C/C++ language. For this reason, you should have [Visual Studio](https://www.visualstudio.com/), the official Microsoft compiler for Windows, installed on your computer to compile the software in the superbuild. Visual Studio 2015, Visual Studio 2017 and Visual Studio 2019 are all supported by the superbuild.
Pay attention to enable the C++ support when first installing the Visual Studio compiler, as by default C++ support is not installed. 

#### Git
Most of the robotology software is hosted on Git repositories, so you will need Git to download them.
You can download the Git installer at http://msysgit.github.io/ .

#### CMake
To install CMake you can use the official installer available at http://www.cmake.org/cmake/resources/software.html .
It is recommended to install the latest version of CMake.

#### Rapid Enviroment Editor
While this tool is not strictly required, it is convenient to install the [Rapid Environment Editor](https://www.rapidee.com/en/download) to easily modify the value of the [environment variables](https://msdn.microsoft.com/en-us/library/windows/desktop/ms682653(v=vs.85).aspx) in Windows. 

#### System Libraries
The software in the superbuild depends on several libraries such as [Eigen](http://eigen.tuxfamily.org) and [Qt](https://www.qt.io/) that we assume are already available in your machine, as it would be too time intensive to build those libraries in the superbuild itself. 

##### YARP, iCub  and robotology-additional-dependencies installers
The robotology project is currently providing binary installers for YARP and iCub libraries, and one additional installer for additional dependencies.
As the idea of the superbuild is to easily permit compilation from source of YARP, iCub and all related software, 
we use these installers only to install the **dependencies** of these libraries, not to install YARP and iCub themselfs. 
In particular you have to run the following installers:
* YARP ( http://www.yarp.it/download.html#download_windows ) to install ACE, Eigen3 and Qt5 (disable YARP itself during the installation as it will be installed by the superbuild, and disable OpenCV as the version distributed with YARP  is not working, see https://github.com/robotology/robotology-superbuild/issues/145 for more info)
* ICUB software ( http://wiki.icub.org/wiki/Windows:_installation_from_sources#Getting_iCub.27s_dependenceis ) to install Ipopt, SDL, Qt5 and GLUT (disable ICUB during the installation, as ICUB will be installed by the superbuild)
* the robotology-additional-dependencies installer ( https://github.com/robotology-playground/robotology-additional-dependencies ) to install LibXML2,
* if you need to compile software that depends on OpenCV, download the official installer for OpenCV 3.4.4 at https://sourceforge.net/projects/opencvlibrary/files/3.4.4/opencv-3.4.4-vc14_vc15.exe/download and set the `OpenCV_DIR` enviroment variable to the directory that contains the `OpenCVConfig.cmake` file, tipically `<install_prefix>/opencv/build/x64/vc15/lib/` for 64-bit installations. Note that tipically OpenCV is installed as part of the YARP dependencies installer, but at the moment the YARP dependencies installer has a bug related to OpenCV, see  https://github.com/robotology/robotology-superbuild/issues/145 for more info. Moreover, append `<install_prefix>/opencv/build/x64/vc15/bin/` to the `Path` environment variable.

**Important: make sure that you are installing the 64-bit installers, if you want to compile the robotology-superbuild using the the 64-bit compiler!**
These installers will set automatically all the enviroment variables necessary to make sure that these libraries are found by CMake, and they will modify the `PATH` enviroment variable to make sure that the libraries can be used when launching the programs that use them.  


If you want to enable a [profile](#profile-cmake-options) or a [dependency](#dependencies-cmake-options) specific CMake option, you may need to install additional system dependencies following the dependency-specific documentation:
* [`ROBOTOLOGY_USES_OCULUS_SDK`](#oculus)
* [`ROBOTOLOGY_USES_CYBERITH_SDK`](#cyberith)
* [`ROBOTOLOGY_USES_XSENS_MVN_SDK`](#xsens)
* [`ROBOTOLOGY_USES_ESDCAN`](#shoes)

### Superbuild
If you didn't already configured your git, you have to set your name and email to sign your commits:
```
git config --global user.name FirstName LastName
git config --global user.email user@email.domain
```
After that you can clone the superbuild repository as any other git repository, i.e. if you use terminal you can write:
~~~
git clone https://github.com/robotology/robotology-superbuild
~~~
or you can use your preferred Git GUI. 

Once you cloned the repository, you can generate the Visual Studio solution using the CMake GUI.
See the nicely written [CGold documentation](http://cgold.readthedocs.io/en/latest/first-step/generate-native-tool/gui-visual-studio.html) if you do not know how to generate a Visual Studio solution from a CMake project.

You can then open the generated solution with Visual Studio and build the target `all`.
Visual Studio will then download, build and install in a local directory all the robotology software and its dependencies.
If you prefer to work from the command line, you can also compile the `all` target using the following command (if you are in the `robotology-superbuild/build` directory, and the directory of the `cmake.exe` exectuable is in the [PATH](https://en.wikipedia.org/wiki/PATH_(variable)) :
~~~
cmake --build . --config Release
~~~

### Configure your environment
Currently the YCM superbuild does not support building a global install target, so all binaries are installed in `robotology-superbuild/build/install/bin` and all libraries in `robotology-superbuild/build/install/lib`.

To use the binaries and libraries installed by the robotology-superbuild, you should update the enviroment variables of your process such as `PATH` and `CMAKE_PREFIX_PATH`.

If you are an heavy user  of the software installed by the robotology-superbuild, you may want to update your [user enviroment variables](https://docs.microsoft.com/en-us/windows/win32/shell/user-environment-variables) to permit you to use the robotology-superbuild software from any Windows process. To automatically update the user enviroment variables, the robotology-superbuild provides the `addPathsToUserEnvVariables.ps1` and `removePathsFromUserEnvVariables.ps1` available at `<directory-where-you-downloaded-robotology-superbuild>/build/install/share/robotology-superbuild/`.  As indicated by their name, `addPathsToUserEnvVariables.ps1` is used to setup the enviroment variables used by the robotology-superbuild, while `removePathsFromUserEnvVariables.ps1` permits to cleanly remove them. To configure the robotology-superbuild, just run the `addPathsToUserEnvVariables.ps1` script once in a Powershell terminal.

To check the values of the enviroment variables modified by the powershell scripts provided by the superbuild, you can use a program such as [Rapid Enviroment Editor](https://www.rapidee.com/).

If you do not want to permanently modify the user enviroment variables permanently, the superbuild provides an automatically generated `setup.bat` batch script in `<directory-where-you-downloaded-robotology-superbuild>/build/install/share/robotology-superbuild/setup.bat`. This script will set
all the necessary enviromental variables to use the software installed by the robotology-superbuild. However, as in Windows there is no `.bashrc` file-equivalent, you will need to call this script every time you open a batch terminal in which you want to run the software installed by the robotology-superbuild.

If for any reason you do not want to use the provided scripts and you want to manage your enviroment variables manually, for example because you want to cleanup the enviroment variables modified by `addPathsToUserEnvVariables.ps1`  and you delete the corresponding `removePathsFromUserEnvVariables.ps1`, please refer to the documentation available at [`doc/environment-variables-configuration.md `](doc/environment-variables-configuration.md).

 **If you have problems in Windows in launching executables or using libraries installed by superbuild, it is possible that due to some existing software on your machine your executables are not loading the correct `dll` for some of the dependencies. This is the so-called [DLL Hell](https://en.wikipedia.org/wiki/DLL_Hell#Causes), and for example it can happen if you are using the [Anaconda](https://www.anaconda.com/) Python distribution on your Windows installation.  To troubleshoot this kind of problems, you can open the library or executable that is not working correctly using the [`Dependencies`](https://github.com/lucasg/Dependencies) software. This software will show you which DLL your executable or library is loading. If you have any issue of this kind and need help, feel free to [open an issue in our issue tracker](https://github.com/robotology/robotology-superbuild/issues/new).**
 
## Windows Subsystem for Linux
The [Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl) (wsl)  lets developers run a GNU/Linux environment -- including most command-line tools, utilities, and applications -- directly on Windows, unmodified, without the overhead of a virtual machine.

As all the software running on Linux distributions can run unmodified on Windows via WSL, to install the robotology-superbuild in WSL you can just install a Debian-based distribution for WSL, and then follow the instructions on how to install the [robotology-superbuild on Linux](#linux). As the WSL enviroment is nevertheless different, there are few things you need to care before using the robotology-superbuild on WSL, that are listed in the following.

### Run graphical applications on WSL
To run graphical applications on WSL, you need to install a X Server for Windows, that will be able to visualize the windows WSL-based applications, see https://www.howtogeek.com/261575/how-to-run-graphical-linux-desktop-applications-from-windows-10s-bash-shell/ for more info. For information of X Servers that can be installed on Windows, follow the docs in https://github.com/sirredbeard/Awesome-WSL#10-gui-apps . 

### Sanitize enviroment variables for WSL
By default, the `PATH` enviroment variable in WSL will contain the path of the host Windows system, see https://github.com/microsoft/WSL/issues/1640 and https://github.com/microsoft/WSL/issues/1493. This can create problems, 
as the CMake in WSL may find (incompatible) Windows CMake packages and try to use them, creating errors due to the compilation. 
To avoid that, you can add the following line in the WSL `.bashrc` that filters all the Windows paths from the WSL's enviromental variables:
~~~
for var in $(env | awk {'FS="="} /\/mnt\//{print $1}'); do export ${var}=\"$(echo ${!var} | awk -v RS=: -v ORS=: '/\/mnt\// {next} {print $1}')\" ; done
~~~

Update
======
For updating the `robotology-superbuild` repository it is possible to just fetch the last changes using the usual
git command:
~~~
git pull
~~~
However, for running the equivalent of `git pull` on all the repositories managed by
the robotology-superbuild, you have to run in your build system the appropriate target.
To do this, make sure to be in the `build` directory of the `robotology-superbuild` and run:
~~~
make update-all
make
~~~
using make on Linux or macOS or
~~~
cmake --build . --target UPDATE_ALL
cmake --build .
~~~
using Visual Studio on Windows or
~~~
cmake --build . --target ALL_UPDATE
cmake --build .
~~~
using Xcode on macOS.

Note that the update will try to update all the software in the `robotology-superbuild`, and it will complain if the repository is not in the expected branch.
For this reason, if you are activly developing on a repository managed by the `robotology-superbuild`, remember to switch the `YCM_EP_DEVEL_MODE_<package_name>`
option to `TRUE`. This option will ensure that the superbuild will not try to automatically update the `<package_name>` repository. See  https://robotology.github.io/ycm/gh-pages/git-master/manual/ycm-superbuild.7.html#developer-mode
for more details on this options.

By default, the `robotology-superbuild` uses the latest "stable" branches of the robotology repositories, but in some cases it may be necessary to use the "unstable" active development branches, 
or use some fixed tags. For this advanced functionalities, please refer to the documentation on changing the default project tags, available at [`doc/change-project-tags.md`](doc/change-project-tags.md).


Profile-specific documentation
===================================

## Core 
This profile is enabled by the `ROBOTOLOGY_ENABLE_CORE` CMake option.

### System Dependencies
The steps necessary to install the system dependencies of the Core profile are provided in
operating system-specific installation documentation.

### Check the installation
Follow the steps in http://wiki.icub.org/wiki/Check_your_installation to verify if your installation was successful.

## Robot Testing
This profile is enabled by the `ROBOTOLOGY_ENABLE_ROBOT_TESTING` CMake option.

### System Dependencies
The steps necessary to install the system dependencies of the Robot Testing profile are provided in
operating system-specific installation documentation, and no additional required system dependency is required.

### Check the installation
If the profile has been correctly enabled and compiler, you should be able to run the `robottestingframework-testrunner` executable from the command line.


## Dynamics
This profile is enabled by the `ROBOTOLOGY_ENABLE_DYNAMICS` CMake option.

### System Dependencies
The steps necessary to install the system dependencies of the Dynamics profile are provided in
operating system-specific installation documentation, and no additional required system dependency is required.

The only optional system dependency of `wb-toolbox`, project part of this profile, is [tbeu/matio](https://github.com/tbeu/matio/).

#### Linux

Install matio using the following command:

```
sudo apt install libmatio-dev
```

#### macOS

Install matio from `homebrew/core` using the following command:

```
brew install libmatio
```

#### Windows

Install matio following the [installation instructions](https://github.com/tbeu/matio/#20-building) present in the repository.

## iCub Head

This profile is enabled by the `ROBOTOLOGY_ENABLE_ICUB_HEAD` CMake option. It is used in the system installed on iCub head,
or if you are a developer that needs to access iCub hardware devices directly without passing through the iCub head.

**Warning: the migration of existing iCub setups to use the robotology-superbuild is an ongoing process, and it is possible
that your iCub still needs to be migrated. For any doubt, please get in contact with [icub-support](https://github.com/robotology/icub-support).**

The configuration and compilation of this profile is supported only on Linux systems.

This section documents the iCub Head profile as any other profile, in a way agnostic of the specific machine in which it is installed. To get information on how to use the robotology-superbuild to install software on the machine mounted in the head of physical iCub robots, please check the documentation in [`doc/use-on-icub-head.md`](doc/use-on-icub-head.md).

### System Dependencies
The steps necessary to install the system dependencies of the iCub Head profile are provided in
operating system-specific installation documentation, and no additional required system dependency is required.

On old iCub systems equipped with the [CFW2 CAN board](http://wiki.icub.org/wiki/CFW_card), it may be necessary to have the cfw2can driver
installed on the iCub head (it is tipically already pre-installed in the OS image installed in the system in the iCub head). In that
case, you also need to enable the `ROBOTOLOGY_USES_CFW2CAN` option to compile the software that depends on cfw2can. In case of doubt,
please always get in contact with [icub-support](https://github.com/robotology/icub-support).

### Check the installation
The `ROBOTOLOGY_ENABLE_ICUB_HEAD` installs several YARP devices for communicating directly with embedded boards of the iCub.
To check if the installation was correct, you can list all the available YARP devices using the `yarpdev --list` command,
and check if devices whose name is starting with `embObj` are present in the list. If those devices are present, then the installation
should be working correctly.


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
To run a human dynamics estimation scenario, we need a Windows machine to install the Xsens suit SDK for getting the sensory information of the human motions from [Xsens](https://www.xsens.com/) and [ESD USB CAN driver](https://esd.eu/en/products/can-usb2) to get the FTShoes/FTSkShoes sensory information. Refer to [Xsens](#xsens) and [FTShoes/FTSkShoes](#shoes) for more information about the dependencies.

Dependencies-specific documentation
===================================

## Gazebo
Support for this dependency is enabled by the `ROBOTOLOGY_USES_GAZEBO` CMake option.

**Warning: at the moment the Gazebo simulator does not support directly Windows. If you need to run Gazebo on Windows, it is recommended to do so via the [Windows Subsystem for Linux](#windows-subsystem-for-linux).**

### System Dependencies
Install Gazebo following the instructions available at http://gazebosim.org/tutorials?cat=install .
Make sure to install also the development files, i.e. `libgazebo*-dev` on Debian/Ubuntu.


### Check the installation
Follow the steps in https://github.com/robotology/icub-gazebo#usage and/or https://github.com/robotology/icub-models#use-the-models-with-gazebo to check if the Gazebo-based iCub simulation works fine. 

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
can install some projects that depend on MATLAB, in particular:
 * the MATLAB bindings of the [iDynTree](https://github.com/robotology/idyntree) library,
 * the native MATLAB bindings of YARP, contained in the [yarp-matlab-bindings](https://github.com/robotology-playground/yarp-matlab-bindings/) repository,
 * the MATLAB bindings of qpOASES, contained in the [robotology-dependencies/qpOASES](https://github.com/robotology-dependencies/qpOASES) fork,
 * The [WB-Toolbox](https://github.com/robotology/WB-Toolbox) Simulink toolbox,
 * The [whole-body-controllers](https://github.com/robotology/whole-body-controllers) Simulink-based balancing controllers.

To use this software, you can simply enable its compilation using the `ROBOTOLOGY_USES_MATLAB` CMake option.
Once this software has been compiled by the superbuild, you just need to add some directories of the robotology-superbuild install (typically `$ROBOTOLOGY_SUPERBUILD_SOURCE_DIR/build/install`) to [the MATLAB path](https://www.mathworks.com/help/matlab/matlab_env/what-is-the-matlab-search-path.html).
In particular you need to add to the MATLAB path the `$ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX/mex` directory and all the subdirectories `$ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX/share/WBToolbox`.

#### Start MATLAB from the launcher or the application menu

You could add this line to your MATLAB script that uses the robotology-superbuild matlab software, substituting `<ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX>` with the `install` folder inside the build directory of the superbuild:

~~~
    addpath('<ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX>' '/mex'])
    addpath('<ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX>' '/share/WBToolbox'])
    addpath('<ROBOTOLOGY_SUPERBUILD_INSTALL_PREFIX>' '/share/WBToolbox/images'])
~~~

Another way is to run (only once) the script `startup_robotology_superbuild.m` in the `$ROBOTOLOGY_SUPERBUILD_SOURCE_DIR/build` folder. This should be enough to permanently add the required paths for all the toolbox that use MATLAB.

#### Start MATLAB from the terminal

You can add the folders by modifying the `startup.m` or the `MATLABPATH` environmental variable [as described in official MATLAB documentation](https://www.mathworks.com/help/matlab/matlab_env/add-folders-to-matlab-search-path-at-startup.html).
If you are using the `setup.sh` or `setup.bat` script for configuring your environment, `MATLABPATH` is automatically populated with these directories.

For more info on configuring MATLAB software with the robotology-superbuild, please check the [wb-toolbox README](https://github.com/robotology/wb-toolbox).

#### whole-body-controllers installation procedure

To use [whole-body-controllers](https://github.com/robotology/whole-body-controllers), additional installation steps are required. All the documentation concerning the `whole-body-controllers` installation and usage can be found in the repository [README](https://github.com/robotology/whole-body-controllers#installation-and-usage).

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
The `ROBOTOLOGY_USES_OCTAVE` option has never been tested on Windows.

### Configuration
Add the `$ROBOTOLOGY_SUPERBUILD_SOURCE_DIR/build/install/octave` directory to your [Octave path](https://www.gnu.org/software/octave/doc/interpreter/Manipulating-the-Load-Path.html).

## Python

Support for this dependency is enabled by the `ROBOTOLOGY_USES_PYTHON` CMake option.

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

**Warning: at the moment the Oculus SDK does not support macOS and Linux, so this option is only supported
on Windows.**

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

## Shoes
Support for FTShoes/FTSkShoes depends on operating system. 
   - For Windows the support is provided by`ROBOTOLOGY_USES_ESDCAN` option (shoes force/torque sensors) is only enabled when the `ROBOTOLOGY_ENABLE_ICUB_HEAD` CMake option is set to ON.
   - For Linux OS enable the `socketCan` option in [`ICUB`](https://github.com/robotology/icub-main) (not tested).
   - This option does not support in macOS.


### System Dependencies
To get the information from FTShoes/FTSkShoes, check and install the ESD USB CAN driver, please follow the steps for USB-CAN2 driver mentioned in [here](https://github.com/robotology/human-dynamics-estimation/wiki/Set-up-Machine-for-running-HDE#usb-can-2) (Windows OS). 

### Configuration
To configure the FTShoes/FTSkShoes please follow the steps for USB-CAN2 mentioned in [here](https://github.com/robotology/human-dynamics-estimation/wiki/Set-up-Machine-for-running-HDE#usb-can-2) (Windows OS). 

FAQs
====

See also YCM documentation for [YCM's FAQs](http://robotology.github.io/ycm/gh-pages/git-master/manual/ycm-faq.7.html).

### Which are the differences between the `robotology-superbuild` and the `codyco-superbuild` ?

The CoDyCo European project that funded the development and the mantainance of the `codyco-superbuild` ended in 2017 .
The robotology-superbuild is the successor of the codyco-superbuild, but it is not limited to software developed in the
CoDyCo project, but more in general software developed in the robotology GitHub organization.

Technically speaking, there are a few differences:
* Projects in the `codyco-superbuild` were saved in the external, libraries or main directories subdirectories of the source
and of the build directories. For the sake of simplicity, the `robotology-superbuild` just save robotology projects in the robotology
directory and all external projects in the external directory.
* Support for software that depends on Gazebo (gazebo-yarp-plugins, icub-gazebo, ...) is enabled by default in Linux and macOS .
* In the `robotology-superbuild` the compilation for dynamics-related software (iDynTree, balancing and walking controllers) needs to be explicity enabled using the `ROBOTOLOGY_ENABLE_DYNAMICS` that is `OFF` by default. 

### I successfully used the `robotology-superbuild` for my project, how do I cite it in my publication?

The `robotology-superbuild` is based on [YCM](https://github.com/robotology/ycm), you can cite one of these papers:

* **A Build System for Software Development in Robotic Academic Collaborative Environments**,
  D.E. Domenichelli, S. Traversaro, L. Muratore, A. Rocchi, F. Nori, L. Natale,
  Second IEEE International Conference on Robotic Computing (IRC), 2018,
  https://doi.org/10.1109/IRC.2018.00014

* **A Build System for Software Development in Robotic Academic Collaborative Environments**,
  D.E. Domenichelli, S. Traversaro, L. Muratore, A. Rocchi, F. Nori, L. Natale,
  **IN PRESS** International Journal of Semantic Computing (IJSC), Vol. 13, No. 02, 2019


Mantainers
==========

| Profile  | Maintainer                     |
|:--------:|:-----------------------------:|
| Core     | Silvio Traversaro [@traversaro](https://github.com/traversaro) |
| Dynamics | Silvio Traversaro [@traversaro](https://github.com/traversaro) |
| Teleoperation | Kourosh Darvish [@kouroshD](https://github.com/kouroshD) |
| Human Dynamics | Yeshasvi Tirupachuri [@Yeshasvitvs](https://github.com/Yeshasvitvs) |
