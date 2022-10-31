#!/bin/bash

set -euo pipefail

OUT=docs
mkdir -p "$OUT"

CHECK_MODE=0

for ARG in "$@"; do
  if [[ $ARG == --check || $ARG == -c ]]; then
    CHECK_MODE=1
  fi
done

ERRORS=0

include_workflow () {
  ! grep "# docs: skip" "$1" >/dev/null
}

start_file () {
  local SOURCE="$1"
  echo -e "\e[1m$SOURCE\e[0m"
}

finalize_file () {
  local SOURCE="$1"
  local TMP="$2"
  local MD="$3"

  # Run prettier, since it might change how the file looks
  yarn run -s prettier --loglevel silent --write "$TMP"

  if [[ $CHECK_MODE -gt 0 ]]; then
    if ! diff "$MD" "$TMP" >/dev/null; then
      echo -e "\e[1;31m$SOURCE: not up to date!\e[0m"
      ERRORS=$((ERRORS + 1))
    else
      echo -e "\e[1;32m$SOURCE: up to date!\e[0m"
    fi

    rm "$TMP"
  else
    mv "$TMP" "$MD"
  fi
}

for WORKFLOW in .github/workflows/*-*.yml; do
  BASENAME="$(basename "$WORKFLOW" .yml)"
  KIND=$(cut -d- -f1 <<< "$BASENAME")
  NAME=$(cut -d- -f2- <<< "$BASENAME")

  # Skip workflows that are not part of the docs
  if ! include_workflow "$WORKFLOW"; then
    continue
  fi

  MD="$OUT/$BASENAME.md"
  TMP="$(mktemp --suffix=.md -p "$OUT")"

  start_file "$WORKFLOW"
  cat >"$TMP" <<EOT
# [$BASENAME](../.github/workflows/$BASENAME.yml)

![Workflow type: $KIND](https://img.shields.io/badge/workflow-$KIND-blue)
![Type: $NAME](https://img.shields.io/badge/type-$NAME-green)

EOT

  awk '\
    BEGIN { inc=1; } \
    !/^#/ { inc=0; exit } \
    /^#/ && inc { a=gensub(/^# ?/, "", "g", $0); print a }' \
    "$WORKFLOW" >>"$TMP"

  finalize_file "$WORKFLOW" "$TMP" "$MD"
done

# Check for obsolete files in docs/
for MD_FILE in docs/*-*.md; do
  WORKFLOW=".github/workflows/$(basename "$MD_FILE" .md).yml"
  if [[ ! -f "$WORKFLOW" ]]; then
    if [[ $CHECK_MODE -gt 0 ]]; then
      echo -e "\e[1;31m$MD_FILE: does not correspond to any workflow!\e[0m"
      ERRORS=$((ERRORS + 1))
    else
      rm "$MD_FILE"
    fi
  fi
done

MD="$OUT/README.md"
TMP="$(mktemp --suffix=.md -p "$OUT")"

start_file README.md
cat >"$TMP" <<EOT
# Reusable workflows index

EOT

for KIND in $(find .github/workflows -name "*-*.yml" -printf '%f\n' \
    | cut -d- -f1 \
    | sort -u); do
  COUNT=0
 
  for WORKFLOW in $(find .github/workflows -name "$KIND-*.yml" | sort); do
    BASENAME="$(basename "$WORKFLOW" .yml)"
    NAME=$(cut -d- -f2- <<< "$BASENAME")

    if include_workflow "$WORKFLOW"; then
      if [[ $COUNT -eq 0 ]]; then
        echo -e "## ${KIND^} workflows\n" >>"$TMP"
      fi

      echo "- [$BASENAME]($BASENAME.md)" >>"$TMP"
      COUNT=$((COUNT + 1))
    fi
  done
done

finalize_file README.md "$TMP" "$MD"

exit $ERRORS
