#!/bin/sh

case $1 in
    -b|--battery-level)
        LEVEL=$(cat /sys/class/power_supply/BAT0/capacity)

        eww update battery_level=$LEVEL

        case $LEVEL in
             [0-9]) printf "󰂎";;
            1[0-9]) printf "󰁺";;
            2[0-9]) printf "󰁻";;
            3[0-9]) printf "󰁼";;
            4[0-9]) printf "󰁽";;
            5[0-9]) printf "󰁾";;
            6[0-9]) printf "󰁿";;
            7[0-9]) printf "󰂀";;
            8[0-9]) printf "󰂁";;
            9[0-5]) printf "󰂂";;
            9[6-9]|100) printf "󰁹";;
        esac
        ;;
    -p|--plugged-in)
        cat /sys/class/power_supply/AC0/online
        ;;
esac
