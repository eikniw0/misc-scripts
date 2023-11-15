#!/system/bin/env bash

[[ -n "${__MSG_SH:-}" ]] && return
__MSG_SH=1

__SCRIPTS_ROOTDIR="$HOME/etc/bashfuncs.d"
. "$__SCRIPTS_ROOTDIR/colors.sh" || exit 1
. "$__SCRIPTS_ROOTDIR/debug.sh" || exit 1

_strict on

_bold=$"$bold"
_dim=$"$dim"
_rst=$"$rst"

print() {
    local string="$(printf '%s' $@ | \
                    sed -e s,[b],${_bold},g \

                        -e s,[d],${_dim},g)"
    builtin printf "${_rst}%b${_rst}" "$string              "
}

#_info() {
#  _msg " $dim[${save} ]$rst $@"
#}

#_status() {
#  local str_success="$rst$bold$grn✓$rst"
#  local str_error="$rst$bold$red✕$rst"
#  local str_warn="$rst$bold$ylw?$rst"
#  local str_debug="$rst$bold${mag}D$rst"
#
#  case $1 in
#    success)
#      _msg "$load$str_success\n" ;;
#    err*)
#      _msg "$load$str_error\n" ;;
#    warn*)
#      _msg "$load$str_warn\n" ;;
#    debug)
#      _msg "$load$str_debug\n" ;;
#  esac
#}

#_success() {
#  _msg " $dim($bold$grn✓$dim$wht)$rst $@"
#  _status success
#}

#_warn() {
#  _msg " $dim($bold$ylw¤$dim$wht]$rst $@"
#  _status warn
#}

#_debug() {
#  _status debug
#}

#_error() {
#  _msg " $dim($bold$red✕$dim$wht)$rst $@"
#  _status error
#}

#_fatal() {
#  _error "$@"
#  exit 1
#}

# check='✓'
# arrow='❯'

# vim: ts=4 sw=4 ft=bash
