pushd %~dp0..
set installerRootPath=%cd%
popd

rem Call deps script
call %installerRootPath%\scripts\setup-deps.bat

rem Call robotology-superbuild script (if it exists)
set robotologyScript=%installerRootPath%\robotology\share\robotology-superbuild\setup.bat
if exist %robotologyScript% call %robotologyScript%

