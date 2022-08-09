#!/usr/bin/env bash

# Disables tilde(~) expansion
_expand() {
  return 0;
}

# Sets the default editor
export VISUAL=vim
export EDITOR="$VISUAL"

# Vim-like command line
set -o vi
