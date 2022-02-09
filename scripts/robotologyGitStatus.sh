#!/bin/bash

# Get the parent dir https://stackoverflow.com/a/246128

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

printGitStatus () {
    echo "--------------------------------------------"
    (cd $1 && echo -n "${1}: " \
    && git rev-parse --abbrev-ref HEAD \
    && git log -1 --format="%cr|%s|%H" \
    && git status -sb); \
}

if [ -d "${superbuild_root}" ] ; then
    printGitStatus $superbuild_root
fi

for subdir in ${subdirs}; do \
    if [ -d "${subdir}" ] ; then
        for i in ${subdir}/*/; do \
            printGitStatus $i
        done
    fi
done
echo "--------------------------------------------"

