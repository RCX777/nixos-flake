#!/bin/sh

STEP=2

if [ -z $1 ]; then
    pamixer -t

    eval $(pamixer --get-mute)\
        && eww update sound_icon="󰝟"\
        && eww update sound_icon_style="sound_icon_style_muted"\
        || ./$0 $(pamixer --get-volume)

else
    if [ "$1" = 'up' ]; then
        pamixer -i $STEP
    else
        pamixer -d $STEP
    fi
    
    VOL_CURRENT=$(pamixer --get-volume)

    if   [ $VOL_CURRENT -eq 0   ]; then
        ICON="󰖁"
        CLASS="sound_icon_style_muted"
    elif [ $VOL_CURRENT -le 33  ]; then
        ICON="󰕿"
    elif [ $VOL_CURRENT -le 66  ]; then
        ICON="󰖀"
    elif [ $VOL_CURRENT -le 100 ]; then
        ICON="󰕾"
    else
        ICON="󰕾"
        CLASS="sound_icon_style_overdrive"
    fi

    CLASS="sound_icon_style_default"

    eww update sound_icon="$ICON"
    eww update sound_icon_style="$CLASS"
fi

