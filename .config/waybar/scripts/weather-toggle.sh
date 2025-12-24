#!/bin/bash
# Toggle between Celsius and Fahrenheit

UNIT_FILE="/tmp/waybar_weather_fahrenheit"

if [ -f "$UNIT_FILE" ]; then
    rm "$UNIT_FILE"
else
    touch "$UNIT_FILE"
fi

# Signal waybar to refresh the weather module
pkill -RTMIN+8 waybar
