#!/bin/bash

# Detect monitors dynamically
INTERNAL=$(xrandr | grep "eDP" | grep " connected" | awk '{ print $1 }')
EXTERNAL=$(xrandr | grep "HDMI" | grep " connected" | awk '{ print $1 }')

# Apply layout
if [[ -n "$EXTERNAL" && -n "$INTERNAL" ]]; then
  # External and internal monitors connected
  xrandr --output "$INTERNAL" --auto --pos 0x0 \
         --output "$EXTERNAL" --primary --auto --left-of "$INTERNAL"
elif [[ -n "$EXTERNAL" ]]; then
  # Only external monitor connected
  xrandr --output "$EXTERNAL" --primary --auto \
         --output "$INTERNAL" --off
elif [[ -n "$INTERNAL" ]]; then
  # Only internal monitor connected
  xrandr --output "$INTERNAL" --primary --auto \
         --output "$EXTERNAL" --off
else
  echo "No connected monitors found."
fi

