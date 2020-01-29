pushd %~dp0..
set installerRootPath=%cd%
popd

rem Call vcpkg script
call %installerRootPath%\scripts\setup-vcpkg.bat 

rem Call robotology-superbuild script
call %installerRootPath%\robotology\share\robotology-superbuild\setup.bat
