#!/system/bin/sh
bypass_path=/sys/devices/platform/charger/bypass_charger

ui_print "🔋--------------------------------🔋"
ui_print "           Autocut Charging         "
ui_print "🔋--------------------------------🔋"
ui_print "         By: Kanagawa Yamada        "
ui_print "------------------------------------"
ui_print "      READ THE TELEGRAM MESSAGE     "
ui_print "------------------------------------"
ui_print " "

sleep 3

if [ -e "$bypass_path" ]; then
	ui_print "Bypass Charging Supproted, Continuing"
else
    ui_print "Bypass Charing Not Supported"
    exit 1
fi

mkdir -p $MODPATH/system/bin
unzip -o "$ZIPFILE" 'acut64' -d $MODPATH/system/bin >&2

set_perm_recursive $MODPATH 0 0 0755 0644
set_perm $MODPATH/system/bin/acut64 0 0 0755 0755

am start -a android.intent.action.VIEW -d https://t.me/KanagawaLabAnnouncement/334 >/dev/null 2>&1