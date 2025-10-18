#!/usr/bin/env bash

STATE_FILE="/tmp/hyprsunset_state"
TEMP_LOW=3500
TEMP_HIGH=6000
ICON_LOW="󰌶"
ICON_HIGH="󰌵"

get_icon() {
    if [[ -f "$STATE_FILE" ]]; then
        CURRENT_TEMP=$(cat "$STATE_FILE")
    else
        CURRENT_TEMP=$TEMP_HIGH
    fi

    if [[ "$CURRENT_TEMP" -eq "$TEMP_LOW" ]]; then
        echo "$ICON_LOW"
    else
        echo "$ICON_HIGH"
    fi
}

toggle_temp() {
    if [[ -f "$STATE_FILE" ]]; then
        CURRENT_TEMP=$(cat "$STATE_FILE")
    else
        CURRENT_TEMP=$TEMP_HIGH
    fi

    if [[ "$CURRENT_TEMP" -eq "$TEMP_LOW" ]]; then
        NEW_TEMP=$TEMP_HIGH
    else
        NEW_TEMP=$TEMP_LOW
    fi

    echo "$NEW_TEMP" > "$STATE_FILE"
    killall hyprsunset 2>/dev/null
    hyprsunset -t "$NEW_TEMP" > /dev/null 2>&1 & disown
}

# Gestion des arguments
case "$1" in
    --get)
        get_icon
        ;;
    --toggle)
        toggle_temp
        ;;
    *)
        echo "Usage: $0 [--get|--toggle]"
        ;;
esac
