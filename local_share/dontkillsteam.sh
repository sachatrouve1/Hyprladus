#!/usr/bin/env bash

active_class=$(hyprctl activewindow -j | jq -r '.class // empty')

if [ "${active_class,,}" = "steam" ]; then
    xdotool getactivewindow windowunmap
else
    hyprctl dispatch "hl.dsp.window.close()"
fi


