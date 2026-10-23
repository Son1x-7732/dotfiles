#!/bin/bash
MONITOR="HDMI-A-1" 
STATE_FILE="/tmp/niri_rotation_state_${MONITOR}"

if [ -f "$STATE_FILE" ]; then
    # The state file exists, meaning it's currently portrait.
    # Revert back to horizontal (normal) and delete the state file.
    niri msg output "$MONITOR" transform normal
    rm "$STATE_FILE"
else
    # No state file, meaning it's horizontal. 
    # Rotate to portrait (90 degrees) and create the state file.
    # (If your monitor rotates the other way, change '90' to '270')
    niri msg output "$MONITOR" transform 270
    touch "$STATE_FILE"
fi