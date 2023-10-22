#!/system/bin/env bash

. ~/etc/scripts/terminal.sh || exit 1
. ~/etc/scripts/debug.sh || exit 1

strict_mode on

declare -a INPUTS=()
declare -i COMPRESS_LVL=12  # default is 3
declare -i KEEP_INPUT=0
declare -i VERBOSE=0

usage() {
  msg "Usage: $(basename $0) [-<1-19>] [-k] <INPUT> [INPUT2] ..." >&2
}

process_input() {
  local input="$1"
  local base="$(basename $input)"
  local dir="$(dirname $input)"
  local startdir="$(pwd)"
  local finalsize=''

	msg "${bold}processing input '$cyn$base$wht'$rst..."

  [[ "$dir" = '.' ]] || cd "$dir"

  if [ -d "$base"/.git ]; then
    case "$base" in
      *.git)
        ;;
      *)
      	warn_msg "renaming '$cyn$base$wht' to '$cyn$base$wht.git'"
        mv -f "$base" "$base.git"
        base="$base.git"
        ;;
    esac
  else
    case "$base" in
      *.git)
      	warn_msg "renaming '$cyn$base$wht' to '$cyn${base/.git}$wht'"
        mv -f "$base" "${base/.git}"
        base="${base/.git}"
        ;;
      *)
        ;;
    esac
  fi

  info_msg "creating tarball '$cyn$base.tar$wht'"
  tar --sort=name \
      --preserve-permissions \
      --same-owner \
      --xattrs \
      --xattrs-include='*.*' \
      --create \
      --file "$base.tar" \
      "$base" || { debug_msg "tar failed"; exit 1; }

	if ! (( KEEP_INPUT )); then
		info_msg "removing '$blu$base/$wht' directory"
		rm -rf "$base/" || { debug_msg "rm failed"; exit 1; }
	fi

  info_msg "compressing '$cyn$base$wht' with ${blu}zstd"
  zstd -$COMPRESS_LVL \
       --threads=0 \
       --quiet \
       --force \
       --rm \
       "$base.tar" || { debug_msg "zstd failed"; exit 1; }

	finalsize="$(ls -lh $base.tar.zst | awk '{print $5}')"
	success_msg "final size: $finalsize"

	echo

  [[ "$dir" = '.' ]] || cd "$startdir"
}

while [ -n "${1:-}" ]; do
  case "$1" in
    -h|--help)
      usage
      exit 0
      ;;
    -[1-9]|-1[0-9])
    	COMP_LVL=${1/-}
#    	info_msg "Using compression level $cyn$COMP_LVL$wht as requested"
    	;;
    -k|--keep)
    	KEEP_INPUT=1
#    	info_msg "Will not delete source(s) as requested"
    	shift 1
    	;;
    -*)
      error_msg "Invalid argument: '$1'"
      exit 1
      ;;
    *)
      INPUTS+=("$1")
      shift 1
      ;;
  esac
done

if [ ${#INPUTS[@]} -eq 0 ]; then
  error_msg "No input files given."
  exit 1
fi

for input in ${INPUTS[@]}; do
  process_input "$input"
done
