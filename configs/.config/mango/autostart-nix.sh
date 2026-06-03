#!/run/current-system/sw/bin/sh

# waybar
/run/current-system/sw/bin/pkill -f waybar
/etc/profiles/per-user/ringo/bin/waybar -c ~/.config/waybar/mango-config -s ~/.config/waybar/mango-style.css &

# wallpaper
/etc/profiles/per-user/ringo/bin/swaybg -i ~/Pictures/wallhaven.cc/vii.png &

# extra
# /usr/lib/xdg-desktop-portal-wlr &
/etc/profiles/per-user/ringo/bin/wl-paste --type text --watch cliphist store &
/etc/profiles/per-user/ringo/bin/wl-paste --type image --watch cliphist store &
# /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
