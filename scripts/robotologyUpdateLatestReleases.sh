#!/bin/bash

# Script to automatically update the latest.releases.yaml file
# With the latest tag done on the stable branches of a given repo

# To run it locally, download yq binary from https://github.com/mikefarah/yq
# rename it to yq, and put it in a directory that you add to the path.
# Then, navigate to robotology-superbuild dir and execute in Bash:
# ./scripts/robotologyUpdateLatestReleases.sh
# Warning: if you run, it will update the tags only of the repos
# that are enabled and downloaded, so it is intendend to run after all the
# components and options have been enabled, and after the update-all target
# has been run

# This array contains the project that for a given reason should not be updated by this script
# ICUBcontrib is here as it has several coincident tags, and the script currently is not able
# to get the last one
# External repos are in the list as we updated them manually
projects_to_skip=("ICUBcontrib" "qhull" "CppAD" "casadi" "manif" "osqp")

getParentDir () {
    SOURCE="${1}"
    while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
      DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
      SOURCE="$(readlink "$SOURCE")"
      [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
    done
    DIR="$( cd -P "$( dirname "$SOURCE" )" >/dev/null 2>&1 && pwd )"
}

getParentDir "${BASH_SOURCE[0]}"

script_dir="$DIR"

getParentDir $script_dir

superbuild_root="$DIR"

subdirs="$superbuild_root/src"

latest_releases_yaml_file="$superbuild_root/releases/latest.releases.yaml"

# Check if element is in array
# https://stackoverflow.com/a/8574392
containsElement () {
  local e match="$1"
  shift
  for e; do [[ "$e" == "$match" ]] && return 0; done
  return 1
}

updateLatestRelease () {
    cd $1
    # Extract package name
    package_name=`basename $1`
    # Check if package is in skip list
    containsElement "$package_name" "${projects_to_skip[@]}"
    is_contained=$?
    if [ $is_contained == 1 ]
    then
        # Extract latest tag
        latest_tag=`git describe --abbrev=0 --tags`
        # Update latest tag in latest-release.yaml file,
        # using https://github.com/mikefarah/yq
        # Only update non-empty tag
        if [ ! -z "$latest_tag" ]
        then
            echo "Setting ${package_name} tag to ${latest_tag} ."
            yq -i eval ".repositories.${package_name}.version=\"${latest_tag}\"" ${latest_releases_yaml_file}
        fi
    else
        echo "Skipping update of ${package_name} as it is in the list of projects to skip."
    fi
}

for subdir in ${subdirs}; do \
    if [ -d "${subdir}" ] ; then
        for i in ${subdir}/*/; do \
            updateLatestRelease $i
        done
    fi
done

