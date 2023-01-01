#!/bin/bash

set -eu

source "$(dirname "${BASH_SOURCE[0]}")/utils.sh"

while getopts ":nc" opt; do
  case "$opt" in
    n)
      DRY_RUN=1
      ;;
    c)
      CHECK_MODE=1
      ;;
    *)
      ;;
  esac
done

if [[ ! -v DRY_RUN ]]; then
  DRY_RUN=0
fi

if [[ ! -v CHECK_MODE ]]; then
  CHECK_MODE=0
fi

ERRORS=0

for ACTION in actions/*; do
  HEAD_REF=$(git log --format=%H "$ACTION" | head -1)
  echo "$ACTION: $HEAD_REF"

  if [[ $CHECK_MODE == 1 ]]; then
    # Check that there are no references to the outdated action
    readarray -t OUTDATED_FILES < <(grep -P "vtavernier/github-workflows/$ACTION@(?!$HEAD_REF)" -r -n .github/workflows actions/*/action.yml)
    for FILE in "${OUTDATED_FILES[@]}"; do
      echo "::error file=$(awk -F: '{print $1}' <<< "$FILE"),line=$(awk -F: '{print $2}' <<< "$FILE")::$ACTION pinned version is outdated. Latest version: $HEAD_REF. Current version in dependent: $(awk -F@ '{print $NF}' <<< "$FILE")"

      ERRORS=$((ERRORS + 1))
    done
  else
    # Replace the reference to the action with the pinned commit
    dry_run sed -i "s#\(vtavernier/github-workflows/$ACTION@\)[^ ]*#\1$HEAD_REF#g" \
      .github/workflows/*.yml actions/*/action.yml
  fi
done

exit $ERRORS
