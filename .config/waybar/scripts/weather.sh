#!/bin/bash
# Weather script with F/C toggle

UNIT_FILE="/tmp/waybar_weather_fahrenheit"

if [ -f "$UNIT_FILE" ]; then
    UNIT="u"  # Fahrenheit
else
    UNIT="m"  # Celsius
fi

curl -s "wttr.in/?format=%c%t&${UNIT}" 2>/dev/null | tr -d '+' || echo "N/A"
