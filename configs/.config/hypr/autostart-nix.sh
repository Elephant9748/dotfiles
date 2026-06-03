#!/run/current-system/sw/bin/sh

user=$(whoami)

# Execute your favorite apps at launch
# waybar & 
# hyprpaper & 
# firefox

# config for polkit
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
# hyprland polkit
# /usr/libexec/hyprpolkitagent &
# kde polkit
# /usr/lib/polkit-kde-authentication-agent-1 &

# hyprpaper & 
/etc/profiles/per-user/${user}/bin/waybar & 
/home/rigel/utility/xdg-portall-hyprland-nuclear & 
hyprctl setcursor "breeze_cursors" 16  
# /home/rigel/.local/bin/hyprland-paper &

