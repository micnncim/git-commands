#!/bin/bash
# Copyright 2020 micnncim
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.


# Deletes the squash-merged git branches.
#
# This file contains the modified content of https://github.com/not-an-aardvark/git-delete-squashed.

set -e

ESC=$(printf '\033')

git-delete-squash-merged-branches() {
    git checkout -q master
    branches=$(git for-each-ref refs/heads/ "--format=%(refname:short)" | tr '\n' ' ')

    for branch in $branches; do
        mergeBase=$(git merge-base master "$branch")
        if [[ $(git cherry master "$(git commit-tree "$(git rev-parse "$branch"^'{tree}')" -p "$mergeBase" -m _)") == "-"* ]]; then
            ask "$(green '>>>') Are you sure to delete branch $(cyan \'"${branch}"\')?" || continue
            # git branch -D "$branch" > /dev/null 2>&1
            echo "$(green '==>') Deleted branch $(cyan \'"${branch}"\')"
        fi
    done
}

ask() {
    local message input
    message="${1:-Are you sure?}"

    while true
    do
        read -r -p "${message} [Y/n] " input
        case "${input}" in
            Y)
                return 0
                ;;
            n)
                return 1
                ;;
            *)
                echo "Invalid input... again" >&2
                ;;
        esac
    done
}

green() {
    message=$1
    echo -n "${ESC}[32m${message}${ESC}[m"
}

cyan() {
    message=$1
    echo -n "${ESC}[36m${message}${ESC}[m"
}

git-delete-squash-merged-branches
