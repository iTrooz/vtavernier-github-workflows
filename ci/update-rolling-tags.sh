#!/bin/bash

set -euo pipefail

source "$(dirname "${BASH_SOURCE[0]}")/utils.sh"

while getopts ":n" opt; do
  case "$opt" in
    n)
      DRY_RUN=1
      ;;
    *)
      ;;
  esac
done

if [[ ! -v DRY_RUN ]]; then
  DRY_RUN=0
fi

if [[ ! -v VERSION_TAGS ]]; then
  VERSION_TAGS=$(git tag --sort version:refname -l 'v*.*.*' | awk '!/alpha|beta/ {print}')
fi

CREATED_TAGS=()

git_tag () {
  dry_run git tag -f "$@"
  CREATED_TAGS+=("$1")
}

git_push_tags () {
  if ((${#CREATED_TAGS[@]})); then
    dry_run git push --force "$@" "${CREATED_TAGS[@]}"
  fi
}

# Tag major versions
CURRENT_MAJOR=0
LAST_TAG=""
for TAG in $VERSION_TAGS; do
  TAG_MAJOR=$(awk -F'[v.]' '{print $2}' <<< "$TAG")

  if [[ $CURRENT_MAJOR != 0 && $CURRENT_MAJOR != "$TAG_MAJOR" ]]; then
    git_tag "v$CURRENT_MAJOR" "$LAST_TAG"
  fi

  LAST_TAG=$TAG
  CURRENT_MAJOR=$TAG_MAJOR
done

if [[ $LAST_TAG != "" ]]; then
  git_tag "v$CURRENT_MAJOR" "$LAST_TAG"
fi

# Tag minor versions
CURRENT_MINOR=0
LAST_TAG=""
for TAG in $VERSION_TAGS; do
  TAG_MINOR=$(awk -F'[v.]' '{print $2 "." $3}' <<< "$TAG")

  if [[ $CURRENT_MINOR != 0 && $CURRENT_MINOR != "$TAG_MINOR" ]]; then
    git_tag "v$CURRENT_MINOR" "$LAST_TAG"
  fi

  LAST_TAG=$TAG
  CURRENT_MINOR=$TAG_MINOR
done

if [[ $LAST_TAG != "" ]]; then
  git_tag "v$CURRENT_MINOR" "$LAST_TAG"
fi

git_push_tags origin
