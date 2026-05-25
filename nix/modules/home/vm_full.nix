{ pkgs, version,  ... }: {
    home.packages = with pkgs; [
        fastfetch
        alacritty
        nerd-fonts.jetbrains-mono
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts
        public-sans
        tmux
        rofi
        hyprcursor
        hyprpaper
        wl-clipboard
        imagemagick
        pavucontrol
        pulseaudio
        nwg-look
        rofi-power-menu
        rofi-calc
        cryptomator
        libreoffice-fresh
        obs-studio 
        qutebrowser
        firefox-devedition
        wmctrl
        termusic
        audacity
        signal-desktop
        mpv
        grim
        slurp
        localsend
        # rust-bin.stable.latest.default
    ];

    programs.waybar = {
            enable = true;
            package = pkgs.waybar;
    };

    xdg.portal = {
            enable = true;
            extraPortals = with pkgs; [
                xdg-desktop-portal-hyprland
                xdg-desktop-portal-gnome
                xdg-desktop-portal-gtk
                xdg-desktop-portal
            ];
    };

    wayland.windowManager = {
            hyprland = {
                    enable = true;
                    configType = "hyprlang";
                    xwayland = {
                            enable = true;
                    };
                    package = pkgs.hyprland;
                    portalPackage = pkgs.xdg-desktop-portal-hyprland;
                    # package = hypr.packages.${system}.hyprland;
                    # portalPackage = hypr.packages.${system}.xdg-desktop-portal-hyprland;

                    settings = {
                            exec-once = [ " ~/.config/hypr/autostart.sh "];
                            monitor = [ 
                                ",1024x768@60,0x0,1" 
                                "eDP-1,disable" 
                            ];
                            env = [
                                "GDK_BACKEND, wayland,x11i"
                                "QT_QPA_PLATFORM,wayland;xcb"
                                "HYPRCURSOR_THEME,breeze_cursors"
                                "HYPRCURSOR_SIZE,16"
                            ];
                            windowrule = [
                                "workspace 2, match:class Alacritty"
                                "workspace 1, match:class firefox-developer-edition"
                                "workspace 3, match:class Mullvad Browser Alpha"
                                "workspace 3, match:class chromium"
                                "workspace 3, match:class jetbrains-studio"
                                "workspace 4, match:class virt-manager"
                                "workspace 4, match:class org.gnome.Nautilus"
                                "workspace 4, match:class thunar"
                                "workspace 4, match:class Tor Browser Alpha"
                                "match:class com.raspberrypi.rpi-imager, move 1233 403, size 680 651, float on, pin on"
                                "match:class localsend, size 400 731, move 1487 320, float on, pin on"
                                "match:title Nextcloud, float on, move 1532 4, size 389 1054, workspace 6"
                                "match:title Nextcloud Settings, float on, workspace 6, move 1382 7, size 537 1050"
                                "match:title Cryptomator, float on, move 1266 519, size 650 537"
                                "match:class qemu-system-x86_64, workspace 4, tile on"
                                "match:title Signal, float on, move 1230 228, size 684 830"
                                "match:class steam, float on, move 427 211, size 1024 660"
                                "match:class scrcpy, pin on, float on, move 1459 71, size 454 984"
                                "match:title Picture-in-Picture, float on, move 322 12, size 702 398, pin on"
                                "match:class org.gnome.Calculator, float on, move 1554 40, size 360 616, pin on"
                                "match:class veracrypt, float on, move 1327 503, size 584 553"
                                "match:class org.gnome.DiskUtility, size 592 598, move 1323 459, float on, pin on"
                                "match:class Raspberry Pi Imager, size 585 520, move 734 460, float on, pin on"
                            ];
                            ecosystem = {
                                    no_update_news = true;
                            };
                            input = {
                                kb_layout = "us";
                                kb_variant = "";
                                kb_model = "";
                                kb_options = "";
                                kb_rules = "";
                                follow_mouse = "1";
                                touchpad = {
                                    natural_scroll = "no";
                                };
                                sensitivity = "0";
                            };
                            general = {
                                gaps_in = "1";
                                gaps_out = "3";
                                border_size = "1";
                                col.active_border = "rgba(427B58ee) rgba(076678ee) 45deg";
                                col.inactive_border = "rgba(595959aa)";
                                layout = "dwindle";
                            };
                            decoration = {
                                rounding = "1";
                                blur = {
                                    enabled = false;
                                    size = "3";
                                    passes = "1";
                                };
                                shadow = {
                                    enabled = false;
                                    range = "4";
                                    render_power = "3";
                                    color = "rgba(1a1a1aee)";
                                };
                            };
                            misc = {
                                    force_default_wallpaper = "0";
                                    disable_hyprland_logo = true;
                                    disable_splash_rendering = true;
                                    mouse_move_enables_dpms = true;
                                    key_press_enables_dpms = true;
                                    vrr = "1";
                            };
                            animations = {
                                enabled = "yes"; 
                                bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
                                animation = [
                                                "windows, 1, 7, myBezier"
                                                "windowsOut, 1, 7, default, popin 80%"
                                                "border, 1, 10, default"
                                                "borderangle, 1, 8, default"
                                                "fade, 1, 7, default"
                                                "workspaces, 1, 6, default, slidefadevert 5%"
                                ];
                            };
                            dwindle = {
                                preserve_split = "yes";
                                smart_resizing = "yes";
                            };
                            master = {
                                new_status = "slave";
                            };
                            device = {
                                    name = "epic-mouse-v1";
                                    sensitivity = "-0.5";
                            };
                            "$mainMod" = "SUPER";
                            bind = [
                                        "$mainMod, T, exec, alacritty"
                                        "$mainMod SHIFT, C, killactive, "
                                        "$mainMod, mouse:274, killactive"
                                        "$mainMod SHIFT, Q, exec, hyprctl dispatch exit"
                                        "$mainMod, R, exec, hyprctl reload,"
                                        "$mainMod, E, exec, thunar"
                                        "$mainMod SHIFT, S, togglefloating, "
                                        "$mainMod, P, exec, rofi -opacity 80 -show drun"
                                        "$mainMod, C, exec, rofi -show calc -modi calc -no-show-match -no-sort -no-history -calc-command \"echo '{result}' | wl-copy\""
                                        "$mainMod SHIFT, P, exec, rofi -show power-menu -modi \"power-menu:rofi-power-menu --choices=shutdown/lockscreen/logout/reboot\""
                                        "$mainMod SHIFT, D, pseudo," 
                                        "$mainMod SHIFT, O, exec, hyprpicker -a --format=hex "
                                        "$mainMod, N, exec, nm-applet"
                                        "$mainMod SHIFT, N, exec, /usr/bin/kill nm-applet"
                                        "$mainMod, B, exec, waybar &"
                                        "$mainMod SHIFT, B, exec, /usr/bin/kill waybar"
                                        "$mainMod SHIFT, X, exec, grim -g \"$(slurp)\" - | swappy -f -"
                                        "$mainMod SHIFT, N, exec, hyprctl dismissnotify"
                                        "$mainMod, h, movefocus, l"
                                        "$mainMod, l, movefocus, r"
                                        "$mainMod, k, movefocus, u"
                                        "$mainMod, j, movefocus, d"
                                        "$mainMod SHIFT, h, movewindow, l"
                                        "$mainMod SHIFT, l, movewindow, r"
                                        "$mainMod SHIFT, k, movewindow, u"
                                        "$mainMod SHIFT, j, movewindow, d"
                                        "$mainMod SHIFT ALT, h, resizeactive, 10 0 "
                                        "$mainMod SHIFT ALT, l, resizeactive, -10 0"
                                        "$mainMod SHIFT ALT, k, resizeactive, 0 -10"
                                        "$mainMod SHIFT ALT, j, resizeactive, 0 10"
                                        "$mainMod, 1, workspace, 1"
                                        "$mainMod, 2, workspace, 2"
                                        "$mainMod, 2, exec,$w2" # hyprpaper set wallpaper
                                        "$mainMod, 3, workspace, 3"
                                        "$mainMod, 3, exec,$w3" # hyprpaper set wallpaper
                                        "$mainMod, 4, workspace, 4"
                                        "$mainMod, 4, exec,$w4" # hyprpaper set wallpaper
                                        "$mainMod, 5, workspace, 5"
                                        "$mainMod, 5, exec,$w5" # hyprpaper set wallpaper
                                        "$mainMod, 6, workspace, 6"
                                        "$mainMod, 6, exec,$w6" # hyprpaper set wallpaper
                                        "$mainMod, 7, workspace, 7"
                                        "$mainMod, 7, exec,$w7" # hyprpaper set wallpaper
                                        "$mainMod, 8, workspace, 8"
                                        "$mainMod, 9, workspace, 9"
                                        "$mainMod, 0, workspace, 10"
                                        "$mainMod SHIFT, 1, movetoworkspace, 1"
                                        "$mainMod SHIFT, 2, movetoworkspace, 2"
                                        "$mainMod SHIFT, 2, exec,$w2" # hyprpaper set wallpaper
                                        "$mainMod SHIFT, 3, movetoworkspace, 3"
                                        "$mainMod SHIFT, 3, exec,$w3" # hyprpaper set wallpaper
                                        "$mainMod SHIFT, 4, movetoworkspace, 4"
                                        "$mainMod SHIFT, 4, exec,$w4" # hyprpaper set wallpaper
                                        "$mainMod SHIFT, 5, movetoworkspace, 5"
                                        "$mainMod SHIFT, 5, exec,$w5" # hyprpaper set wallpaper
                                        "$mainMod SHIFT, 6, movetoworkspace, 6"
                                        "$mainMod SHIFT, 6, exec,$w6" # hyprpaper set wallpaper
                                        "$mainMod SHIFT, 7, movetoworkspace, 7"
                                        "$mainMod SHIFT, 7, exec,$w7" # hyprpaper set wallpaper
                                        "$mainMod SHIFT, 8, movetoworkspace, 8"
                                        "$mainMod SHIFT, 9, movetoworkspace, 9"
                                        "$mainMod SHIFT, 0, movetoworkspace, 10"
                                        "$mainMod, mouse_down, workspace, e+1"
                                        "$mainMod, mouse_up, workspace, e-1"
                            ];
                            bindel = [
                                        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
                                        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
                                        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
                            ];
                            bindm = [
                                        "$mainMod, mouse:272, movewindow"
                                        "$mainMod, mouse:273, resizewindow"
                            ];
                            "$w1" = "hyprctl hyprpaper wallpaper \"HDMI-A-1, ~/Pictures/wallhaven.cc/i.png\"";
                            "$w2" = "hyprctl hyprpaper wallpaper \"HDMI-A-1, ~/Pictures/wallhaven.cc/ii.png\"";
                            "$w3" = "hyprctl hyprpaper wallpaper \"HDMI-A-1, ~/Pictures/wallhaven.cc/iii.png\"";
                            "$w4" = "hyprctl hyprpaper wallpaper \"HDMI-A-1, ~/Pictures/wallhaven.cc/iv.png\"";
                            "$w5" = "hyprctl hyprpaper wallpaper \"HDMI-A-1, ~/Pictures/wallhaven.cc/v.png\"";
                            "$w6" = "hyprctl hyprpaper wallpaper \"HDMI-A-1, ~/Pictures/wallhaven.cc/vi.png\"";
                            "$w7" = "hyprctl hyprpaper wallpaper \"HDMI-A-1, ~/Pictures/wallhaven.cc/vii.png\"";
                    };
            };
    };

    services = {
            polkit-gnome = {
                    enable = true;
                    package = pkgs.polkit_gnome;
            };
    };

    home.stateVersion = "${version}";

    # --------------------------------------------------
    # Due to the home-manager taking so long on boot time
    #             JUST RESTORE MANUAL
    # --------------------------------------------------

    # home.file.".config/nvim" = {
    #     source = ../../../configs/.config/nvim;
    #     recursive = true;
    # };

    # fish
    # ----
    # manual copy need constant w access
    # ----


    # home.file.".config/alacritty" = {
    #     source = ../../../configs/.config/alacritty;
    #     recursive = true;
    # };
    # home.file.".config/bat" = {
    #     source = ../../../configs/.config/bat;
    #     recursive = true;
    # };
    # home.file.".config/bottom" = {
    #     source = ../../../configs/.config/bottom;
    #     recursive = true;
    # };
    # home.file.".config/dunst/dunstrc" = {
    #     source = ../../../configs/.config/dunst/dunstrc;
    #     recursive = true;
    # };

    # gtk-*
    # ------
    # manual copy need w access
    # required by nwg-look

    # home.file.".config/hypr" = {
    #     source = ../../../configs/.config/hypr;
    #     recursive = true;
    # };
    #
    # home.file.".config/rofi" = {
    #     source = ../../../configs/.config/rofi;
    #     recursive = true;
    # };
    # home.file.".config/swappy" = {
    #     source = ../../../configs/.config/swappy;
    #     recursive = true;
    # };
    # home.file.".config/sway" = {
    #     source = ../../../configs/.config/sway;
    #     recursive = true;
    # };
    # home.file.".config/waybar" = {
    #     source = ../../../configs/.config/waybar;
    #     recursive = true;
    # };
    # home.file.".config/yazi" = {
    #     source = ../../../configs/.config/yazi;
    #     recursive = true;
    # };
    #
    # home.file.".local/share/icons" = {
    #     source = ../../../configs/icons;
    #     recursive = true;
    # };
    # home.file.".tmux.conf" = {
    #     source = ../../../configs/tmux/.tmux.conf;
    #     recursive = true;
    # };
}
