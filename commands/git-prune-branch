#!/bin/bash

# Deletes all the merged Git branches.

set -eu
set -o pipefail

readonly ESC=$(printf '\033')
readonly BLUE="${ESC}[34m"
readonly CYAN="${ESC}[36m"
readonly NO_COLOR="${ESC}[m"

git_delete_merged_branches() {
  git switch -q master

  local -r branches=$(git branch --merge | grep -v 'master')

  for branch in $branches; do
    git branch -q -d "$branch"
    echo "${BLUE}==> Deleted branch${NO_COLOR} ${CYAN}'${branch}'${NO_COLOR}"
  done
}

git_delete_squashed_branches() {
  git switch -q master

  local -r branches=$(git for-each-ref refs/heads/ "--format=%(refname:short)" | tr '\n' ' ')

  local merge_base
  for branch in $branches; do
    merge_base=$(git merge-base master "$branch")

    if [[ $(git cherry master "$(git commit-tree "$(git rev-parse "$branch"^'{tree}')" -p "$merge_base" -m _)") == "-"* ]]; then
      git branch -q -D "$branch"
      echo "${BLUE}==> Deleted branch${NO_COLOR} ${CYAN}'${branch}'${NO_COLOR}"
    fi
  done
}

git_prune_branches() {
  git_delete_merged_branches
  git_delete_squashed_branches
}

git_prune_branches "$@"
