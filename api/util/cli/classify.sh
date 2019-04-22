#!/bin/bash
function ENTRYPOINT_classify() {
  local DIR=$1
  local PROBE=$2
  if [ -f "$DIR/$PROBE/.scope.sh" ]; then
    echo "scope"
  else
    if [ -f "$DIR/$PROBE.sh" ]; then
      echo "file"
    else
      echo "other"
    fi
  fi
}
export -f ENTRYPOINT_classify