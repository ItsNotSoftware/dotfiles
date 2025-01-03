#!/bin/bash

CURRENT_LAYOUT=$(setxkbmap -query | grep layout | awk '{print $2}')

# Toggle between PT and US
if [ "$CURRENT_LAYOUT" == "us" ]; then
    setxkbmap pt
    echo "Switched to Portuguese layout (PT)"
elif [ "$CURRENT_LAYOUT" == "pt" ]; then
    setxkbmap us
    echo "Switched to US layout"
else
    echo "Unknown layout: $CURRENT_LAYOUT. Defaulting to US layout."
    setxkbmap us
fi
