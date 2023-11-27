#!/system/bin/env bash
#
# Name: template.sh
# Version: 1.0
# Updated: Fri 17 Nov 2023 09:54 PST
# Author: Zack Winkles <hymenaeus0@disroot.org>
# Description:
#	A demonstration of how to properly use the global bash script functions
#	in your own scripts.  Wait, that's unrealistic, it's just for me to
#	be lazy and copy for when I write new stuff--keep things kinda
#	standardized...  (Me? Standardized? Hah!)
#

# Prevent multiple inclusion, makes things load faster and (potentially)
# prevent an infinite loop when a.sh includes b.sh, but b.sh also
# includes a.sh.  Override this safety feature by setting $FORCE_RELOAD.
[[ -n "${__TEMPLATE_SH__:-}" ]] \
	&& [[ -z "${FORCE_RELOAD:-}" ]] && return
__GLOBAL_SCRIPTS__+=( $(basename $0) )

printf "${__GLOBAL_SCRIPTS__[@]}\n"

GLOBAL_FUNCTIONS_ROOT=~/etc/bash/functions.d
. "${GLOBAL_FUNCTIONS_ROOT}/msg.sh" || return 1
. "${GLOBAL_FUNCTIONS_ROOT}/debug.sh" || return 1


# vim: ft=bash ts=4 sw=4 noet
