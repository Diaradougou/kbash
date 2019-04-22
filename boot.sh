#!/bin/bash
# this is the entrypoint for activating the KBASH environment

# see docs for detailed explanation of the four startup variables
ENTRYPOINT=$1
VAR_PREFIX=$2
USER_UTIL_LOAD_LIST=$3
LANG_LOAD_LIST=$4

if [ -z "${!VAR_PREFIX}" ]; then
  echo "The $VAR_PREFIX variable is not set - this must be set in activate"
else
  # load functions used during bootstrap
  if [ ! -f "$KBASH/os.sh" ]; then
    echo "Can not find OS utilities, looking in $KBASH/os.sh"
  else
    # import basic OS coupling as well as kbash_trace function, for use in
    # debugging the KBASH startup
    . $KBASH/os.sh

    # load core modules, in order - each can use the features defined in the
    # earlier entries
    kbash_trace loading-core-modules "$KBASH_CORE"
    for CORE_MODULE in \
        "state"\
        "output"\
        "fs"\
        "lists"\
        "help"\
        "load_functions_from_dir"\
        "lang"\
        "path"\
        "shell_integrate"\
        "slugs"\
        ; do
            kbash_trace load-core-module "$CORE_MODULE"
            . ${KBASH_CORE}/${CORE_MODULE}.sh
    done

    # integrate API modules, these will be filtered against ENTRYPOINT
    # and VAR_PREFIX variables
    kbash_trace integrate-api-modules "$KBASH_API"
    for API_MODULE in \
      "cli/state"\
      "cli/completion"\
      "cli/count"\
      "cli/reprompt"\
      "cli/classify"\
      "cli/process_command_scope"\
      "cli/process_command_scope_visitor"\
      "cli/entrypoint"\
      "help/print_main_help"\
      "help/print_scope_help_summary"\
      "help/print_component_help_summary"\
      "help/print_function_help"\
      "help/print_function_help_summary"\
      "components/driver/load_component"\
      "components/driver/load_components"\
      "components/driver/run_component_func"\
      "components/help/help_on_empty_or_help"\
      "components/help/print_component_list"\
      "components/help/print_component_help"\
      "components/parallel";
    do
      kbash_trace loading-api-module "${API_MODULE}.sh"
      kbash_shell_integrate "$ENTRYPOINT" "$VAR_PREFIX" "${KBASH_API_UTIL_DIR}/${API_MODULE}.sh"
    done

    # load any standard system modules specified.  This is typically
    # used to load language or tool specific support which may or may
    # not be felevant to the $PROJECT in scope
    kbash_trace loading-kbash-functions "$KBASH_API_FUNCTION_DIR"
    kbash_load_functions_from_dir "$ENTRYPOINT" "$VAR_PREFIX" "$KBASH_API_FUNCTION_DIR"

    for LANGUAGE in $LANG_LOAD_LIST; do
      kbash_trace loading-language-module "$KBASH_LANG/$LANGUAGE"
      kbash_shell_integrate "$ENTRYPOINT" "$VAR_PREFIX" "$KBASH_LANG/$LANGUAGE.sh"
      kbash_register_language "$LANGUAGE"
    done

    # load the user environment from $PROJECT/bashenv.  This is typically
    # used to load support for concepts unique to $PROJECT.
    for FUNCTION_FILE in $USER_LOAD_LIST; do
      kbash_trace load-project-util "${!BASHENV_VAR}/$FUNCTION_FILE"
      kbash_shell_integrate "$ENTRYPOINT" "$VAR_PREFIX" "${!VAR_PREFIX}/util/$FUNCTION_FILE"
    done

    kbash_trace loading-project-functions
    kbash_load_functions_from_dir "$ENTRYPOINT" "$VAR_PREFIX" "${!VAR_PREFIX}/kbash/functions"

    # thes
    ${ENTRYPOINT}_load_components

    # cd into the directory named by the variable named by VAR_PREFIX.
    cd ${!VAR_PREFIX}
  fi
fi