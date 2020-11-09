#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Find primary monitor
PRIM_MONITOR=$(polybar --list-monitors | grep 'primary' | cut -d":" -f1)

# Launch bar on all connected monitors
for m in $(polybar --list-monitors | cut -d":" -f1)
do
    polybarlogpath=/tmp/polybar_${m}.log
    echo "---" | tee -a $polybarlogpath

    if [ $PRIM_MONITOR = $m ]; then
        COMMAND='polybar mainbar-i3'
    else
        COMMAND='polybar sidebar-i3'
    fi

    echo "PRIM_MONITOR: $PRIM_MONITOR     m: $m" |
        awk '{ print strftime("%c: "), $0; fflush(); }' | tee -a $polybarlogpath

    echo "COMMAND used: $COMMAND" |
        awk '{ print strftime("%c: "), $0; fflush(); }' | tee -a $polybarlogpath

    MONITOR=$m $COMMAND 2>&1 | \
        awk '{ print strftime("%c: "), $0; fflush(); }' | tee -a $polybarlogpath &
done

echo "Bars launched..."
