#!/bin/bash

# Kill existing waybar instances
pkill waybar

# Single config now handles all monitors
waybar &
