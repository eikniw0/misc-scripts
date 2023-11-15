#!/system/bin/env bash

. ~/etc/functions.d/msg.sh || exit 1
. ~/etc/functions.d/debug.sh || exit 1

_strict on

POOL="/storage/0123-4567/pool"
INPUTS=()

for arg in "$@" ; do
	case "$arg" in
		-h|--help)
			usage
			exit 0
			;;
		-*)
			usage
			exit 1
			;;
		*)
			INPUTS+=("$arg")
			;;
	esac
done

for input in ${INPUTS[@]}; do
	mkdir -p "$POOL/$input"
	for file in $(ls ${input}*); do
		case "$file" in
			*.tar.zst)
				if [ -r "$file" ]; then
					_info "moving '$cyn$file$wht' to '$blu\$POOL/$input$wht'"
					_nofail mv -f "$file" "$POOL/$input"/ 2>/dev/null
					_success
				fi
				;;
			*)
				_warn "$file is not expected .tar.zst file\n"
				continue
				;;
		esac
	done
done

# vim: ts=2 sw=2 ai noet ft=bash
