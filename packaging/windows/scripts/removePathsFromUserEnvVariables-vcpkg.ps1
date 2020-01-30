# Remove a given "User" enviromental variable
function Remove-UserEnvVariable ($EnvVariable, $Verbose=$TRUE) {
  if ($Verbose) {
    Write-Host 'Removing ' $EnvVariable ' User enviroment variable.'
  }
  [System.Environment]::SetEnvironmentVariable($EnvVariable, $null, 'User');
}

# Remove a value from a given "User" enviromental variable
function Remove-ValueFromUserEnvVariable ($EnvVariable, $Value, $Verbose=$TRUE) {
  if ($Verbose) {
    Write-Host 'Removing ' $Value ' from the ' $EnvVariable ' User enviroment variable.'
  }
  $currVar = [System.Environment]::GetEnvironmentVariable($EnvVariable, 'User');
  # If the env variable is already empty, do not do anything
  if (-Not [string]::IsNullOrEmpty($currVar)) {
    $newVar = ($currVar.Split(';') | Where-Object { $_ -ne $Value }) -join ';';
    # If the resulting final variable is empty, delete the enviromental variable
    if ([string]::IsNullOrEmpty($newVar)) {
      [System.Environment]::SetEnvironmentVariable($EnvVariable, $null, 'User');
    } else {
      [System.Environment]::SetEnvironmentVariable($EnvVariable, $newVar, 'User');
    }
  }
}

$parentPath = Split-Path -Path $PSCommandPath;
$vcpkgTriplet = 'x64-windows';
$vcpkgInstallDir = (Split-Path -parent $parentPath) + '\vcpkg\installed\' + $vcpkgTriplet;

# Cleanup PATH
Remove-ValueFromUserEnvVariable PATH ($VcpkgInstallDir + "\bin");
Remove-ValueFromUserEnvVariable PATH ($VcpkgInstallDir + "\debug\bin");

# Cleanup CMAKE_PREFIX_PATH
Remove-ValueFromUserEnvVariable CMAKE_PREFIX_PATH ($VcpkgInstallDir);
Remove-ValueFromUserEnvVariable CMAKE_PREFIX_PATH ($VcpkgInstallDir + "\debug");
