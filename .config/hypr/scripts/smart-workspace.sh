#!/bin/bash
workspace_num=$1

if [ -z "$workspace_num" ]; then
    echo "Usage: $0 <workspace_number>"
    exit 1
fi

# Get the monitor that should have this workspace
if [ "$workspace_num" -le 5 ]; then
    # Primary workspaces (1-5) - prefer external monitor
    monitors=$(hyprctl monitors -j | jq -r '.[].name')
    external_monitor=$(echo "$monitors" | grep -v "eDP-1" | grep -v "WAYLAND-1" | head -1)
    
    if [ -n "$external_monitor" ]; then
        target_monitor="$external_monitor"
    else
        target_monitor="eDP-1"
    fi
else
    # Secondary workspaces (6-10) - always laptop
    target_monitor="eDP-1"
fi

# Ensure workspace is on correct monitor
hyprctl dispatch moveworkspacetomonitor $workspace_num $target_monitor

# Switch to the workspace
hyprctl dispatch workspace $workspace_num
