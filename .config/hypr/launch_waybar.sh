#!/bin/bash

# Kill existing waybar instances
pkill waybar

# Get connected monitors
monitors=$(hyprctl monitors -j | jq -r '.[].name')

for mon in $monitors; do
  if [ "$mon" = "eDP-1" ]; then
    CONFIG="$HOME/.config/waybar/config"
  else
    CONFIG="$HOME/.config/waybar/config2"
  fi
  
  # Launch Waybar bound to the monitor
  WAYBAR_MONITOR=$mon waybar -c "$CONFIG" &
  sleep 0.5
done

