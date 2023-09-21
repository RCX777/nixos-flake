#!/usr/bin/env bash

export LANG=EN_US

DEVICE="wlo1"

device_path="/sys/class/net/$DEVICE/statistics/"

SCAN_INTERVAL=1

current_speed (){
    while true; do
        rx1=$(cat ${device_path}rx_bytes)
        tx1=$(cat ${device_path}tx_bytes)
        sleep $SCAN_INTERVAL
        rx2=$(cat ${device_path}rx_bytes)
        tx2=$(cat ${device_path}tx_bytes)

        d_speed=$(((rx2 - rx1) / 1024))
        u_speed=$(((tx2 - tx1) / 1024))

        d_unit="kb/s"
        u_unit="kb/s"

        if [[ $d_speed -gt 1024 ]]; then
            d_speed=$(((d_speed) / 1024))
            d_unit="mb/s"
        fi
        if [[ $u_speed -gt 1024 ]]; then
            u_speed=$(((u_speed) / 1024))
            u_unit="mb/s"
        fi
        echo -e "󰇚$d_speed$d_unit 󰕒$u_speed$u_unit "
    done
}

config_connection (){
    if [[ $(nmcli | grep -i "connected to" | awk '{print$NF}') ]]; then
        SSID=$(nmcli c | grep $DEVICE | awk '{print ($1)}')

        echo "true"
        eww update ssid=$SSID
    else
        echo "false"
    fi
}

monitor_net (){
    nmcli monitor | while read -r line; do
        if [[ $line == "Connectivity is now 'full'" ]]; then
            echo "true"
            config_connection
            eww update ssid=$SSID
        elif [[ $line == "Connectivity is now 'none'" ]]; then
            echo "false"
        fi
    done
}

case "$@" in
    --monitor|-m)
        config_connection
        monitor_net
        ;;
    --speed|-ns)
        current_speed
        ;;
esac
