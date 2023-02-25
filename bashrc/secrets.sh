#!/usr/bin/env bash

SECRETS_FILE='/tmp/my_secrets.sh'
SECRETS_PREFIX='MY__'

if [[ -z "$SECRETS_TEMPLATES_DIR" ]]; then
    echo "error: \$SECRETS_TEMPLATES_DIR not defined"
    return 1
fi

if [[ -r "$SECRETS_FILE" ]]; then
    # shellcheck source=/dev/null
    source "$SECRETS_FILE"
fi

secrets() {
    # If no arguments provided, remove the file
    if [[ -z "$*" ]]; then
        rm "$SECRETS_FILE"
        return $?
    fi

    # Ensure all arguments are readable files
    local paths=()
    for arg in "$@"
    do
        path="$SECRETS_TEMPLATES_DIR/$arg"
        if [[ ! -r "$path" ]]; then
            echo "Unable to read '$path'"
            return 1
        fi
        paths+=( "$path" )
    done

    # Concatenate, inject, and write file
    if (
        TOKEN="$(op signin --raw)" &&
        cat "${paths[@]}" | op inject --session "$TOKEN" > "$SECRETS_FILE"
    ); then
        # shellcheck source=/dev/null
        source "$SECRETS_FILE"
    else
        return $?
    fi
}

show_secrets_are_present() {
    local output=''
    if [[ -r "$SECRETS_FILE" ]]; then
        output="$output🔏"
    fi
    if (printenv | grep "$SECRETS_PREFIX" &> /dev/null); then
        output="$output🔓"
    fi
    if [[ -n "$output" ]]; then
        echo -n "$output "
    fi
}

_complete_secrets_command()
{
    local chars=${COMP_WORDS[COMP_CWORD]}
    options=$(ls -1 "$SECRETS_TEMPLATES_DIR")
    mapfile -t COMPREPLY < <(compgen -W "$options" -- "$chars")
}

complete -F _complete_secrets_command secrets
