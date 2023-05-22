#!/usr/bin/env bash

if [[ -z "$BLOG_DIR" ]]; then
    echo "error: \$BLOG_DIR not defined"
    return 1
fi

if [[ -z "$BLOG_COMMAND" ]]; then
    echo "error: \$BLOG_COMMAND not defined"
    return 1
fi

blog_command() {
    local command="$1"
    shift
    if [[ -z "$command" ]]; then
        # shellcheck disable=SC2164
        cd "$BLOG_DIR"
        return
    fi
    if [[ "$command" = "edit" ]]; then
        if (( ! $# )); then
            echo "error: no arguments specified"
            return 1
        fi
        local paths=()
        for arg in "$@"; do
            local matches=()
            for match in $(_blog_get_post_matches "$arg"); do
                matches+=( "$match" )
            done
            if (( ! ${#matches[@]} )); then
                matches+=( "$(_blog_get_new_post_path "$arg")" )
            fi
            paths+=( "${matches[@]}" )
        done
        $EDITOR "${paths[@]}"
    elif [[ "$command" = "touch" ]]; then
        if (( ! $# )); then
            echo "error: no arguments specified"
            return 1
        fi
        for arg in "$@"; do
            local matches=()
            for match in $(_blog_get_post_matches "$arg"); do
                matches+=( "$match" )
            done
            if (( ${#matches[@]} > 1)); then
                echo "error: too many matches for '$arg': ${matches[*]}"
                return 1
            fi
            local new_path
            new_path="$(_blog_get_new_post_path "$arg")"
            if (( ${#matches[@]} )); then
                local old_path="${matches[0]}"
                if [[ "$old_path" != "$new_path" ]]; then
                    mv "$old_path" "$new_path"
                fi
            else
                touch "$new_path"
            fi
        done
    elif [[ "$command" = "rename" ]]; then
        if [[ $# != 2 ]]; then
            echo "usage: $BLOG_COMMAND rename <SRC> <DST>"
            return 1
        fi
        src=$(_blog_get_post_matches "$1")
        if [[ -z "$src" ]]; then
            echo "error: no matches for '$1'"
            return 1
        fi
        if [[ -n $(_blog_get_post_matches "$2") ]]; then
            echo "error: '$2' already exists"
            return 1
        fi
        dst=$(_blog_get_new_post_path "$2")
        dir_name=$(dirname "$src")
        src_date=$(basename "$src" | head -c 10)
        dst_tail=$(basename "$dst" | cut -c 11-)
        new_path="${dir_name}/${src_date}${dst_tail}"
        mv "$src" "$new_path"
    elif [[ "$command" = "serve" ]]; then
        (cd "$BLOG_DIR" && bundler exec jekyll serve "$@")
    else
        echo "error: invalid subcommand: '$command'"
        return 1
    fi
}

_blog_get_post_matches() {
    local post_dir="$BLOG_DIR/_posts"
    local matches=()
    # shellcheck disable=SC2044
    for path in $(find "$post_dir" -name "*$1"); do
        if [[ -n "$path" ]]; then
            echo "$path"
        fi
    done
}

_blog_get_new_post_path() {
    local name
    name="$(date +%F)-$1"
    name=${name%.md}.md
    echo "$BLOG_DIR/_posts/$name"
}

# shellcheck disable=SC2139
alias "$BLOG_COMMAND"=blog_command

_complete_blog_command()
{
    local chars=${COMP_WORDS[COMP_CWORD]}
    if [[ $COMP_CWORD = 1 ]]; then
        local options='edit touch serve rename'
        mapfile -t COMPREPLY < <(compgen -W "$options" -- "$chars")
        return 0
    fi
    local command=${COMP_WORDS[1]}
    if [[ $command = 'edit' || $command = 'touch' || $command = 'rename' ]]; then
        # List the files, strip the date prefix
        options=$(find "$BLOG_DIR/_posts" -printf "%f\n" | cut -c 12-)
        mapfile -t COMPREPLY < <(compgen -W "$options" -- "$chars")
    fi
}

complete -F _complete_blog_command "$BLOG_COMMAND"
