pushd %~dp0..
set "installerRootPath=%cd%"
popd

set "vcpkgTriplet=windows-x64"
set "vcpkgInstallDir=%installerRootPath%\vcpkg\installed\%vcpkgTriplet%"

rem Update PATH 
set "PATH=%PATH%;%vcpkgInstallDir%\bin"
set "PATH=%PATH%;%vcpkgInstallDir%\debug\bin"

rem Update CMAKE_PREFIX_PATH
set "CMAKE_PREFIX_PATH=%CMAKE_PREFIX_PATH%;%vcpkgInstallDir%"
set "CMAKE_PREFIX_PATH=%CMAKE_PREFIX_PATH%;%vcpkgInstallDir%\debug"