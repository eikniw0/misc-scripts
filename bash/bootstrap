#!/system/bin/env bash

FUNCTIONS_ROOT="$HOME/etc/functions.d"
. "$FUNCTIONS_ROOT/msg.sh" || exit 1
. "$FUNCTIONS_ROOT/debug.sh" || exit 1

_strict on

_ac_cleanup() {
  if [ -d ./autom4te.cache ]; then
    _info "removing '${blu}autom4te.cache$wht' directory"
    rm -rf ./autom4te.cache
    _success
  fi

  _info "finding temporary files to be removed... "
  declare -a tmpfiles=(`find -name '*~' -type f`)

  if [ ${#tmpfiles[@]} -eq 0 ]; then
    _msg "${ylw} none found--thats weird\n"
  else
    _success

    local file
    for file in ${tmpfiles[@]}; do
      _msg "   ${bold}${blu}¤${wht} removing '${cyn}$file$wht'\n"
      _nofail rm -f "$file"
    done
  fi

  rm -f ./bootstrap.*.log
}

_ac_bootstrap() {
  if [ -d ./m4 ]
    then local incdir='-I m4'
    else local incdir=''
  fi

  declare -a steps
  steps=("libtoolize --force --install --copy"
         "aclocal --force --install $incdir"
         "autoheader --force"
         "autoconf --force $incdir"
         "automake --add-missing --force-missing --copy")

  for (( i=0; i<${#steps[@]}; i++ )); do
    local cmd="${steps[$i]}"

    _info "$cmd"
    _nofail --silent $cmd
    _success
  done

  _ac_cleanup
}

_ac_bootstrap

# vim: ts=2 sw=2 ft=bash
