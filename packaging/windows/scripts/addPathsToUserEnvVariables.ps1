$installerRootPath = (Split-Path -parent (Split-Path -Path $PSCommandPath));

# Call the script to update the env variables of vcpkg 
$vcpkgTriplet = 'x64-windows';
$vcpkgScript = $installerRootPath + '\scripts\addPathsToUserEnvVariables-vcpkg.ps1'
Invoke-Expression $vcpkgScript

# Call robotology-superbuild script to update enviroment variables to find robotology-superbuild-installed software
$robotologyScript = $installerRootPath + '\robotology\share\robotology-superbuild\addPathsToUserEnvVariables.ps1'
Invoke-Expression $robotologyScript
