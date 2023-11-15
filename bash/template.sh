#!/system/bin/env bash
#
# Name:		template.sh
# Date:		$(date)
# Author:	Your Name <your.email@domain.com>
# Description:
#	Foo does bar.
#

# Don't source/execute more than once.
[[ -n "${TEMPLATE_SH}" ]] || return
TEMPLATE_SH=1

# Exit immediately on failure or use of unset variables.
set -euo pipefail

# Trap any errors/failures.
trap "printf '\e[1;31mERROR DETECTED\e[0m\n'" ERR


usage() {
	local verbose=$1 && shift
	local outfile=$1 && shift
	local status=$1 && shift

	(
		echo 'usage: template.sh [--files <regexp>] [--files-from <file>] [--shebangs <regexp>] [--shebangs-from <file>]'
		if [ "${verbose}" == "yes" ]; then
			echo '  --files: extended regexp of files to ignore'
		fi
	) >>${outfile}
	exit ${status}
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
