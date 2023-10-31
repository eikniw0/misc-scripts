#!/system/bin/env bash

[[ -n "${__UNICODE_SH:-}" ]] && return
__UNICODE_SH=1

FUNCTIONS_ROOT="$HOME/etc/functions.d"
. "$FUNCTIONS_ROOT/colors.sh" || exit 1


_print_unicode_table() {
  local a b c d
	local digits=(0 1 2 3 4 5 6 7 8 9 A B C D E F)

	for a in ${digits[@]} ; do
    for b in ${digits[@]} ; do
      for c in ${digits[@]} ; do
        for d in ${digits[@]} ; do
          printf "$a$b$c$d = \u$a$b$c$d\n"
        done
      done
    done
  done
}

_print_unicode_table

#SYMBOLS+=('right_arrow' '\e279e') #  ➞
#SYMBOLS+=('

## vim: ts=2 sw=2 ft=sh
