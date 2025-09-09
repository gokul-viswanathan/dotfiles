#!/bin/bash

setup_workspaces() {
    # Get connected monitors
    monitors=$(hyprctl monitors -j | jq -r '.[].name')
    
    # Check for external monitors (anything that's not eDP-1 or WAYLAND-1)
    external_monitor=$(echo "$monitors" | grep -v "eDP-1" | grep -v "WAYLAND-1" | head -1)
    
    if [ -n "$external_monitor" ]; then
        echo "External monitor detected: $external_monitor"
        
        # Move workspaces 1-5 to external monitor
        for i in {1..5}; do
            hyprctl dispatch moveworkspacetomonitor $i $external_monitor
        done
        
        # Move workspaces 6-10 to laptop screen
        for i in {6..10}; do
            hyprctl dispatch moveworkspacetomonitor $i eDP-1
        done
        
        # Focus on workspace 1 on external monitor
        hyprctl dispatch workspace 1
        
    else
        echo "No external monitor detected, using laptop screen for all workspaces"
        
        # Move all workspaces to laptop screen
        for i in {1..10}; do
            hyprctl dispatch moveworkspacetomonitor $i eDP-1
        done
    fi
}

# Run setup
setup_workspaces
