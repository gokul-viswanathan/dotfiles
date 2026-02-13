#!/bin/bash
selected=$(fd . / \
  --type f \
  --exclude /proc \
  --exclude /sys \
  --exclude /dev \
  --exclude /tmp \
  --exclude /run \
  --exclude /snap \
  --exclude /lost+found \
  2>/dev/null | wofi --dmenu --prompt "Search files..." --cache-file /dev/null)

if [ -n "$selected" ]; then
  nautilus --select "$selected" &
fi
