#!/system/bin/env bash

[[ -n "${__SPINNER_SH:-}" ]] && return
__SPINNER_SH=1

FUNCTIONS_ROOT="$HOME/etc/bashfuncs.d"
. "$FUNCTIONS_ROOT/colors.sh" || return 1
. "$FUNCTIONS_ROOT/misc.sh" || return 1

__SPINNER_TYPE='moon'


__spinner_cleanup() {
	unset __SPINNER_SH __SPINNER_TYPE __define_spinner __start_spinner
	kill $jpid $spid &>/dev/null
	unset _s_frames _s_delay _s_width _s_pid
	tput cnorm
	unset __spinner_cleanup
}
trap '__spinner_cleanup' INT HUP KILL QUIT EXIT


__define_spinner() {
    declare -g _s_frames _s_delay _s_width

    case "$__SPINNER_TYPE" in
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

__spinner() {
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

__start_spinner() {
	declare -gi jpid spid

	__define_spinner "${1:-$__spinner_type}"

	tput civis

	"$@" &
	jpid=$!

	__spinner $jpid &
	spid=$!

	wait $jpid
	__spinner_cleanup
}


if [ "$(basename $0)" = 'spinner.sh' ]; then
	_msg "displaying demo: sleep 5\n"
	__start_spinner sleep 5
fi

# vim: tabstop=4 noexpandtab autoindent filetype=bash
