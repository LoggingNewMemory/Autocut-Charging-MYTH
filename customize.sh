#!/system/bin/sh

ui_print "🔋--------------------------------🔋"
ui_print "    Tecno Pova 5 Pro GSI Autocut    "
ui_print "🔋--------------------------------🔋"
ui_print "         By: Kanagawa Yamada        "
ui_print "------------------------------------"
ui_print "      READ THE TELEGRAM MESSAGE     "
ui_print "------------------------------------"
ui_print " "

sleep 3

unzip -o "$ZIPFILE" 'system/*' -d $MODPATH >&2
mkdir -p $MODPATH/system/bin
unzip -o "$ZIPFILE" 'autocut_charging' -d $MODPATH/system/bin >&2

set_perm_recursive $MODPATH 0 0 0755 0644
set_perm $MODPATH/system/bin/P0 0 0 0755 0755
set_perm $MODPATH/system/bin/P1 0 0 0755 0755

am start -a android.intent.action.VIEW -d https://t.me/KanagawaLabAnnouncement/122 >/dev/null 2>&1