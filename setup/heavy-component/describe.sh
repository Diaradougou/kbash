#!/bin/bash


export COMPONENT_VAR_PREFIX_BASE=$VAR_PREFIX/COMPONENT_NAME
export COMPONENT_VAR_PREFIX_NODE_VERSION=
export COMPONENT_VAR_PREFIX_NODE_MODULES=$COMPONENT_VAR_PREFIX_BASE/node_modules

export COMPONENT_VAR_PREFIX_LERNA_PACKAGES=$COMPONENT_VAR_PREFIX_BASE/packages

export COMPONENT_VAR_PREFIX_PYTHON_VERSION=
export COMPONENT_VAR_PREFIX_VENV=$COMPONENT_VAR_PREFIX_BASE/venv

export COMPONENT_VAR_PREFIX_LOG=$COMPONENT_VAR_PREFIX_BASE/setup-logs

oneline_description_of_ENTRYPOINT_COMPONENT_NAME() {
  echo "Description of COMPONENT_NAME"
}
export -f oneline_description_of_ENTRYPOINT_COMPONENT_NAME

vet_environment_ENTRYPOINT_COMPONENT_NAME() {
  echo "Component[COMPONENT_NAME]:vet"
}
export -f vet_environment_ENTRYPOINT_COMPONENT_NAME

describe_environment_ENTRYPOINT_COMPONENT_NAME_help() {
printf "`cat << EOF
${BLUE}ENTRYPOINT describe COMPONENT_NAME${NC}

EOF
`\n"
}
export -f describe_environment_ENTRYPOINT_COMPONENT_NAME_help

describe_environment_ENTRYPOINT_COMPONENT_NAME() {
  echo "Component[COMPONENT_NAME]:describe"

  report_vars "COMPONENT_NAME Build Environment" \
      COMPONENT_VAR_PREFIX_BASE\
      COMPONENT_VAR_PREFIX_NODE_VERSION\
      COMPONENT_VAR_PREFIX_PYTHON_VERSION
}
export -f describe_environment_ENTRYPOINT_COMPONENT_NAME
