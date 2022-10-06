Deprecated Installation Methods
===============================

This documentation page contains some deprecated installation methods, that while working fine at the moment, may be discontinued in the future.

Table of Contents
=================

* [Binary Installation](#binary-installation)
  * [Windows installed generated with vcpkg dependencies](#windows-from-binary-installer-generated-with-vcpkg-dependencies)
* [Source Installation](#source-installation)
  * [macOS using Homebrew dependencies](#macos-from-source-using-homebrew-dependencies)
  * [Windows using pre-compiled vcpkg dependencies](#windows-from-source-using-vcpkg-dependencies)


Binary Installation
===================

## Windows from binary installer generated with vcpkg dependencies

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

Once you cloned the repo, to go forward you can follow the different deprecated instructions on how to install robotology-superbuild from the source code, depending on your operating system:
* [**macOS using Homebrew dependencies**](#macos-from-source-using-homebrew-dependencies)
* [**Windows using vcpkg dependencies**](#windows-from-source-using-vcpkg-dependencies)

When compiled from source, `robotology-superbuild` will download and build a number of software.
For each project, the repository will be downloaded in the `src/<package_name>` subdirectory of the superbuild root. 
The build directory for a given project will be instead the `src/<package_name>` subdirectory of the superbuild build directory. 
All the software packages are installed using the `install` directory of the build as installation prefix.

## macOS from source using Homebrew dependencies 

### System Dependencies
To install the system dependencies, it is possible to use [Homebrew](http://brew.sh/):
```
brew install ace assimp bash-completion boost cmake eigen graphviz gsl ipopt jpeg libedit nlohmann-json opencv pkg-config portaudio qt@5 sqlite swig tinyxml libmatio irrlicht spdlog qhull ffmpeg
```

Since Qt5 is not symlinked in `/usr/local` by default in the homebrew formula, `Qt5_DIR` needs to be properly set to make sure that CMake-based projects are able to find Qt5.
```
export Qt5_DIR=/usr/local/opt/qt5/lib/cmake/Qt5
```

If you want to enable a [profile](cmake-options.md#profile-cmake-options) or a [dependency](cmake-options.md#dependencies-cmake-options) specific CMake option, you may need to install additional system dependencies following the dependency-specific documentation (in particular, the `ROBOTOLOGY_USES_GAZEBO` option is enabled by default, so you should disable it as it is not supported on macOS with Homebrew dependencies):
* [`ROBOTOLOGY_USES_GAZEBO`](cmake-options.md#gazebo)

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

If for any reason you do not want to use the provided `setup.sh` script and you want to manage your enviroment variables manually, please refer to the documentation available at [`doc/environment-variables-configuration.md `](environment-variables-configuration.md).

## Windows from source using vcpkg dependencies

### System Dependencies
As Windows does not have a widely used system [package manager](https://en.wikipedia.org/wiki/Package_manager) such as the one that are available on Linux or macOS, installing the system dependencies is slightly more complicated. However, we try to document every step necessary for the installation, but if you find something that you don't understand in the documentation, please [open an issue](https://github.com/robotology/robotology-superbuild/issues/new).  

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
or creating the directories and extracting the archive through the File Explorer. If you prefer to use your own vcpkg to install the dependencies of the superbuild, please refer to the documentation available at [`doc/vcpkg-dependencies.md`](vcpkg-dependencies.md).

If you want to enable the `ROBOTOLOGY_USES_GAZEBO` option, you will need to download and extract the `vcpkg-robotology-with-gazebo.zip` archive. For instructions on how to correctly use this archives, please refer to documentation of the [`robotology-superbuild-dependencies-vcpkg`](https://github.com/robotology/robotology-superbuild-dependencies-vcpkg) repo.

If you want to enable a [profile](cmake-options.md#profile-cmake-options) or a [dependency](cmake-options.md#dependencies-cmake-options) specific CMake option, you may need to install additional system dependencies following the dependency-specific documentation:
* [`ROBOTOLOGY_USES_OCULUS_SDK`](cmake-options.md#oculus)
* [`ROBOTOLOGY_USES_CYBERITH_SDK`](cmake-options.md#cyberith)
* [`ROBOTOLOGY_USES_XSENS_MVN_SDK`](cmake-options.md#xsens)
* [`ROBOTOLOGY_USES_ESDCAN`](cmake-options.md#shoes)

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

If for any reason you do not want to use the provided scripts and you want to manage your enviroment variables manually, for example because you want to cleanup the enviroment variables modified by `addPathsToUserEnvVariables.ps1`  and you delete the corresponding `removePathsFromUserEnvVariables.ps1`, please refer to the documentation available at [`doc/environment-variables-configuration.md `](environment-variables-configuration.md).

 **If you have problems in Windows in launching executables or using libraries installed by superbuild, it is possible that due to some existing software on your machine your executables are not loading the correct `dll` for some of the dependencies. This is the so-called [DLL Hell](https://en.wikipedia.org/wiki/DLL_Hell#Causes), and for example it can happen if you are using the [Anaconda](https://www.anaconda.com/) Python distribution on your Windows installation.  To troubleshoot this kind of problems, you can open the library or executable that is not working correctly using the [`Dependencies`](https://github.com/lucasg/Dependencies) software. This software will show you which DLL your executable or library is loading. If you have any issue of this kind and need help, feel free to [open an issue in our issue tracker](https://github.com/robotology/robotology-superbuild/issues/new).**


