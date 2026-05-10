#!/usr/bin/sh

waybar &
autotiling-rs -w 6 2 &
wl-paste --type text --watch cliphist store &
wl-paste --type image --watch cliphist store &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
swaypaper -d ~/Pictures/wallhaven.cc/ &
