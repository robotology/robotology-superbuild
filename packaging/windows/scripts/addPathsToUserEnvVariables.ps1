$installerRootPath = (Split-Path -parent (Split-Path -Path $PSCommandPath));

# Call the script to update the env variables of the deps
$depsScript = $installerRootPath + '\scripts\addPathsToUserEnvVariables-deps.ps1'
Invoke-Expression $depsScript

# Call robotology-superbuild script to update enviroment variables to find robotology-superbuild-installed software (if it exists)
$robotologyScript = $installerRootPath + '\robotology\share\robotology-superbuild\addPathsToUserEnvVariables.ps1'
if ((Test-Path $robotologyScript)) {
  Invoke-Expression $robotologyScript
}
