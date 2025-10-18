#!/usr/bin/env bash

STATE_FILE="$HOME/.cache/hypr_effects_state"

# Lire l'état actuel, nettoyer tout caractère parasite
if [[ -f "$STATE_FILE" ]]; then
    STATE=$(<"$STATE_FILE")
    # Supprimer espaces et retours à la ligne
    STATE=$(echo -n "$STATE" | tr -d '[:space:]')
else
    STATE="on"
fi

# Basculer l'état
if [[ "$STATE" == "on" ]]; then
    hyprctl keyword animations:enabled false
    hyprctl keyword decoration:blur:enabled false
    hyprctl keyword decoration:rounding 0
    echo -n "off" >"$STATE_FILE"
else
    hyprctl keyword animations:enabled true
    hyprctl keyword decoration:blur:enabled true
    hyprctl keyword decoration:rounding 20
    echo -n "on" >"$STATE_FILE"
fi
