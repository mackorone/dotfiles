#!/usr/bin/env bash

SECRETS_FILE='/tmp/my_secrets.sh'
SECRETS_PREFIX='MY__'

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
    for arg in "$@"
    do
        if [[ ! -r "$arg" ]]; then
            echo "Unable to read '$arg'"
            return 1
        fi
    done

    # Concatenate, inject, and write file
    if (
        TOKEN="$(op signin --raw)" &&
        cat "$@" | op inject --session "$TOKEN" > "$SECRETS_FILE"
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
