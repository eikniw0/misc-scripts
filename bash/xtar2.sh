#!/data/data/com.termux/files/usr/bin/bash
#
# File:      xtar2.sh
# Version:   1.0-pre
# Updated:   Friday, 17 November 2023
# Author:    Zack Winkles <hymenaeus0 AT disroot DOT org>
#

# strict mode on
set -euo pipefail

# Trap any errors/failures.
trap "printf '\e[1;31mERROR DETECTED\e[0m\n'" ERR

# Only newlines and tabs count as separators... spaces,
# however, do not.
IFS=$'\t\n'

#
# usage <RETURN_VALUE>
#	<RET_VAL>   whatever you want to exit with (usually 0)
#
usage() {
	local retval=${1:-0}

	msg "Usage: $(basename $0) [OPTIONS] <INPUT1> [INPUT2] ..."
	nsg "   -(1 thru 22): compression level for zstd"
	msg "   -k|--keep: don't remove input files/dirs"
	msg "   -p|--path: save the path of the input in the tarball and in the file name..."
	msg "     i.e., ./external/zlib/ becomes ./external-zlib.tar.zst"

	exit ${retval}
}

while [ $# -gt 0 ] ; do
	case "$1" in
		--files)
			exclude_files="${2}"
			shift
			;;
		--files=*)
			exclude_files="${1##--files=}"
			;;
		--help|--usage|"-?"|-h)
			usage yes /dev/stdout 0
			;;
		*)
			echo "Unknown option \"${1}\"" 1>&2
			usage no /dev/stderr 1
			;;
	esac
	shift
done

# vim: ft=bash ts=4 sw=4 noet ai
