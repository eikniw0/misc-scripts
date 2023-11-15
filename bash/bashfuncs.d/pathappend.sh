#!/system/bin/env bash

[[ -n "${__PATHAPPEND_SH:-}" ]] && return
__PATHAPPEND_SH=1

# FUNCTIONS_ROOT="$HOME/etc/bashfuncs.d"
# source "$FUNCTIONS_ROOT/print.sh" || exit 1

#
# pathappend [--prepend] <directory>
#
pathappend() {
	[[ -n "${1:-}" ]] || return 1

	case "$1" in
		--pre*) local prepend=1; shift 1 ;;
		*) local prepend=0 ;;
	esac

	if [ -d "$1" ]; then
		case :$PATH: in
			*:$1:*)
				;; # already added to path
			*)
				if (( prepend ))
					then PATH="$1:$PATH"
					else PATH="$PATH:$1"
				fi
				;;
		esac
	fi
}

# vim: ts=2 sw=2 ai noet ft=bash
