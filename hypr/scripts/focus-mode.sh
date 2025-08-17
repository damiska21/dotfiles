#!/usr/bin/env bash

STATE_FILE="/tmp/zenmode"

# --- Tvoje default hodnoty ---
ROUNDING_DEFAULT=10
GAPS_IN_DEFAULT=5
GAPS_OUT_DEFAULT=20

# Pokud soubor neexistuje, nastav default "off"
if [ ! -f "$STATE_FILE" ]; then
    echo "off" > "$STATE_FILE"
fi

STATE=$(cat "$STATE_FILE")

if [ "$STATE" = "off" ]; then
    # --- Zapnout zen mód ---
    echo "on" > "$STATE_FILE"
    pkill waybar
    hyprctl keyword decoration:rounding 0
    hyprctl keyword general:gaps_in 0
    hyprctl keyword general:gaps_out 0
else
    # --- Vypnout zen mód ---
    echo "off" > "$STATE_FILE"
    waybar & disown
    hyprctl keyword decoration:rounding "$ROUNDING_DEFAULT"
    hyprctl keyword general:gaps_in "$GAPS_IN_DEFAULT"
    hyprctl keyword general:gaps_out "$GAPS_OUT_DEFAULT"
fi
