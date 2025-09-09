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


# #!/bin/bash
# # ~/.config/waybar/launch.sh - Optimized waybar launcher
#
# CONFIG_DIR="$HOME/.config/waybar"
# LOG_FILE="/tmp/waybar-launch.log"
#
# # Function to log messages
# log_msg() {
#     echo "$(date '+%H:%M:%S') $1" >> "$LOG_FILE"
# }
#
# # Function to update workspace config dynamically
# update_workspace_config() {
#     local monitor=$1
#     local config_file=$2
#     
#     # Get connected monitors
#     monitors=$(hyprctl monitors -j | jq -r '.[].name')
#     external_connected=$(echo "$monitors" | grep -v "eDP-1" | grep -v "WAYLAND-1" | wc -l)
#     
#     # Create temporary config with dynamic workspace settings
#     temp_config="/tmp/waybar-${monitor}.json"
#     cp "$config_file" "$temp_config"
#     
#     if [ "$monitor" = "eDP-1" ]; then
#         if [ "$external_connected" -gt 0 ]; then
#             # External monitor connected - laptop shows workspaces 6-10
#             log_msg "External monitor detected, laptop shows workspaces 6-10"
#             jq '.["hyprland/workspaces"]["persistent-workspaces"] = {"6":[], "7":[], "8":[], "9":[], "10":[]} | 
#                 .["hyprland/workspaces"]["ignore-workspaces"] = ["1", "2", "3", "4", "5"]' \
#                 "$temp_config" > "${temp_config}.tmp" && mv "${temp_config}.tmp" "$temp_config"
#         else
#             # No external monitor - laptop shows workspaces 1-5
#             log_msg "No external monitor, laptop shows workspaces 1-5"
#             jq '.["hyprland/workspaces"]["persistent-workspaces"] = {"1":[], "2":[], "3":[], "4":[], "5":[]} | 
#                 .["hyprland/workspaces"]["ignore-workspaces"] = ["6", "7", "8", "9", "10"]' \
#                 "$temp_config" > "${temp_config}.tmp" && mv "${temp_config}.tmp" "$temp_config"
#         fi
#     else
#         # External monitor always shows workspaces 1-5
#         log_msg "External monitor $monitor shows workspaces 1-5"
#         jq '.["hyprland/workspaces"]["persistent-workspaces"] = {"1":[], "2":[], "3":[], "4":[], "5":[]} | 
#             .["hyprland/workspaces"]["ignore-workspaces"] = ["6", "7", "8", "9", "10"]' \
#             "$temp_config" > "${temp_config}.tmp" && mv "${temp_config}.tmp" "$temp_config"
#     fi
#     
#     echo "$temp_config"
# }
#
# # Function to launch waybar for a specific monitor
# launch_waybar() {
#     local monitor=$1
#     local base_config=$2
#     
#     log_msg "Setting up waybar for monitor: $monitor"
#     
#     # Update config with dynamic workspace settings
#     final_config=$(update_workspace_config "$monitor" "$base_config")
#     
#     # Launch waybar with monitor-specific settings
#     log_msg "Launching waybar for $monitor with config: $final_config"
#     WAYBAR_MONITOR="$monitor" waybar -c "$final_config" -s "$CONFIG_DIR/style.css" &
#     
#     # Store PID for cleanup
#     echo $! >> /tmp/waybar-pids
# }
#
# # Main execution
# main() {
#     log_msg "=== Waybar launch started ==="
#     
#     # Kill existing waybar instances
#     pkill waybar
#     rm -f /tmp/waybar-pids
#     sleep 0.5
#     
#     # Clear old temp configs
#     rm -f /tmp/waybar-*.json
#     
#     # Get connected monitors
#     monitors=$(hyprctl monitors -j | jq -r '.[].name' | grep -v "WAYLAND-1")
#     monitor_count=$(echo "$monitors" | wc -l)
#     
#     log_msg "Found monitors: $(echo $monitors | tr '\n' ' ')"
#     log_msg "Monitor count: $monitor_count"
#     
#     # Check if external monitor is connected
#     external_monitors=$(echo "$monitors" | grep -v "eDP-1")
#     
#     if [ -n "$external_monitors" ]; then
#         log_msg "External monitor setup detected"
#         
#         # Launch waybar for each monitor
#         for mon in $monitors; do
#             if [ "$mon" = "eDP-1" ]; then
#                 # Laptop screen - use config2 (includes battery, shows secondary workspaces)
#                 launch_waybar "$mon" "$CONFIG_DIR/config2"
#             else
#                 # External monitor - use main config (primary workspaces)
#                 launch_waybar "$mon" "$CONFIG_DIR/config"
#             fi
#             sleep 0.3
#         done
#     else
#         log_msg "Single monitor setup (laptop only)"
#         # Only laptop screen - use config2 but with primary workspaces
#         launch_waybar "eDP-1" "$CONFIG_DIR/config2"
#     fi
#     
#     log_msg "=== Waybar launch completed ==="
# }
#
# # Handle script arguments
# case "$1" in
#     "--reload")
#         log_msg "Reloading waybar configuration"
#         main
#         ;;
#     "--monitor")
#         # Monitor for hyprland events and reload when monitors change
#         log_msg "Starting monitor mode"
#         main
#         
#         # Monitor hyprland events for monitor changes
#         socat -u UNIX-CONNECT:/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock - | while read -r line; do
#             if echo "$line" | grep -q "monitoradded\|monitorremoved"; then
#                 log_msg "Monitor change detected: $line"
#                 sleep 1  # Brief delay to let hyprland settle
#                 main
#             fi
#         done
#         ;;
#     *)
#         main
#         ;;
# esac
#
# # # Cleanup function for graceful exit
# # cleanup() {
# #     log_msg "Cleaning up waybar processes"
# #     if [ -f /tmp/waybar-pids ]; then
# #         while read -r pid; do
# #             kill "$pid" 2>/dev/null
# #         done < /tmp/waybar-pids
# #         rm -f /tmp/waybar-pids
# #     fi
# #     rm -f /tmp/waybar-*.json
# # }
# #
# # trap cleanup EXIT
