#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar on all connected monitors
for m in $(polybar --list-monitors | cut -d":" -f1)
do
    polybarlogpath=/tmp/polybar_${m}.log
    echo "---" | tee -a $polybarlogpath
    MONITOR=$m polybar mainbar-i3 2>&1 | awk '{ print strftime("%c: "), $0; fflush(); }' | tee -a $polybarlogpath  &
done

echo "Bars launched..."
