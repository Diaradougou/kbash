#!/bin/bash

if [ -z "$VAR_PREFIX_ACTIVATION_COUNT" ]; then
  VAR_PREFIX_ACTIVATION_COUNT=0
  export VAR_PREFIX_ORIGINAL_PATH=$PATH
else
  VAR_PREFIX_ACTIVATION_COUNT=$(expr $VAR_PREFIX_ACTIVATION_COUNT + 1 )
fi
export VAR_PREFIX_ACTIVATION_COUNT
