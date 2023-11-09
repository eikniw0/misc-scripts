#!/system/bin/env bash

. ~/etc/functions.d/msg.sh || exit 255

[[ $# -eq 1 ]] || exit 237

if [ -f "$1" ]; then
	name=${1/.otf}
	name=${name/.ttf}
	name=${name/NerdFont}
	weight=${name/*-}
	name=${name/-*}
    _info "Installing $blu$name$wht ($mag$weight$wht)$dim..."
	cp -f "$1" ~/.termux/font.ttf
	termux-reload-settings
    _success
fi
