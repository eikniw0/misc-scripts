#!/system/bin/env bash

[[ -n "${__COLORS_SH:-}" ]] && return
__COLORS_SH=1

FUNCTIONS_ROOT="$HOME/etc/functions.d"
# source "$FUNCTIONS_ROOT/print.sh" || exit 1


init_colors() {
    if [ -n "${COLORTERM:-}" ]; then
        local color_term=1
    elif [ "$TERM" =~ *color* ]; then
        local color_term=1
    else
        if [ -x "$(type -p tput)" -a $(tput colors) -ge 8 ]; then
            local color_term=1
        else
            local color_term=0
        fi
    fi

    if (( color_term )); then
        declare -g rst=$'\e(G\e[m'

        declare -g save=$'\e7'
        declare -g load=$'\e8'

        declare -g bold=$'\e[1m'
        declare -g dim=$'\e[2m'
        declare -g ital=$'\e[3m'
        declare -g ul=$'\e[4m'
        declare -g rev=$'\e[7m'
        declare -g strike=$'\e[9m'

        declare -g smso='$(tput smso)'
        declare -g rmso='$(tput rmso)'

        declare -g blk=$'\e[30m'
        declare -g red=$'\e[31m'
        declare -g grn=$'\e[32m'
        declare -g ylw=$'\e[33m'
        declare -g blu=$'\e[34m'
        declare -g mag=$'\e[35m'
        declare -g cyn=$'\e[36m'
        declare -g wht=$'\e[37m'

        declare -g bg_blk=$'\e[20m'
        declare -g bg_red=$'\e[21m'
        declare -g bg_grn=$'\e[22m'
        declare -g bg_ylw=$'\e[23m'
        declare -g bg_blu=$'\e[24m'
        declare -g bg_mag=$'\e[25m'
        declare -g bg_cyn=$'\e[26m'
        declare -g bg_wht=$'\e[27m'
    else
        declare -g rst=''

        declare -g save=''
        declare -g load=''

        declare -g bold=''
        declare -g dim=''
        declare -g ital=''
        declare -g ul=''
        declare -g rev=''
        declare -g strike=''

        declare -g smso=''
        declare -g rmso=''

        declare -g blk=''
        declare -g red=''
        declare -g grn=''
        declare -g ylw=''
        declare -g blu=''
        declare -g mag=''
        declare -g cyn=''
        declare -g wht=''

        declare -g bg_blk=''
        declare -g bg_red=''
        declare -g bg_grn=''
        declare -g bg_ylw=''
        declare -g bg_blu=''
        declare -g bg_mag=''
        declare -g bg_cyn=''
        declare -g bg_wht=''
    fi
}

init_colors

# vim: ts=4 sw=4 ft=bash ai
