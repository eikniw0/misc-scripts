#!/system/bin/env bash

. ~/etc/scripts/terminal.sh || exit 255
. ~/etc/scripts/debug.sh || exit 255

strict_mode on

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
	mkdir -p /sdcard/pool/"$input"
	for file in $(ls ${input}*); do
		info_msg "moving '$cyn$file$wht' to '$blu\$POOL/$input$wht'"
		mv -f "$file" /sdcard/pool/"$input"/
	done
done
