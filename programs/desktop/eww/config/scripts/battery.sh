#!/bin/sh

# Get the battery level and charging status
LEVEL=$(cat /sys/class/power_supply/BAT0/capacity)
PLUGG=$(cat /sys/class/power_supply/AC0/online)

# Used to set the color of the battery icon
if   [ $LEVEL -lt 25 ]; then
    CLASS="battery_0_25"
elif [ $LEVEL -lt 50 ]; then
    CLASS="battery_25_50"
elif [ $LEVEL -lt 75 ]; then
    CLASS="battery_50_75"
else
    CLASS="battery_75_100"
fi

eww update battery_icon_style=$CLASS

# Print the battery icon, according to level and charging status
case $PLUGG in
    0)
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
    1)
        case $LEVEL in
             [0-9]) printf "󰢜";;
            1[0-9]) printf "󰢜";;
            2[0-9]) printf "󰂆";;
            3[0-9]) printf "󰂇";;
            4[0-9]) printf "󰂈";;
            5[0-9]) printf "󰢝";;
            6[0-9]) printf "󰂉";;
            7[0-9]) printf "󰢞";;
            8[0-9]) printf "󰂊";;
            9[0-5]) printf "󰂋";;
            9[6-9]|100) printf "󰂅";;
        esac
        ;;
esac
