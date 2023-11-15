#!/system/bin/env bash

[[ -n "${__NORMALIZE_SH:-}" ]] && return
__NORMALIZE_SH=1

FUNCTIONS_ROOT="$HOME/etc/bashfuncs.d"
. "$FUNCTIONS_ROOT/msg.sh" || exit 1

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
