#!/usr/bin/env bash

# Récupère le shader actif
CURRENT=$(hyprshade current 2>/dev/null | tr -d '[:space:]')

if [[ "$CURRENT" == "extradark" ]]; then
    hyprshade off
    notify-send "Hyprshade off"
else
    hyprshade on extradark
    notify-send "Hyprshade extradark"
fi
