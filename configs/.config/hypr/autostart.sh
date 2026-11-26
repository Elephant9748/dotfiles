#!/usr/bin/sh

# Execute your favorite apps at launch
# firefox

# config for polkit
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
# hyprland polkit
# /usr/libexec/hyprpolkitagent &
# kde polkit
# /usr/lib/polkit-kde-authentication-agent-1 &

hyprpaper & 
waybar & 
/home/rigel/.local/bin/xdg-portal-hyprland-nuclear & 
hyprctl setcursor "breeze_cursors" 16  
# /home/rigel/.local/bin/hyprland-paper &

