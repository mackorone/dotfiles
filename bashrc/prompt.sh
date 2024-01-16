#!/usr/bin/env bash

COLOR_LIGHT_RED='\[\e[1;31m\]'
COLOR_TURQUOISE='\[\e[0;36m\]'
COLOR_RESET='\[\e[m\]'

print_if_nonzero() {
    local value="$1"
    if [ "$value" != 0 ]; then
        # shellcheck disable=SC2028
        echo "${COLOR_LIGHT_RED}[$value]${COLOR_RESET} \n"
    fi
}

prompt_command() {
    local exit_code="$?"
    local prompt=''
    prompt+="$(print_if_nonzero $exit_code)"
    prompt+="$(show_secrets_are_present)"
    prompt+="$(show_virtual_env)"
    prompt+="${COLOR_TURQUOISE}{\W}\$${COLOR_RESET} "
    export PS1="$prompt"
}

export PROMPT_COMMAND=prompt_command
