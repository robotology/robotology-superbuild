scriptDirectory="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
installerRootPath=`realpath $scriptDirectory/..`

# Source deps script
source $installerRootPath/scripts/setup-deps.sh

# Source robotology-superbuild script (if it exists)
robotologyScript=$installerRootPath/robotology/share/robotology-superbuild/setup.sh
if test -f "$robotologyScript"; then
    source $robotologyScript
fi
