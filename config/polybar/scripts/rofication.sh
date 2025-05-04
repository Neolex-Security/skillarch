#!/bin/bash

primary_color="$(polybar --dump=primary bottom -c ~/.config/polybar/polybar.ini 2>/dev/null)"
urgent_color="$(polybar --dump=alert bottom -c ~/.config/polybar/polybar.ini 2>/dev/null)"

rofication_print() {
    status=$(rofication-status)
    if [ $status = '?' ]; then
        printf $status
    elif [ $status -gt 0 ]; then
       echo "%{F$urgent_color}%{F-} $status"
   else
        echo "%{F$primary_color}%{F-} 0"
    fi
    printf '\n'
}

rofication_show() {
    rofication-gui
}

case "$1" in
    --show)
        rofication_show
        ;;
    *)
        rofication_print
        ;;
esac
