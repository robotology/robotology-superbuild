# robotology-superbuild

This is a meta repository (so-called "superbuild") that uses [CMake](https://cmake.org/) and [YCM](https://github.com/robotology/ycm) to automatically
download and compile software developed in the robotology GitHub organization, such as the YARP middleware or software used to run the iCub humanoid robot.

[CMake](https://cmake.org/) is an open-source, cross-platform family of tools designed to build, test and package software.
A [YCM Superbuild](http://robotology.github.io/ycm/gh-pages/git-master/index.html#superbuild) is a CMake project whose only goal is to download and build several other projects.
If you are familiar with ROS, it is something similar to [catkin](http://wiki.ros.org/catkin/workspaces) or [colcon workspace](https://colcon.readthedocs.io/en/released/user/quick-start.html), but using pure CMake for portability reasons and for customizing the build via CMake options. Furthermore, the `robotology-superbuild` also contains some infrastructure to build **binaries** of the contained projects for some platforms. 
You can read more about the superbuild concept in [YCM documentation](http://robotology.github.io/ycm/gh-pages/latest/index.html) or in the [related IRC paper](http://lornat75.github.io/papers/2018/domenichelli-irc.pdf).

| System  | Continuous Integration Status |
|:------:|:------:|
|  Linux/macOS/Windows  |  ![GitHub Actions Status](https://github.com/robotology/robotology-superbuild/workflows/C++%20CI%20Workflow/badge.svg)     |

Table of Contents
=================
  * [Superbuild](#superbuild)
  * [Binary Installation](#binary-installation)
    * [Windows](#windows-from-binaries)
  * [Source Installation](#source-installation)
    * [Clone the repo](#clone-the-repo)
    * [Linux](#linux-from-source)
    * [macOS](#macos-from-source)
    * [Windows](#windows-from-source)
    * [Windows Subsystem For Linux](#windows-subsystem-for-linux-from-source)
    * [Update](#update)
  * [FAQs](#faqs)
  * [Mantainers](#mantainers)

Superbuild 
==========

The `robotology-superbuild` is an infrastructure to simplify development and use of **open source research software** developed at the **[Italian Institute of Technology](https://iit.it/)**, in particular as part of the **[iCub project](https://icub.iit.it/)**. 

### Profiles and Optional Dependencies
As a huge number of software projects are contained in the `robotology-superbuild`, and a tipical user is only interested in some of them, there are several **options** to instruct the superbuild on which packages should be built and which one should not be built. In particular, the robotology-superbuild is divided in different **profiles**, that specify the specific subset of robotology packages to build. You can read more on the available **profiles** and how to enabled them in the [`doc/profiles.md` documentation](doc/profiles.md).

Furthermore, some **dependencies** of software contained in the `robotology-superbuild` are either tricky to install or proprietary, and for this reason software that depends on those  optional dependencies can be **enabled** or **disabled** with specific options,as documented in [`doc/profiles.md#dependencies-specific-documentation`](doc/profiles.md#dependencies-specific-documentation).

### Versioning
For what regards versioning, software in the robotology-superbuild can be consumed in two forms: 

#### [Rolling update](https://en.wikipedia.org/wiki/Rolling_release)
In this form, the superbuild will get the latest changes for a branch of each subproject, and will build it. This has the advantage that you get all the latest changes from the software contained in the `robotology-superbuild`, while the downside that the specific software that you use may change at each update. The **rolling update** can be used only when building robotology-superbuild software **from source**. By default, the `robotology-superbuild` uses the latest "stable" branches of the robotology repositories, but in some cases it may be necessary to use the "unstable" active development branches. For this advanced functionalities, please refer to the documentation on changing the default project tags, available at [`doc/change-project-tags.md`](doc/change-project-tags.md).


#### [Releases](https://en.wikipedia.org/wiki/Software_release_life_cycle)
Once every three months, a set of releases of the software in the robotology-superbuild is freezed and used as a "Distro Release", following the policies of iCub software described in https://icub-tech-iit.github.io/documentation/sw_versioning_table/ . **Releases** can be used both when **building the software from source**, and when obtaining it **from binaries**.

The available releases can be seen on [GitHub's release page](https://github.com/robotology/robotology-superbuild/releases).

Binary Installation
===================

The only platform on which we currently provide binary installation of the software contained in the robotology-superbuild is [Windows](#windows-from-binaries). 
For all other platforms, please refer to the instructions on how to install the [robotology-superbuild from source code](#source-installation).

## Windows from binaries

Any release of robotology-superbuild comes with Windows binaries, that can be downloaded from the [GitHub's release page](https://github.com/robotology/robotology-superbuild/releases) of that release.

Each release contains two installers:
* `robotology-dependencies-installer-win64.exe` that installs a custom vcpkg installation in `C:/robotology/vcpkg` for compile from source the robotology software
* `robotology-full-installer-win64.exe` that also installs the software built by the robotology-superbuild in `C:/robotology/robotology`.

In both cases, the installer offer an options to create and append all the necessary user environment variables to use the C++ libraries and the binaries without any further configuration. Note that you may want to opt out from this if in your system you also use other kind of C++ libraries system to avoid conflicts, and instead manually invoke the following scripts to setup the environments as  necessary: 
* `C:/robotology/scripts/setup.bat` : Batch script to set the environment variables in a Command Prompt terminal.
* `C:/robotology/scripts/setup.sh` : Bash script to set the environment variables in a Git for Windows bash terminal, 
   that can be included in the [`.bash_profile`](https://stackoverflow.com/questions/6883760/git-for-windows-bashrc-or-equivalent-configuration-files-for-git-bash-shell).
* `C:/robotology/scripts/addPathsToUserEnvVariables.ps1` : Powershell scripts to **permanently** add or remove the environment  variables in the [User Environment Variables](https://docs.microsoft.com/en-us/windows/win32/shell/user-environment-variables). This is the script that is executed by the installer when the option "Update Environment Variables"  is selected. The environment can be cleaned by any environment variable added by `addPathsToUserEnvVariables.ps1` by executing the script `removePathsToUserEnvVariables.ps1`.

Furthermore, if you do not have Visual  Studio 2019 installed on your machine, the installer requires the **Microsoft Visual C++ Redistributable for Visual Studio 2015, 2017 and 2019** to be installed on your machine, that can be downloaded at https://support.microsoft.com/en-us/help/2977003/the-latest-supported-visual-c-downloads, in particular you need to install the file https://aka.ms/vs/16/release/vc_redist.x64.exe .

Source Installation
===================

## Clone the repo
The first step to install `robotology-superbuild` from source is to download the `robotology-superbuild` code itself, and this is done through [Git](https://git-scm.com/).

Once you install Git, you need to set your name and email to sign your commits, as this is required by the superbuild:
```
git config --global user.name FirstName LastName
git config --global user.email user@email.domain
```

Once git is configured, you can open a command line terminal. If you want to use the `robotology-superbuild` in **rolling update** mode, just clone the superbuild:
~~~
git clone https://github.com/robotology/robotology-superbuild
~~~
this will clone the superbuild in its default branch.

You can download and use the `robotology-superbuild` anywhere on your system, but if you are installing it 
on an [**iCub robot laptop** following the official iCub instructions](https://icub-tech-iit.github.io/documentation/icub_operating_systems/other-machines/generic-machine/), you should clone it in the `/usr/local/src/robot` directory.

If instead you want to use a **specific release** of the robotology superbuild, after you clone switch to use to a specific release tag: 
~~~
git checkout v<YYYY.MM>
~~~

For the list of actually available tags, see the [GitHub's releases page](https://github.com/robotology/robotology-superbuild/releases).

Once you cloned the repo, to go forward you can follow the different instructions on how to install robotology-superbuild from the source code, depending on your operating system:
* [**Linux**](#linux-from-source): use the superbuild with make,
* [**macOS**](#macos-from-source): use the superbuild with Xcode or GNU make,
* [**Windows**](#windows-from-source): use the superbuild with Microsoft Visual Studio,
* [**Windows Subsystem For Linux**](#windows-subsystem-for-linux-from-source): use the superbuild with make on [Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl).

The exact versions of the operating systems supported by the robotology-superbuild follow the one supported by the YARP library, that are documented in https://github.com/robotology/yarp/blob/master/.github/CONTRIBUTING.md#supported-systems .
Complete documentation on how to use a YCM-based superbuild is available in the [YCM documentation](http://robotology.github.io/ycm/gh-pages/git-master/manual/ycm-superbuild.7.html).

When compiled from source, `robotology-superbuild` will download and build a number of software.
For each project, the repository will be downloaded in the `src/<package_name>` subdirectory of the superbuild root. 
The build directory for a given project will be instead the `src/<package_name>` subdirectory of the superbuild build directory. 
All the software packages are installed using the `install` directory of the build as installation prefix.s


## Linux from source
### System Dependencies
On Debian based systems (as Ubuntu) you can install the C++ toolchain, Git, CMake and Eigen (and other dependencies necessary for the software include in `robotology-superbuild`) using `apt-get`:
```
sudo apt-get install build-essential cmake cmake-curses-gui coinor-libipopt-dev freeglut3-dev git libace-dev libboost-filesystem-dev libboost-system-dev libboost-thread-dev libdc1394-22-dev libedit-dev libeigen3-dev libgsl0-dev libjpeg-dev liblua5.1-dev libode-dev libopencv-dev libsdl1.2-dev libtinyxml-dev libv4l-dev libxml2-dev lua5.1 portaudio19-dev qml-module-qt-labs-folderlistmodel qml-module-qt-labs-settings qml-module-qtmultimedia qml-module-qtquick-controls qml-module-qtquick-dialogs qml-module-qtquick-window2 qml-module-qtquick2 qtbase5-dev qtdeclarative5-dev qtmultimedia5-dev swig libmatio-dev
```

For what regards CMake, the robotology-superbuild requires CMake 3.16 . If you are using a recent Debian-based system such as Ubuntu 20.04, the default CMake is recent enough and you do not need to do further steps.

If instead you use an older distro in which the default version of CMake is older, you can easily install a newer CMake version in several ways. For the following distributions, we recommend the following methods:  
* Ubuntu 18.04 : use the latest CMake release in the [Kitware APT repository](https://apt.kitware.com/). You can find the full instructions for the installation on the website.
* Debian 10 : use the CMake in the `buster-backports` repository, following the instructions to install from backports available in  [Debian documentation](https://backports.debian.org/Instructions/).
More details can be found at https://github.com/robotology/QA/issues/364 .

If you enabled any [profile](doc/profiles.md#profile-cmake-options) or [dependency](doc/profiles.md#dependencies-cmake-options) specific CMake option you may need to install additional system dependencies, following the dependency-specific documentation (in particular, the `ROBOTOLOGY_USES_GAZEBO` option is enabled by default, so you should install Gazebo unless you plan to disable this option):
* [`ROBOTOLOGY_USES_GAZEBO`](doc/profiles.md#gazebo)

### Superbuild

Finally it is possible to install robotology software using the YCM superbuild:
```bash
cd robotology-superbuild
mkdir build
cd build
ccmake ../
make
```
You can configure the ccmake environment if you know you will use some particular set of software (put them in "ON").
See [Superbuild CMake options](doc/profiles.md#superbuild-cmake-options) for a list of available options.

### Configure your environment
The superbuild provides an automatically generated `setup.sh` sh script that will set all the necessary enviromental variables to use the software installed in the robotology-superbuild. To do so automatically for any new terminal that you open, append the following line to the `.bashrc` file:
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

## macOS from source

### System Dependencies
To install the system dependencies, it is possible to use [Homebrew](http://brew.sh/):
```
brew install ace boost cmake eigen gsl ipopt jpeg libedit opencv pkg-config portaudio qt@5 sqlite swig tinyxml libmatio
```

Since Qt5 is not symlinked in `/usr/local` by default in the homebrew formula, `Qt5_DIR` needs to be properly set to make sure that CMake-based projects are able to find Qt5.
```
export Qt5_DIR=/usr/local/opt/qt5/lib/cmake/Qt5
```

If you want to enable a [profile](doc/profiles.md#profile-cmake-options) or a [dependency](doc/profiles.md#dependencies-cmake-options) specific CMake option, you may need to install additional system dependencies following the dependency-specific documentation (in particular, the `ROBOTOLOGY_USES_GAZEBO` option is enabled by default, so you should install Gazebo unless you plan to disable this option):
* [`ROBOTOLOGY_USES_GAZEBO`](doc/profiles.md#gazebo)

### Superbuild
```
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
xcodebuild [-configuration Release|Debug] [-jobs <n>] [-list | -target <target_name>]
```
`-list` gives the list of available targets.

**Note: as of late 2020, the Xcode 12 generator is not supported, for more info see https://github.com/robotology/ycm/issues/368. 
  All previous versions instead should work fine. If you have Xcode 12 installed in your macOS system, please use the GNU Makefiles generator.**

### Configure your environment
The superbuild provides an automatically generated `setup.sh` sh script that will set all the necessary enviromental variables to use the software installed in the robotology-superbuild. To do so automatically for any new terminal that you open, append the following line to the `.bash_profile` file:
```
source <directory-where-you-downloaded-robotology-superbuild>/build/install/share/robotology-superbuild/setup.sh
```

To use the updated `.bash_profile` in your terminal you should run the following command:
```bash
user@host:~$ source ~/.bash_profile
```
or simply open a new terminal.

If for any reason you do not want to use the provided `setup.sh` script and you want to manage your enviroment variables manually, please refer to the documentation available at [`doc/environment-variables-configuration.md `](doc/environment-variables-configuration.md).

## Windows from source

### System Dependencies
As Windows does not have a widely used system [package manager](https://en.wikipedia.org/wiki/Package_manager) such as the one that are available on Linux or macOS, installing the system dependencies is slightly more compliated. However, we try to document every step necessary for the installation, but you find something that you don't understand in the documentation, please [open an issue](https://github.com/robotology/robotology-superbuild/issues/new).  

#### Visual Studio
Most of the robotology software is developed using the C/C++ language. For this reason, you should have [Visual Studio](https://www.visualstudio.com/), the official Microsoft compiler for Windows, installed on your computer to compile the software in the superbuild. Only Visual Studio 2019 targeting the 64 bit platform is currently supported by the robotology-superbuild.
Pay attention to enable the C++ support (https://docs.microsoft.com/en-us/cpp/build/vscpp-step-0-installation) when first installing the Visual Studio compiler, as by default C++ support is not installed.

#### Git
Most of the robotology software is hosted on Git repositories, so you will need Git to download them.
You can download the Git installer at http://msysgit.github.io/ .

#### CMake
To install CMake you can use the official installer available at http://www.cmake.org/cmake/resources/software.html .
It is recommended to install the latest version of CMake.

#### Rapid Enviroment Editor
While this tool is not strictly required, it is convenient to install the [Rapid Environment Editor](https://www.rapidee.com/en/download) to easily modify the value of the [environment variables](https://msdn.microsoft.com/en-us/library/windows/desktop/ms682653(v=vs.85).aspx) in Windows.

#### System Libraries
The software in the superbuild depends on several C++  libraries: to install the required dependencies on your machine, we suggest to use [`vcpkg`](https://github.com/microsoft/vcpkg), the C++ library manager mantained by Microsoft. As `vcpkg` compiles from sources all its libraries, this can be quite time intensive for some libraries such as `qt5` or `opencv`.

For this reason, we provide a ready to use `vcpkg` workspace at https://github.com/robotology/robotology-superbuild-dependencies-vcpkg/releases, that you can download and unzip in `C:/` and use directly from there, for example executing the following commands from the Git Bash shell:
~~~
cd C:/
wget https://github.com/robotology/robotology-superbuild-dependencies-vcpkg/releases/latest/download/vcpkg-robotology.zip
unzip vcpkg-robotology.zip -d C:/
rm vcpkg-robotology.zip
~~~
or creating the directories and extracting the archive through the File Explorer. If you prefer to use your own vcpkg to install the dependencies of the superbuild, please refer to the documentation available at [`doc/vcpkg-dependencies.md`](doc/vcpkg-dependencies.md).

If you want to enable the `ROBOTOLOGY_USES_GAZEBO` option, you will need to download and extract the `vcpkg-robotology-with-gazebo.zip` archive. For instructions on how to correctly use this archives, please refer to documentation of the [`robotology-superbuild-dependencies-vcpkg`](https://github.com/robotology/robotology-superbuild-dependencies-vcpkg) repo.

If you want to enable a [profile](doc/profiles.md#profile-cmake-options) or a [dependency](doc/profiles.md#dependencies-cmake-options) specific CMake option, you may need to install additional system dependencies following the dependency-specific documentation:
* [`ROBOTOLOGY_USES_OCULUS_SDK`](doc/profiles.md#oculus)
* [`ROBOTOLOGY_USES_CYBERITH_SDK`](doc/profiles.md#cyberith)
* [`ROBOTOLOGY_USES_XSENS_MVN_SDK`](doc/profiles.md#xsens)
* [`ROBOTOLOGY_USES_ESDCAN`](doc/profiles.md#shoes)

### Superbuild
Once you cloned the repository, you can generate the Visual Studio solution using the CMake GUI, by using as a generator the appropriate Visual Studio version, and the 64 bit as platform, and specifying the [vcpkg CMake toolchain](https://github.com/Microsoft/vcpkg/blob/master/docs/users/integration.md#cmake-toolchain-file-recommended-for-open-source-cmake-projects) as discussed in the previous section. In particular, see the nicely written [CGold documentation](http://cgold.readthedocs.io/en/latest/first-step/generate-native-tool/gui-visual-studio.html) if you do not know how to generate a Visual Studio solution from a CMake project.

You can then open the generated solution with Visual Studio and build the target `all`.

Visual Studio will then download, build and install in a local directory all the robotology software and its dependencies.
If you prefer to work from the command line, you can also compile the `all` target using the following command (if you are in the `robotology-superbuild/build` directory, and the directory of the `cmake.exe` exectuable is in the [PATH](https://en.wikipedia.org/wiki/PATH_(variable)) :
~~~
cmake --build . --config Release
~~~

### Configure your environment
If you are an heavy user of the software installed by the robotology-superbuild, you may want to update your [user enviroment variables](https://docs.microsoft.com/en-us/windows/win32/shell/user-environment-variables) to permit you to use the robotology-superbuild software from any Windows process. To automatically update the user enviroment variables, the robotology-superbuild provides the `addPathsToUserEnvVariables.ps1` and `removePathsFromUserEnvVariables.ps1` available at `<directory-where-you-downloaded-robotology-superbuild>/build/install/share/robotology-superbuild/`.  As indicated by their name, `addPathsToUserEnvVariables.ps1` is used to setup the enviroment variables used by the robotology-superbuild, while `removePathsFromUserEnvVariables.ps1` permits to cleanly remove them. To configure the robotology-superbuild, just run the `addPathsToUserEnvVariables.ps1` script once in a Powershell terminal.

To check the values of the enviroment variables modified by the powershell scripts provided by the superbuild, you can use a program such as [Rapid Enviroment Editor](https://www.rapidee.com/).

If you do not want to modify the user enviroment variables permanently, the superbuild provides an automatically generated `setup.bat` batch script in `<directory-where-you-downloaded-robotology-superbuild>/build/install/share/robotology-superbuild/setup.bat`. This script will set
all the necessary enviromental variables to use the software installed by the robotology-superbuild. However, as in Windows there is no `.bashrc` file-equivalent, you will need to call this script every time you open a batch terminal in which you want to run the software installed by the robotology-superbuild.

Another option if you do not want to to modify the user enviroment variables permanently and you use the Git Bash as your main terminal,
is to use the automatically generated `setup.sh` script,  available in `<directory-where-you-downloaded-robotology-superbuild>/build/install/share/robotology-superbuild/setup.sh`.
You can source automatically this script for any new Git Bash instance by creating a `.bash_profile` file  in your `C:/Users/<UserName>`  directory, and by adding in it the file:
~~~
source <directory-where-you-downloaded-robotology-superbuild>/build/install/share/robotology-superbuild/setup.sh
~~~

If for any reason you do not want to use the provided scripts and you want to manage your enviroment variables manually, for example because you want to cleanup the enviroment variables modified by `addPathsToUserEnvVariables.ps1`  and you delete the corresponding `removePathsFromUserEnvVariables.ps1`, please refer to the documentation available at [`doc/environment-variables-configuration.md `](doc/environment-variables-configuration.md).

 **If you have problems in Windows in launching executables or using libraries installed by superbuild, it is possible that due to some existing software on your machine your executables are not loading the correct `dll` for some of the dependencies. This is the so-called [DLL Hell](https://en.wikipedia.org/wiki/DLL_Hell#Causes), and for example it can happen if you are using the [Anaconda](https://www.anaconda.com/) Python distribution on your Windows installation.  To troubleshoot this kind of problems, you can open the library or executable that is not working correctly using the [`Dependencies`](https://github.com/lucasg/Dependencies) software. This software will show you which DLL your executable or library is loading. If you have any issue of this kind and need help, feel free to [open an issue in our issue tracker](https://github.com/robotology/robotology-superbuild/issues/new).**

## Windows Subsystem for Linux from source
The [Windows Subsystem for Linux](https://docs.microsoft.com/en-us/windows/wsl) (wsl)  lets developers run a GNU/Linux environment -- including most command-line tools, utilities, and applications -- directly on Windows, unmodified.

As all the software running on Linux distributions can run unmodified on Windows via WSL, to install the robotology-superbuild in WSL you can just install a Debian-based distribution for WSL, and then follow the instructions on how to install the [robotology-superbuild on Linux](#linux). As the WSL enviroment is nevertheless different, there are a few things you need to care before using the robotology-superbuild on WSL, that are listed in the following, depending on whetever you are using WSL2 or WSL1.

### WSL2

#### Run graphical applications on WSL2
The Linux instance in WSL2 are running as part of a lightweight virtual machine, so effectively the IP address of the WSL2 instance will be different from the IP address
of the Windows host, and the Windows host can communicate with the WSL2 instance thanks to a virtual IP network. For this reason, to run graphical applications on WSL2, you
first need to install an X Server for Windows. Furthermore, you will need to configure your application to connect to the X Server that is running on the Windows host, you can do
so by adding the following lines in the `~/.bashrc` file of the WSL2 instance:
~~~
export WINDOWS_HOST=$(grep nameserver /etc/resolv.conf | awk '{print $2}')
export DISPLAY=${WINDOWS_HOST}:0.0
~~~
As unfortunately the IP addresses of the virtual IP network change at every reboot, it is also necessary to configure the X Server that you use to accept connection for arbitrary IP addresses. Check  [`doc/wsl2-xserver-configuration.md`](doc/wsl2-xserver-configuration.md) for instructions on how to do so on several X Servers.

#### Sanitize PATH enviroment variable for WSL2
By default, the `PATH` enviroment variable in WSL will contain the path of the host Windows system, see https://github.com/microsoft/WSL/issues/1640 and https://github.com/microsoft/WSL/issues/1493. This can create problems,
as the CMake in WSL may find (incompatible) Windows CMake packages and try to use them, creating errors due to the compilation.
To avoid that, you can add create in your WSL2 instance the `/etc/wsl.conf`, and then populate it with the following content:
~~~
[interop]
appendWindowsPath = false
~~~
Note that you will need to restart your machine to make sure that this setting is taked into account.

#### Connect to a YARP server on a Windows host on WSL2
If you want your YARP applications on WSL2 to connect to a `yarpserver` that you launched on the Windows host, you need to add the following line to your WSL's `~/.bashrc`:
~~~
yarp conf ${WINDOWS_HOST} 10000 > /dev/null 2>&1
~~~
where `WINDOWS_HOST` needs to be defined as in "Run graphical applications on WSL2" section.


### WSL1
With respect to WSL2, WSL1 uses the same IP address used by the Windows machine, so the amount of configuration and tweaks required are less.

#### Run graphical applications on WSL1
To run graphical applications on WSL, you need to install a X Server for Windows, that will be able to visualize the windows WSL-based applications, see https://www.howtogeek.com/261575/how-to-run-graphical-linux-desktop-applications-from-windows-10s-bash-shell/ for more info. For information of X Servers that can be installed on Windows, follow the docs in https://github.com/sirredbeard/Awesome-WSL#10-gui-apps .

#### Sanitize enviroment variables for WSL1
By default, the `PATH` enviroment variable in WSL will contain the path of the host Windows system, see https://github.com/microsoft/WSL/issues/1640 and https://github.com/microsoft/WSL/issues/1493. This can create problems,
as the CMake in WSL may find (incompatible) Windows CMake packages and try to use them, creating errors due to the compilation.
To avoid that, you can add the following line in the WSL `.bashrc` that filters all the Windows paths from the WSL's enviromental variables:
~~~
for var in $(env | awk {'FS="="} /\/mnt\//{print $1}'); do export ${var}=\"$(echo ${!var} | awk -v RS=: -v ORS=: '/\/mnt\// {next} {print $1}')\" ; done
~~~

## Update
If you are using the `robotology-superbuild` in its default branch and not from a release tag (i.e. in **rolling update** mode), to update the superbuild you need to first update the 
`robotology-superbuild` repository itself with the git command:
~~~
git pull
~~~

After that, you will need to also run the equivalent of `git pull` on all the repositories managed by
the robotology-superbuild, you have to run in your build system the appropriate target.

To do this, make sure to be in the `build` directory of the `robotology-superbuild` and run:
~~~
make update-all
make
~~~
using make on Linux or macOS or
~~~
cmake --build . --target ALL_UPDATE
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

By default, the `robotology-superbuild` uses the latest "stable" branches of the robotology repositories, but in some cases it may be necessary to use the "unstable" active development branches, or use some fixed tags. For this advanced functionalities, please refer to the documentation on changing the default project tags, available at [`doc/change-project-tags.md`](doc/change-project-tags.md).

FAQs
====

See also YCM documentation for [YCM's FAQs](http://robotology.github.io/ycm/gh-pages/git-master/manual/ycm-faq.7.html).
For questions related to how to modify the rootology-superbuild itself, such as how to add a new package, how to do a release, check
the Developers' FAQs document at [`doc/developers-faqs.md`](doc/developers-faqs.md).

### How do I pass CMake options to the projects built by the `robotology-superbuild` ?

When configuration the robotology-superbuild, you can pass the `YCM_EP_ADDITIONAL_CMAKE_ARGS` CMake option:
~~~
cmake -DYCM_EP_ADDITIONAL_CMAKE_ARGS:STRING="-DENABLE_yarpmod_SDLJoypad:BOOL=ON"
~~~
This option can be used to specify parameters that are passed to all CMake projects of the superbuild (as it is useful for some options, for example `-DBUILD_TESTING:BOOL=ON`).
This option can be used also for CMake options that are related to a single project, as all the other projects will ignore the option.

For more information on this option, see the [official YCM documentation](http://robotology.github.io/ycm/gh-pages/latest/manual/ycm-superbuild.7.html#specifying-additional-cmake-arguments-for-all-subprojects).

### How can I check the status of each subproject?

It is possible to run the bash script named ``robotologyGitStatus.sh`` in the ``scripts`` folder. For example, on linux, from the ``robotology-superbuild`` root run ``bash scripts/robotologyGitStatus.sh`` to print the status of each subproject.
This script can run from any directory, provided that the path to the ``robotologyGitStatus.sh`` script is given to ``bash``.

### I successfully used the `robotology-superbuild` for my project, how do I cite it in my publication?

The `robotology-superbuild` is based on [YCM](https://github.com/robotology/ycm), you can cite one of these papers:

* **A Build System for Software Development in Robotic Academic Collaborative Environments**,
  D.E. Domenichelli, S. Traversaro, L. Muratore, A. Rocchi, F. Nori, L. Natale,
  Second IEEE International Conference on Robotic Computing (IRC), 2018,
  https://doi.org/10.1109/IRC.2018.00014

* **A Build System for Software Development in Robotic Academic Collaborative Environments**,
  D.E. Domenichelli, S. Traversaro, L. Muratore, A. Rocchi, F. Nori, L. Natale,
  International Journal of Semantic Computing (IJSC), Vol. 13, No. 02, 2019


Mantainers
==========

| Profile  | Maintainer                     |
|:--------:|:-----------------------------:|
| Core, Dynamics, iCub Head, iCub Basic Demos | Silvio Traversaro [@traversaro](https://github.com/traversaro) |
| Teleoperation | Kourosh Darvish [@kouroshD](https://github.com/kouroshD) |
| Human Dynamics | Yeshasvi Tirupachuri [@Yeshasvitvs](https://github.com/Yeshasvitvs) |
| Event-driven | Arren Glover [@arrenglover](https://github.com/arrenglover) |
| Dynamics full deps | Giulio Romualdi [@GiulioRomualdi](https://github.com/GiulioRomualdi) |
