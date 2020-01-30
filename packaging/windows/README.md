# Scripts for generating Windows installer for robotology-superbuild software

Windows installer for robotology dependencies and software contained in the robotology-superbuild.

## Caveats 
The generated installer only supports Visual Studio 2019 and 64-bit binaries.
As many of the software contained in the installer are not relocatable, at the moment it only supported to 
install the software to the `C:\robotology` . 

## Usage 

### Dependencies 
* CMake >= 3.14 
* Qt Installer Framework >= 3.2.0 (download from https://download.qt.io/official_releases/qt-installer-framework/ and make sure that the QtIFW  binaries are in the PATH)

### Generation steps 

#### vcpkg
* Install (or download from https://github.com/robotology-playground/robotology-superbuild-dependencies) a vcpkg installation with the necessary dependencies in `C:\robotology\vcpkg`.

#### robotology-superbuild
* Download the robotology-superbuild somewhere in your system (for example `C:\robotology-superbuild`) and configure to install it to `C:\robotology\robotology` via YCM_EP_INSTALL_DIR, with the option that you prefer:
~~~
cd C:\
git clone -b <used_tag> https://github.com/robotology/robotology-superbuild
cd robotology-superbuild
mkdir build
cd build
cmake -A x64 -DCMAKE_TOOLCHAIN_FILE=C:\robotology\vcpkg\scripts\buildsystems\vcpkg.cmake -DYCM_EP_INSTALL_DIR=C:\robotology\robotology -DROBOTOLOGY_PROJECT_TAGS=Custom -DROBOTOLOGY_PROJECT_TAGS_CUSTOM_FILE=<CustomFile> -DROBOTOLOGY_ENABLE_DYNAMICS:BOOL=ON ..
~~~
* Compile the project first in Debug, and then in Release, to install both the Debug and Release version of the libraries, but shipping just the Release version of the executables:
~~~
cmake --build . --config Debug
cmake --build . --config Release
~~~

#### Generate IFW installer 
* Clone this repo, and configure it via CMake:
~~~
cd C:\robotology-superbuild\packaging\windows
mkdir build 
cd build
cmake -A x64 ..
~~~
* Build the `PACKAGE` target to generate the installer: 
~~~
cmake --build . --target PACKAGE
~~~
This will create a `robotology-installer-<version>-win64.exe` installer in the build directory.