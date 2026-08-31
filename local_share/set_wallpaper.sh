#!/usr/bin/env bash

if [ $? -ne 0 ]; then
    echo "Error, choose an image file to set as a wallpaper."
    exit 1
fi

wallpaper=$1

cp $wallpaper ~/.cache/wallpaper.png
awww img $wallpaper
echo "Wallpaper $wallpaper applied."
wal -i $wallpaper
echo "Theme applied."
~/.config/wal/hooks/bordercolor.sh
echo "Windows border color added."
~/.config/wal/hooks/cava.sh
echo "Cava theme applied."
pywalfox update
echo "Firefox theme updated."
# pywal-spicetify Default
# echo "Sptotify theme updated."
# pkill waybar 2>/dev/null || true
pkill -9 waybar
nohup waybar >/dev/null 2>&1 &
echo "Waybar reloaded."
pkill -9 swaync && swaync & disown
echo "swaync notification reloaded."

