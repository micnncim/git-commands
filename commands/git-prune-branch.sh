#!/bin/bash

# Deletes all the merged git branches.

set -e

ESC=$(printf '\033')
BLUE="${ESC}[34m"
CYAN="${ESC}[36m"
NO_COLOR="${ESC}[m"

git-delete-merged-branch() {
  git switch -q master

  branches=$(git branch --merge | grep -v 'master')

  for branch in $branches; do
    git branch -q -d "$branch"
    echo "${BLUE}==> Deleted branch${NO_COLOR} ${CYAN}'${branch}'${NO_COLOR}"
  done
}

git-delete-squashed-branch() {
  git switch -q master

  branches=$(git for-each-ref refs/heads/ "--format=%(refname:short)" | tr '\n' ' ')

  for branch in $branches; do
    mergeBase=$(git merge-base master "$branch")
    if [[ $(git cherry master "$(git commit-tree "$(git rev-parse "$branch"^'{tree}')" -p "$mergeBase" -m _)") == "-"* ]]; then
      git branch -q -D "$branch"
      echo "${BLUE}==> Deleted branch${NO_COLOR} ${CYAN}'${branch}'${NO_COLOR}"
    fi
  done
}

git-prune-branch() {
  git-delete-merged-branch
  git-delete-squashed-branch
}

git-prune-branch
