Unsupported Homebrew Installation
=================================

**IMPORTANT: This document describes installation with Homebrew, that is not currently supported and not tested in Continuous Integration. PR to fix errors or problems are welcome, but not mantainance is done on this documentation by robotology-superbuild mantainers.** 

## macOS from source using Homebrew dependencies 

### System Dependencies
To install the system dependencies, it is possible to use [Homebrew](http://brew.sh/):
```
brew install ace assimp bash-completion boost cmake eigen graphviz gsl ipopt jpeg-turbo libedit nlohmann-json opencv pkg-config portaudio qt@5 sqlite swig tinyxml tinyxml2 libmatio irrlicht spdlog qhull zlib ffmpeg
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
