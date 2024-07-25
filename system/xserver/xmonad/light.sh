#!/usr/bin/env bash

OP=${1:--}
STEP=${2:-0.02}

BRIGHTNESS="$(xrandr --verbose | awk '/Brightness/ { print $2; exit }')"
NEW=$(awk "BEGIN {printf \"%.2f\",${BRIGHTNESS} ${OP} ${STEP}}")
xrandr --output DP-0 --brightness "$NEW"
xrandr --output HDMI-0 --brightness "$NEW"

