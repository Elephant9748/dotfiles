#!/bin/sh

# waybar
pkill -f waybar
waybar -c ~/.config/waybar/mango-config -s ~/.config/waybar/mango-style.css &

# wallpaper
swaybg -i ~/Pictures/wallhaven.cc/vii.png &

# extra
/usr/lib/xdg-desktop-portal-wlr &
wl-paste --type text --watch cliphist store &
wl-paste --type image --watch cliphist store &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
