#!/bin/bash
# ~/.config/wal/hooks/cava.sh
set -euo pipefail

WAL_CACHE="$HOME/.cache/wal/colors"
CAVA_CONF="$HOME/.config/cava/config"
TMP="$(mktemp)"

# On prend 8 couleurs de la palette de pywal
mapfile -t cols < "$WAL_CACHE"
count=8
[ "${#cols[@]}" -lt "$count" ] && count="${#cols[@]}"

for i in $(seq 1 $count); do
  export cols_"$i"="'${cols[$((i))]}'"
done

awk -v count="$count" '
BEGIN { incolor=0 }
/^\[color\]/ { incolor=1; next }
incolor && /^\[/ { incolor=0 }
!incolor { print }
END {
  print "[color]"
  print "gradient = 1"
  print "gradient_count = " count
  for (i=1; i<=count; i++) {
    print "gradient_color_" i " = " ENVIRON["cols_" i]
  }
}
' "$(printf '%s' "$CAVA_CONF")" > "$TMP"
cp -f "$CAVA_CONF" "$CAVA_CONF.bak" 2>/dev/null || true
mv "$TMP" "$CAVA_CONF"
