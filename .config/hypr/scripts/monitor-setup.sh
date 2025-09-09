#!/bin/bash

# Get current monitor setup
external_connected=$(hyprctl monitors -j | jq -r '.[].name' | grep -v "eDP-1" | grep -v "WAYLAND-1" | wc -l)

if [ "$external_connected" -gt 0 ]; then
    echo "External monitor(s) detected, setting up dual monitor workspace layout"
    ~/.config/hypr/scripts/workspace-manager.sh
    
    # Optional: Set specific resolutions or positions
    # hyprctl keyword monitor DP-1,preferred,0x-1080,auto
    # hyprctl keyword monitor eDP-1,preferred,0x0,auto
    
    # Notify user
    notify-send "Monitor Setup" "Dual monitor layout activated"
else
    echo "No external monitor detected, using laptop screen only"
    
    # Move all workspaces to laptop
    for i in {1..10}; do
        hyprctl dispatch moveworkspacetomonitor $i eDP-1
    done
    
    notify-send "Monitor Setup" "Single monitor layout activated"
fi
