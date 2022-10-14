#!/bin/sh
printf "TZ=%s\n" `cat /etc/timezone`
printf "SERIAL_DEVICE=%s\n" `ls -1 /dev/serial/by-id/usb-* | head -n 1`
printf "ZIGBEE2MQTT_CONFIG_ADVANCED_NETWORK_KEY=[%s]\n" `shuf -i0-255 -n16 | paste -sd ','`
