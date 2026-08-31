#!/usr/bin/env bash

# Check if input file is provided
if [ -z "$1" ]; then
    echo "Usage: topng <imagefile>"
    exit 1
fi

input="$1"

# Check if input file exists
if [ ! -f "$input" ]; then
    echo "Error: '$input' not found."
    exit 1
fi

# Remove extension to get base name
base="${input%.*}"
output="${base}.png"

# Convert using ImageMagick
magick "$input" "$output"

echo "Converted: $output"

