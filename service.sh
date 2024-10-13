loop() {

while true; do

THRESHOLD=100

BATTERY_LEVEL=$(dumpsys battery | grep "level:" | awk '{print $2}')

sleep 5

if [ $BATTERY_LEVEL -ge $THRESHOLD ]; then
    chmod +w /sys/devices/platform/charger/bypass_charger
    echo "1" >/sys/devices/platform/charger/bypass_charger
else
    chmod +w /sys/devices/platform/charger/bypass_charger
    echo "0" >/sys/devices/platform/charger/bypass_charger
fi
done
}

loop &