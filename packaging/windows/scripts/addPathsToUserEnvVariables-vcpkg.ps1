# Set a value to a given "User" enviromental variable
function Set-ValueToUserEnvVariable ($EnvVariable, $Value, $Verbose=$TRUE) {
  if ($Verbose) {
    Write-Host 'Set ' $Value ' to the ' $EnvVariable ' User enviroment variable.'
  }
  [System.Environment]::SetEnvironmentVariable($EnvVariable, $Value, 'User');
}

# Add a value to a given "User" enviromental variable
function Add-ValueToUserEnvVariable ($EnvVariable, $Value, $Verbose=$TRUE) {
  if ($Verbose) {
    Write-Host 'Appending ' $Value ' to the ' $EnvVariable ' User enviroment variable.'
  }
  $currVar = [System.Environment]::GetEnvironmentVariable($EnvVariable, 'User');
  # If the enviromental variable is currently empty, do not add an initial ";"
  if ([string]::IsNullOrEmpty($currVar)) {
    $newVar = $Value;
  } else {
    $newVar = $currVar + ';' + $Value;
  }
  [System.Environment]::SetEnvironmentVariable($EnvVariable, $newVar, 'User');
}

$parentPath = Split-Path -Path $PSCommandPath;
$vcpkgTriplet = 'x64-windows';
$vcpkgInstallDir = (Split-Path -parent $parentPath) + '\vcpkg\installed\' + $vcpkgTriplet;

# This logic mimics part of the logic contained in vcpkg\scripts\buildsystems\vcpkg.cmake
# to user enviroment variables. It has been tested only for a limited amount of vcpkg ports,
# and it is not officially maintained by the vcpkg team. To make sure that a dependency is correctly 
# found by CMake, use the official CMake vcpkg toolchain as documented in vcpkg docs.

# Extend PATH
Add-ValueToUserEnvVariable PATH ($VcpkgInstallDir + "\bin");
Add-ValueToUserEnvVariable PATH ($VcpkgInstallDir + "\debug\bin");

# Extend CMAKE_PREFIX_PATH
Add-ValueToUserEnvVariable CMAKE_PREFIX_PATH ($VcpkgInstallDir);
Add-ValueToUserEnvVariable CMAKE_PREFIX_PATH ($VcpkgInstallDir + "\debug");
