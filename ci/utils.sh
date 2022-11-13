#!/bin/bash

dry_run () {
  echo "$@"
  if [[ $DRY_RUN == 0 ]]; then
    "$@"
  fi
}
