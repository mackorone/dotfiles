#!/usr/bin/env bash

DIR=$(dirname "${BASH_SOURCE[0]}")

FILES=(
    'one_password_cli.sh'
    'secrets.sh'
    'virtual_env.sh'
    # Last to ensure helper functions are defined
    'prompt.sh'
)

for file in "${FILES[@]}"; do
    # shellcheck source=/dev/null
    source "$DIR/$file"
done

# https://github.com/direnv/direnv/blob/master/docs/hook.md
eval "$(direnv hook bash)"
