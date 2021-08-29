#!/usr/bin/env bash

date >> $HOME/temp/qtileautostart_test

udiskie -A --notify --smart-tray &
start-pulseaudio-x11 &
pa-applet &!
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
nitrogen --restore; sleep 1; picom -b &
nm-applet &
xfce4-power-manager &
pamac-tray &
clipit &
xautolock -time 10 -locker i3exit_custom lock &
