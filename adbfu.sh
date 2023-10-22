#!/system/bin/sh

OUT='/dev/null'

list_packages() {
  if [ "$1" = 'system' ]; then
    local arg='-s'
  elif [ "$1" = 'user' ]; then
    local arg='-3'
  fi

  adb shell pm list packages $arg | \
      sed 's,^package:,,'
}

list_permissions() {
  local pkg=
}

grab_apk() {
  local path="$(adb shell pm path $1)"

  adb pull "$path" >$OUT

  mv -f base.apk "$1.apk"
}

