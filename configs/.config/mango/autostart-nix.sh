#!/run/current-system/sw/bin/sh

# enable tearing
# export WLR_DRM_NO_ATOMIC=1

user=$(whoami)

# waybar
/run/current-system/sw/bin/pkill -f waybar
/etc/profiles/per-user/${user}/bin/waybar -c ~/.config/waybar/mango-config -s ~/.config/waybar/mango-style.css &

# wallpaper
/etc/profiles/per-user/${user}/bin/swaybg -i ~/Pictures/wallhaven.cc/vii.png &

# extra
# /usr/lib/xdg-desktop-portal-wlr &
/etc/profiles/per-user/${user}/bin/wl-paste --type text --watch cliphist store &
/etc/profiles/per-user/${user}/bin/wl-paste --type image --watch cliphist store &
# /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
