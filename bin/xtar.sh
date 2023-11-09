#!/system/bin/env bash

[[ -n "${__XTAR_SH:-}" ]] && return
__XTAR_SH=1

FUNCTIONS_ROOT="$HOME/etc/functions.d"
. "$FUNCTIONS_ROOT/msg.sh" || exit 1
. "$FUNCTIONS_ROOT/debug.sh" || exit 1

_strict on

declare -a INPUTS=()
declare -i COMP_LVL=19  # default is 3
declare -i KEEP_INPUT=0
declare -i VERBOSE=0

usage() {
	_msg "Usage: $(basename $0) [-<1-19>] [-k] <INPUT> [INPUT2] ...\n" >&2
}

cleanup() {
	if (( completed )); then
		if [ -n "${base:-}" ]; then
			rm -f "$base.tar" "$base.git.tar"
		fi
	else
		rm -f "$base.tar" "$base.git.tar" "$base.tar.zst" "$base.git.tar.zst"
	fi
}
trap cleanup EXIT

process_input() {
	local input="$1"
	local base="$(basename $input)"
	local dir="$(dirname $input)"
	local startdir="$(pwd)"
	local finalsize=''
	declare -gi completed=0

	_msg "${bold}processing input '$cyn$base$wht'$rst...\n"

	[[ "$dir" = '.' ]] || cd "$dir"

	if [ -d "$base"/.git ]; then
		case "$base" in
				*.git)
				;;
			*)
				_info "renaming '$cyn$base$wht' to '$cyn$base$wht.git'"
				_nofail mv -f "$base" "$base.git"
				base="$base.git"
				_success
				;;
		esac
	else
		case "$base" in
			*.git)
				_info "renaming '$cyn$base$wht' to '$cyn${base/.git}$wht'\n"
				_nofail mv -f "$base" "${base/.git}"
				base="${base/.git}"
				_success
				;;
			*)
				;;
		esac
	fi

	_info "creating tarball '$cyn$base.tar$wht'"
	tar --sort=name \
	    --preserve-permissions \
	    --same-owner \
	    --xattrs \
	    --xattrs-include='*.*' \
	    --create \
	    --file "$base.tar" \
	    "$base" || \
			    _fatal "tar failed"
	_success

	uncompressed_size="$(ls -lh $base.tar | awk '{print $5}')"

	_info "compressing '$cyn$base.tar$wht' with '${red}zstd -$COMP_LVL$rst'"
	zstd -$COMP_LVL \
	     --threads=0 \
	     --quiet \
	     --force \
	     --rm \
	     "$base.tar" || \
			     _fatal "zstd failed\n"
	completed=1
	_success

	if ! (( KEEP_INPUT )); then
		_info "removing '$blu$base/$wht' directory"
		rm -rf "$base/" || _fatal "rm failed\n"
		_success
	fi

	finalsize="$(ls -lh $base.tar.zst | awk '{print $5}')"
	_msg " $dim[$bold$ylw☆$rst$dim]$rst uncompressed size: $mag$uncompressed_size$wht ($cyn$base.tar.zst$wht)\n"
	_msg " $dim[$bold$grn☆$rst$dim]$rst final size: $mag$finalsize$wht ($cyn$base.tar.zst$wht)\n"

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
			shift 1
			;;
		-k|--keep)
			KEEP_INPUT=1
			shift 1
			;;
		-*)
			_fatal "Invalid argument: '$1'\n"
			;;
		*)
			INPUTS+=("$1")
			shift 1
			;;
	esac
done

if [ ${#INPUTS[@]} -eq 0 ]; then
	_fatal "No input files given.\n"
fi

for input in ${INPUTS[@]}; do
	process_input "$input"
done

# vim: ts=2 sw=2 noet ai ft=bash
