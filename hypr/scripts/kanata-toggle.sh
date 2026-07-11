#!/usr/bin/env sh

KANATA_CMD="kanata -c /home/damiska/.config/kanata/main.kbd"

PID=$(pgrep -f "$KANATA_CMD")

if [ -n "$PID" ]; then
    kill "$PID"
    echo "Kanata ukončena (PID: $PID)"
else
    nohup $KANATA_CMD >/dev/null 2>&1 &
    echo "Kanata spuštěna"
fi
