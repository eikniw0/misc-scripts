#!/system/bin/env bash

[[ -n "${__MSG_SH:-}" ]] && return
__MSG_SH=1

FUNCTIONS_ROOT="$HOME/etc/functions.d"
. "$FUNCTIONS_ROOT/colors.sh" || exit 1


_msg() {
  printf "${rst}%b${rst}" "$@"
}

_info() {
  _msg " $dim[${save} ]$rst $@"
}

_status() {
  local str_success="$rst$bold$grn✓$rst"
  local str_error="$rst$bold$red✕$rst"
  local str_warn="$rst$bold$ylw?$rst"
  local str_debug="$rst$bold${mag}D$rst"

  case $1 in
    success)
      _msg "$load$str_success\n" ;;
    err*)
      _msg "$load$str_error\n" ;;
    warn*)
      _msg "$load$str_warn\n" ;;
    debug)
      _msg "$load$str_debug\n" ;;
  esac
}

_success() {
#  _msg " $dim($bold$grn✓$dim$wht)$rst $@"
  _status success
}

_warn() {
#  _msg " $dim($bold$ylw¤$dim$wht]$rst $@"
  _status warn
}

_debug() {
  _status debug
}

_error() {
#  _msg " $dim($bold$red✕$dim$wht)$rst $@"
  _status error
}

_fatal() {
  _error "$@"
  exit 1
}

# check='✓'
# arrow='❯'

# vim: ts=2 sw=2 ft=bash ai
