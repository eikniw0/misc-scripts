#!/system/bin/env bash
#
#[[ -n "${__EXAMPLE_SH:-}" ]] && return
#__EXAMPLE_SH=1
#
#FUNCTIONS_ROOT="$HOME/etc/bashfuncs.d"
#. "$FUNCTIONS_ROOT/msg.sh" || exit 1
#

_strict() {
  [[ -n "${1:-}" ]] || return 111

  case "$1" in
    on)
      set -e -u -o pipefail
      ;;
    verbose)
      set -e -x -u -o pipefail
      ;;
    *)
      set +e +x +u +o pipefail
      ;;
  esac
}

_nofail() {
  local out='/proc/self/fd/1'
  local err='/proc/self/fd/2'
  local -i retval

  case $1 in
    -s|--silent|-l|--log)
      out="./bootstrap.$$.log"
      err="./bootstrap.$$.log"
      shift 1
      ;;
    -n|--null)
      out='/dev/null'
      err='/dev/null'
      shift 1
      ;;
  esac

  "$@" 1>$out 2>$err; retval=$?

  if [ $retval -ne 0 ]; then
    _error "Fatal error! Command should never fail!\n"
    _error "  Command: '$@'\n"
    _fatal "  Return value: $retval\n"
  fi
}

# vim: ts=2 sw=2 ft=bash ai
