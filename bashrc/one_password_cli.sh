#!/usr/bin/env bash

# shellcheck source=/dev/null
source <(op completion bash)

show_op_session_active() {
    if (op whoami &> /dev/null); then
        echo "❶ "
    fi
}
