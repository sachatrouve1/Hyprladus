#!/usr/bin/env bash

STATE_FILE="$HOME/.cache/hypr_effects_state"

# Read current state
if [[ -f "$STATE_FILE" ]]; then
    STATE=$(<"$STATE_FILE")
    STATE=$(echo -n "$STATE" | tr -d '[:space:]')
else
    STATE="on"
fi

# Toggle state
if [[ "$STATE" == "on" ]]; then
    hyprctl eval "hl.config({ animations = { enabled = false }, decoration = { blur = { enabled = false }, rounding = 0 } })"
    echo -n "off" >"$STATE_FILE"
else
    hyprctl eval "hl.config({ animations = { enabled = true }, decoration = { blur = { enabled = true }, rounding = 20 } })"
    echo -n "on" >"$STATE_FILE"
fi
