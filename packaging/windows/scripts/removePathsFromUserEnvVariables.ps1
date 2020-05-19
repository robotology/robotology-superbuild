$installerRootPath = (Split-Path -parent (Split-Path -Path $PSCommandPath));

# Call the script to cleanup the env variables of deps
$depsScript = $installerRootPath + '\scripts\removePathsFromUserEnvVariables-vcpkg.ps1'
Invoke-Expression $depsScript

# Call robotology-superbuild script to cleanup enviroment variables (if it exists)
$robotologyScript = $installerRootPath + '\robotology\share\robotology-superbuild\removePathsFromUserEnvVariables.ps1'
if ((Test-Path $robotologyScript)) {
  Invoke-Expression $robotologyScript
}
