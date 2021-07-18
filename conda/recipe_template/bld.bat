{% if source_subdir is defined and source_subdir|length %}
cd {{ source_subdir }}
{% endif %}

mkdir build
cd build

:: Hardcoding Visual Studio 2019 as GitHub Actions does not have VS2019
:: -DBUILD_SHARED_LIBS=ON for now disabled as a workaround for https://github.com/robotology/icub-main/issues/717 
cmake ^
    -G"Visual Studio 16 2019" ^
    -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
    -DCMAKE_PREFIX_PATH=%LIBRARY_PREFIX% ^
    -DCMAKE_BUILD_TYPE=Release ^
    -DCMAKE_VERBOSE_MAKEFILE=OFF ^
    -DCMAKE_INSTALL_LIBDIR=lib ^
{% for cmake_arg in cmake_args %}    {{ cmake_arg }} ^
{% endfor %}    %SRC_DIR%
if errorlevel 1 exit 1

:: Build.
cmake --build . --config Release --parallel %CPU_COUNT%
if errorlevel 1 exit 1

:: Install.
cmake --build . --config Release --target install
if errorlevel 1 exit 1

{% if copy_activation_scripts is sameas true %}
setlocal EnableDelayedExpansion
:: Copy the [de]activate scripts to %PREFIX%\etc\conda\[de]activate.d.
:: This will allow them to be run on environment activation.
for %%F in (activate deactivate) DO (
    if not exist %PREFIX%\etc\conda\%%F.d mkdir %PREFIX%\etc\conda\%%F.d
    copy %RECIPE_DIR%\%%F.bat %PREFIX%\etc\conda\%%F.d\%PKG_NAME%_%%F.bat
    if %errorlevel% neq 0 exit /b %errorlevel%

    copy %RECIPE_DIR%\%%F.sh %PREFIX%\etc\conda\%%F.d\%PKG_NAME%_%%F.sh
    if %errorlevel% neq 0 exit /b %errorlevel%

    copy %RECIPE_DIR%\%%F.bash %PREFIX%\etc\conda\%%F.d\%PKG_NAME%_%%F.bash
    if %errorlevel% neq 0 exit /b %errorlevel%

    copy %RECIPE_DIR%\%%F.ps1 %PREFIX%\etc\conda\%%F.d\%PKG_NAME%_%%F.ps1
    if %errorlevel% neq 0 exit /b %errorlevel%

    copy %RECIPE_DIR%\%%F.xsh %PREFIX%\etc\conda\%%F.d\%PKG_NAME%_%%F.xsh
    if %errorlevel% neq 0 exit /b %errorlevel%

    copy %RECIPE_DIR%\%%F.zsh %PREFIX%\etc\conda\%%F.d\%PKG_NAME%_%%F.zsh
    if %errorlevel% neq 0 exit /b %errorlevel%
)
{% endif %}
