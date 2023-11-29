#!/system/bin/env bash

#[[ -n "${__CONFIRM_SH:-}" ]] && return
#__CONFIRM_SH=1

FUNCTIONS_ROOT=~/etc/bash/functions.d
. "${FUNCTIONS_ROOT}"/msg.sh || return 1

##
## confirm [-t NUM] [-d DEFAULT] [-p TEXT] [-s] -- <MESSAGE>
##
##   <MESSAGE> will be displayed every ten or so rounds of
##             prompting.  Pass --silent for absolute silence.
##   -t|--timeout specifies an optional maximum wait time in
##             seconds before going with ...
##   -d|--default specifies whether YES or NO should be chosen once
##             the timeout has been reached
##   -p|--prompt specifies the prompt shown EVERYTIME, and thus is
##             more minimal than MESSAGE
##   -s|--silent print nothing--absolutely fucking nothing AT ALL
##
confirm() {
	[[ -n "${1:-}" ]] || return 1

	local timeout=0
	local default='N'
	local message=''
	local prompt=$"${rst}${dim}•${rst}${bold}${grn}y${rst}${dim}/${rst}${bold}${red}N${rst}${dim}•${rst}"
	local input

	case "${1:-}" in
		-*)
			while [ -n "${1:-}" ]; do
				case "$1" in
					-t|--timeout) timeout="$2"; shift 1;;
					-t=*|--timeout=*) timeout="${1/*=}";;
					-d|--default) default="$2"; shift 1;;
					-d=*|--default=*) default="${1/*=}";;
					-p|--prompt) prompt="$2"; shift 1;;
					-p=*|--prompt=*) prompt="${1/*=}";;
					-s|--silent) prompt=''; message='';;
					--) shift 1; message="${@:-}"; break;;
				esac
				shift 1
			done
			;;
		*)
			message="${@:-}"
			;;
	esac

	printf "$message"

	while true; do
		printf " $prompt "

		read -N 1 -r -s input

		echo
		case "${input:-}" in
			Y|y)
				return 0 ;;
			N|n)
				return 1 ;;
			*)
				msg "Invalid input: \"$input\"\n"
				sleep 1
				continue ;;
		esac
	done
}

# vim: ft=bash ts=4 sw=4 noet ai
