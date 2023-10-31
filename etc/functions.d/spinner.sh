#!/system/bin/env bash

[[ -n "${__SPINNER_SH:-}" ]] && return
__SPINNER_SH=1

FUNCTIONS_ROOT="$HOME/etc/functions.d"
. "$FUNCTIONS_ROOT/colors.sh" || exit 1


spinner_type='moon'


___define_spinner() {
    declare -g _s_frames _s_delay _s_width

    case "$spinner_type" in
        moon)
            _s_frames=('🌕' '🌖' '🌗' '🌘' '🌑' '🌒' '🌓' '🌔')
            _s_delay=0.08
            _s_width=2
            ;;
        *)
            _error "Unknown spinner type: '$1'\n"
            return 1
            ;;
    esac
}

___spinner() {
    local -i i=0 pid=$1

    local sc="$(tput sc)"
    local rc="$(tput rc)"

    while [ -d /proc/$pid ]; do
        printf "${rc}${_s_frames[$i]}"
        sleep $_s_delay
        ((i++))
        [ $i -eq ${#_s_frames[@]} ] && i=0
    done
}

_spin() {
  declare -gi job_pid spin_pid

  ___define_spinner "${1:-$spinner_type}"

  tput civis

  trap '_stop_spin' INT HUP KILL QUIT EXIT

  "$@" &
  job_pid=$!

  ___spinner $job_pid &
  spin_pid=$!

  wait $job_pid
  kill $spin_pid
}

_stop_spin() {
    kill $job_pid $spin_pid &>/dev/null
    unset spinner_type _s_frames _s_delay _s_width _s_pid
    tput cnorm
    trap '' INT HUP KILL QUIT EXIT
}

_spin sleep 5

## vim: ts=2 sw=2 ft=bash
