#!/system/bin/env bash

[[ -n "${__PATHAPPEND_SH:-}" ]] && return
__PATHAPPEND_SH=1

# FUNCTIONS_ROOT="$HOME/etc/functions.d"
# source "$FUNCTIONS_ROOT/print.sh" || exit 1


pathappend() {
    [[ -n "${1:-}" ]] || return 1

    if [ -d "$1" ]; then
        case "$PATH" in
            *"$HOME/bin"*)
                ;; # already added to path
            *)
                PATH=~/bin:"$PATH"
                export PATH
        esac
    fi
}

# vim: ts=4 sw=4 ft=bash ai
