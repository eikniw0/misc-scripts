#!/system/bin/env bash

[[ -n "${__TEMPLATE_SH__:-}" ]] \
  && [[ -z "${FORCE_RELOAD:-}" ]] && return
__GLOBAL_SCRIPTS__+=( "$(basename $0)" )
for ((i=0; i<${!__GLOBAL_SCRIPTS__[@]}; i++))
  test ${__LOADED__[$i]} = $(basename $0) && return

# printf "${__GLOBAL_SCRIPTS__[@]}\n"

GLOBAL_FUNCTIONS_ROOT=~/etc/bash/functions.d
. "${GLOBAL_FUNCTIONS_ROOT}"/msg.sh || return 1
. "${GLOBAL_FUNCTIONS_ROOT}"/debug.sh || return 1

declare -ga INPUTS=()

for arg in "$@"; do
  case "$1" in
    -h|--help)
      usage
      exit 0
      ;;

    -*)
      _fatal "Unknown argument: '$arg'.\n"
      ;;

    *)
      INPUTS+=("$arg")
      ;;

  esac
done


for (( i=0; i<${#INPUTS[@]}; i++ )); do
  in="${INPUTS[$i]}"

  if [ ! -r "$in" ]; then
    _error "Input file '$in' is not readable! Skipping it...\n"
    continue
  fi

  case "$in" in
    *.gz)
      _gunzip "$in"
      in="${in/.gz}"
      ;;

    *.bz2)
      _bunzip "$in"
      in="${in/.bz2}"
      ;;

    *.xz)
      _unxz "$in"
      in="${in/.xz}"
      ;;

    *)
      _error "Unknown file type: '$in'\n"
      continue
      ;;
  esac

  _info "compressing '${cyn}$in${rst}' with zstd\n"
  _zstd "$in"



done

# vim: ts=2 sw=2 ft=sh
