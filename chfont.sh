#!/system/bin/env bash

. ~/etc/scripts/terminal.sh || exit 255

[[ $# -eq 1 ]] || exit 237

if [ -f "$1" ]; then
	name=${1/.otf}
	name=${name/.ttf}
	name=${name/NerdFont}
	weight=${name/*-}
	name=${name/-*}
	info_msg
	info_msg "Installing Termux font ..."
	info_msg "${cyn}Font name${wht}: $mag$name"
	info_msg "${cyn}Weight${wht}: $mag$weight"
	info_msg
	info_msg "5 seconds to cancel..."
	info_msg
	sleep 5
	cp -f "$1" ~/.termux/font.ttf
	termux-reload-settings
fi
