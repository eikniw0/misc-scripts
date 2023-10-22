#!/system/bin/sh
set -x
adb wait-for-device || exit
adb shell "/system/bin/device_config set_sync_disabled_for_tests persistent"
adb shell "/system/bin/device_config put activity_manager max_phantom_processes 2147483647"
adb shell "settings put global settings_enable_monitor_phantom_procs false"
echo -e "\nConfirming...\n"
adb shell "/system/bin/dumpsys activity settings | grep max_phantom_processes"
adb shell "/system/bin/device_config get activity_manager max_phantom_processes"
echo -e "expected value: 2147483647\n"
if [ -x "$(type -p su)" ]; then
  su -c "/system/bin/getprop persist.sys.fflag.override.settings_enable_monitor_phantom_procs"
  echo -e "expected value: false\n"
fi
echo "DONE"
