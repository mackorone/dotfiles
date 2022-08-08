#!/usr/bin/env bash

PS1='\[\e[0;36m\]{\W}$\[\e[m\] '

PS1='$(show_virtual_env)'$PS1
PS1='$(show_op_session_active)'$PS1
PS1='$(show_secrets_are_present)'$PS1
