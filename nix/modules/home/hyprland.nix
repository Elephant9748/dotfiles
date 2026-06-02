{ pkgs, version, lib,  ... }: {
    wayland.windowManager = {
            hyprland = {
                    enable = true;
                    configType = "lua";
                    xwayland = {
                            enable = true;
                    };
                    package = pkgs.hyprland;
                    portalPackage = pkgs.xdg-desktop-portal-hyprland;
                    # package = hypr.packages.${system}.hyprland;
                    # portalPackage = hypr.packages.${system}.xdg-desktop-portal-hyprland;

                    settings = {
                            monitor = [ 
                                        {
                                                output = "eDP-1";
                                                disabled = true;
                                        }
                                        {
                                                output = "HDMI-A-1";
                                                mode = "1280x1024@60";
                                                position = "0x0";
                                                scale = 1;
                                        }
                            ];
                            on = {
                                    _args = [
                                        "hyprland.start"
                                        (lib.generators.mkLuaInline "function()\n  hl.exec_cmd(\"~/.config/hypr/autostart-nix.sh\")\nend")
                                    ];
                            };
                            env = [
                                        # {
                                        #         _args = ["GTK_THEME" "Adwaita:dark"];
                                        # }
                                        {
                                                _args = ["QT_QPA_PLATFORM" "wayland;xcb"];
                                        }
                                        {
                                                _args = ["QT_QPA_PLATFORMTHEME" "qt5ct:qt6ct"];
                                        }
                                        # {
                                        #         _args = "GBM_BACKEND" "nvidia-drm"
                                        # }
                                        # {
                                        #         _args = "__GLX_VENDOR_LIBRARY_NAME" "nvidia"
                                        # }
                                        # {
                                        #         _args = "HYPRCURSOR_THEME,phinger-cursors-dark"
                                        # }
                                        {
                                                _args = ["HYPRCURSOR_THEME" "breeze_cursors"];
                                        }
                                        {
                                                _args = ["HYPRCURSOR_SIZE" "16"];
                                        }
                                        # {
                                        #         _args = "HYPRCURSOR_THEME" "Pop"
                                        # }
                                        # {
                                        #         _args = "HYPRCURSOR_SIZE" "14"
                                        # }
                            ];
                            window_rule = [
                                        {
                                                match = {
                                                        class = "Alacritty";
                                                };
                                                workspace = "2";
                                        }
                                        {
                                                match = {
                                                        class = "firefox-developer-edition";
                                                };
                                                workspace = "1";
                                        }
                                        {
                                                match = {
                                                        class = "Mullvad Browser Alpha";
                                                };
                                                workspace = "3";
                                        }
                                        {
                                                match = {
                                                        class = "chromium";
                                                };
                                                workspace = "3";
                                        }
                                        {
                                                match = {
                                                        class = "jetbrains-studio";
                                                };
                                                workspace = "3";
                                        }
                                        {
                                                match = {
                                                        class = "virt-manager";
                                                };
                                                workspace = "4";
                                        }
                                        {
                                                match = {
                                                        class = "org.gnome.Nautilus";
                                                };
                                                workspace = "4";
                                        }
                                        {
                                                match = {
                                                        class = "thunar";
                                                };
                                                workspace = "4";
                                        }
                                        {
                                                match = {
                                                        class = "Tor Browser Alpha";
                                                };
                                                workspace = "4";
                                        }
                                        {
                                                match = {
                                                        class = "com.raspberrypi.rpi-imager";
                                                };
                                                move = "1233 403";
                                                size = "680 651";
                                                float = true;
                                                pin = true;
                                        }
                                        {
                                                match = {
                                                        class = "localsend";
                                                };
                                                size = "400 731";
                                                move = "1487 320";
                                                float = true;
                                                pin = true;
                                        }
                                        {
                                                match = {
                                                        title = "Nextcloud";
                                                };
                                                float = true;
                                                move = "1532 4";
                                                size = "389 1054";
                                                workspace = "6";
                                        }
                                        {
                                                match = {
                                                        title = "Nextcloud Settings";
                                                };
                                                float = true;
                                                workspace = "6";
                                                move = "1382 7";
                                                size = "537 1050";
                                        }
                                        {
                                                match = {
                                                        title = "Cryptomator";
                                                };
                                                float = true;
                                                move = "1266 519";
                                                size = "650 537";
                                        }
                                        {
                                                match = {
                                                        class = "qemu-system-x86_64";
                                                };
                                                workspace = "4";
                                                float = false;
                                        }
                                        {
                                                match = {
                                                        title = "Signal";
                                                };
                                                float = true;
                                                move = "1230 228";
                                                size = "684 830";
                                        }
                                        {
                                                match = {
                                                        class = "steam";
                                                };
                                                float = true;
                                                move = "427 211";
                                                size = "1024 660";

                                        }
                                        {
                                                match = {
                                                        class = "scrcpy";
                                                };
                                                pin = true;
                                                float = true;
                                                move = "1459 71";
                                                size = "454 984";
                                        }
                                        {
                                                match = {
                                                        title = "Picture-in-Picture";
                                                };
                                                float = true;
                                                move = "322 12";
                                                size = "702 398";
                                                pin = true;
                                        }
                                        {
                                                match = {
                                                        class = "org.gnome.Calculator";
                                                };
                                                float = true;
                                                move = "1554 40";
                                                size = "360 616";
                                                pin = true;
                                        }
                                        {
                                                match = {
                                                        class = "veracrypt";
                                                };
                                                float = true;
                                                move = "1327 503";
                                                size = "584 553";
                                        }
                                        {
                                                match = {
                                                        class = "org.gnome.DiskUtility";
                                                };
                                                size = "592 598";
                                                move = "1323 459";
                                                float = true;
                                                pin = true;
                                        }
                                        {
                                                match = {
                                                        class = "Raspberry Pi Imager";
                                                };
                                                size = "585 520";
                                                move = "734 460";
                                                float = true;
                                                pin = true;
                                        }

                            ];
                            workspace_rule = {
                                    workspace = "6";
                                    # gaps_out = "50 394 50 50";
                                    gaps_out = {
                                            top = 50;
                                            right = 394;
                                            bottom = 50;
                                            left = 50;
                                    };
                                    gaps_in = 5;
                            };
                            curve = {
                                    _args = [
                                            "myBezier"
                                            { 
                                                    type = "bezier"; 
                                                    points = [ [0.05 0.9] [0.1 1.05] ];
                                            }
                                    ];
                            };
                            animation = [
                                    {
                                        leaf = "windows";
                                        enabled = true;
                                        speed = 7;
                                        bezier = "myBezier";
                                    }
                                    {
                                        leaf = "windowsOut";
                                        enabled = true;
                                        speed = 7;
                                        bezier = "default";
                                        style = "popin 80%";
                                    }
                                    {
                                        leaf = "border";
                                        enabled = true;
                                        speed = 10;
                                        bezier = "default";
                                    }
                                    {
                                        leaf = "borderangle";
                                        enabled = true;
                                        speed = 8;
                                        bezier = "default";
                                    }
                                    {
                                        leaf = "fade";
                                        enabled = true;
                                        speed = 7;
                                        bezier = "default";
                                    }
                                    # {
                                    #     leaf = "workspaces";
                                    #     enabled = true;
                                    #     speed = 6;
                                    #     bezier = "default";
                                    # }
                                    # {
                                    #     leaf = "workspaces";
                                    #     enabled = false;
                                    #     speed = 3;
                                    #     bezier = "default";
                                    # }
                                    # {
                                    #     leaf = "workspaces";
                                    #     enabled = true;
                                    #     speed = 6;
                                    #     bezier = "default";
                                    #     style = "slidefadevert -5%";
                                    # }
                                    {
                                        leaf = "workspaces";
                                        enabled = true;
                                        speed = 6;
                                        bezier = "default";
                                        style = "slidefadevert 5%";
                                    }
                                    # {
                                    #     leaf = "workspaces";
                                    #     enabled = true;
                                    #     speed = 6;
                                    #     bezier = "default";
                                    #     style = "slidefade -20%";
                                    # }
                                    # {
                                    #     leaf = "workspaces";
                                    #     enabled = true;
                                    #     speed = 6;
                                    #     bezier = "default";
                                    #     style = "slidefadevert";
                                    # }
                            ];
                            device = {
                                    _args = [
                                        {
                                                name = "epic-mouse-v1";
                                                sensitivity = -0.5;

                                        }
                                    ];
                            };
                            mainMod = {
                                    _var = "SUPER";
                            };
                            w1 = {
                                    _var = "hyprctl hyprpaper wallpaper \"HDMI-A-1, ~/Pictures/wallhaven.cc/i.png\"";
                            };
                            w2 = {
                                    _var = "hyprctl hyprpaper wallpaper \"HDMI-A-1, ~/Pictures/wallhaven.cc/ii.png\"";
                            };
                            w3 = {
                                    _var = "hyprctl hyprpaper wallpaper \"HDMI-A-1, ~/Pictures/wallhaven.cc/iii.png\"";
                            };
                            w4 = {
                                    _var = "hyprctl hyprpaper wallpaper \"HDMI-A-1, ~/Pictures/wallhaven.cc/iv.png\"";
                            };
                            w5 = {
                                    _var = "hyprctl hyprpaper wallpaper \"HDMI-A-1, ~/Pictures/wallhaven.cc/v.png\"";
                            };
                            w6 = {
                                    _var = "hyprctl hyprpaper wallpaper \"HDMI-A-1, ~/Pictures/wallhaven.cc/vi.png\"";
                            };
                            w7 = {
                                    _var = "hyprctl hyprpaper wallpaper \"HDMI-A-1, ~/Pictures/wallhaven.cc/vii.png\"";
                            };
                            bind = [
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod ..\" + T\"")
                                                (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"alacritty\")")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod ..\" + SHIFT + C\"")
                                                (lib.generators.mkLuaInline "hl.dsp.window.close()")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod ..\" + mouse:274\"")
                                                (lib.generators.mkLuaInline "hl.dsp.window.close()")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod ..\" + SHIFT + Q\"")
                                                (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"hyprctl dispatch 'hl.dsp.exit()'\")")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + R\"")
                                                (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"hyprctl reload\")")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + E\"")
                                                (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"thunar\")")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + SHIFT + S\"")
                                                (lib.generators.mkLuaInline "hl.dsp.window.float({ action = \"toggle\" })")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + P\"")
                                                (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"rofi -opacity 80 -show drun\")")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + C\"")
                                                (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"rofi -show calc -modi calc -no-show-match -no-sort -no-history -calc-command \\\"echo '{result}' | wl-copy\\\"\")")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + SHIFT + P\"")
                                                (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"rofi -show power-menu -modi \\\"power-menu:rofi-power-menu --choices=shutdown/lockscreen/logout/reboot\\\"\")")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + SHIFT + D\"")
                                                (lib.generators.mkLuaInline "hl.dsp.window.pseudo()")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + SHIFT + O\"")
                                                (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"hyprpicker -a --format=hex\")")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + N\"")
                                                (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"nm-applet\")")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + SHIFT + N\"")
                                                (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"/usr/bin/kill nm-applet\")")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + B\"")
                                                (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"waybar &\")")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + SHIFT + B\"")
                                                (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"/usr/bin/kill waybar\")")
                                        ];
                                }
                                {
                                        _args = [
                                                "XF86AudioRaiseVolume"
                                                (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+\")")
                                                {
                                                        locked = true; 
                                                        repeating = true;
                                                }
                                        ];
                                }
                                {
                                        _args = [
                                                "XF86AudioLowerVolume"
                                                (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-\")")
                                                {
                                                        locked = true; 
                                                        repeating = true;
                                                }
                                        ];
                                }
                                {
                                        _args = [
                                                "XF86AudioMute"
                                                (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle\")")
                                                {
                                                        locked = true; 
                                                        repeating = true;
                                                }
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + W\"")
                                                (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"wl-copy -c\")")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + SHIFT + X\"")
                                                (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"grim -g \\\"$(slurp)\\\" - | swappy -f -\")")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + SHIFT + N\"")
                                                (lib.generators.mkLuaInline "hl.dsp.exec_cmd(\"hyprctl dismissnotify\")")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + h\"")
                                                (lib.generators.mkLuaInline "hl.dsp.focus({ direction = \"left\" })")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + l\"")
                                                (lib.generators.mkLuaInline "hl.dsp.focus({ direction = \"right\" })")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + k\"")
                                                (lib.generators.mkLuaInline "hl.dsp.focus({ direction = \"up\" })")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + j\"")
                                                (lib.generators.mkLuaInline "hl.dsp.focus({ direction = \"down\" })")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + SHIFT + h\"")
                                                (lib.generators.mkLuaInline "hl.dsp.window.move({ direction = \"l\" })")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + SHIFT + l\"")
                                                (lib.generators.mkLuaInline "hl.dsp.window.move({ direction = \"r\" })")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + SHIFT + k\"")
                                                (lib.generators.mkLuaInline "hl.dsp.window.move({ direction = \"u\" })")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + SHIFT + j\"")
                                                (lib.generators.mkLuaInline "hl.dsp.window.move({ direction = \"d\" })")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + SHIFT + ALT + h\"")
                                                (lib.generators.mkLuaInline "hl.dsp.window.resize({ x = 10, y = 0, relative = true })")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + SHIFT + ALT + l\"")
                                                (lib.generators.mkLuaInline "hl.dsp.window.resize({ x = -10, y = 0, relative = true })")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + SHIFT + ALT + k\"")
                                                (lib.generators.mkLuaInline "hl.dsp.window.resize({ x = 0, y = -10, relative = true })")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + SHIFT + ALT + j\"")
                                                (lib.generators.mkLuaInline "hl.dsp.window.resize({ x = 0, y = 10, relative = true })")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + 1\"")
                                                (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 1 })")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + 2\"")
                                                (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 2 })")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + 2\"")
                                                (lib.generators.mkLuaInline "hl.dsp.exec_cmd(w2)")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + 3\"")
                                                (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 3 })")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + 3\"")
                                                (lib.generators.mkLuaInline "hl.dsp.exec_cmd(w3)")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + 4\"")
                                                (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 4 })")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + 4\"")
                                                (lib.generators.mkLuaInline "hl.dsp.exec_cmd(w4)")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + 5\"")
                                                (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 5 })")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + 5\"")
                                                (lib.generators.mkLuaInline "hl.dsp.exec_cmd(w5)")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + 6\"")
                                                (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 6 })")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + 6\"")
                                                (lib.generators.mkLuaInline "hl.dsp.exec_cmd(w6)")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + 7\"")
                                                (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 7 })")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + 7\"")
                                                (lib.generators.mkLuaInline "hl.dsp.exec_cmd(w7)")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + 8\"")
                                                (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 8 })")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + 9\"")
                                                (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 9 })")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + 0\"")
                                                (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = 10 })")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + SHIFT + 1\"")
                                                (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 1 })")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + SHIFT + 2\"")
                                                (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 2 })")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + SHIFT + 2\"")
                                                (lib.generators.mkLuaInline "hl.dsp.exec_cmd(w2)")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + SHIFT + 3\"")
                                                (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 3 })")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + SHIFT + 3\"")
                                                (lib.generators.mkLuaInline "hl.dsp.exec_cmd(w3)")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + SHIFT + 4\"")
                                                (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 4 })")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + SHIFT + 4\"")
                                                (lib.generators.mkLuaInline "hl.dsp.exec_cmd(w4)")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + SHIFT + 5\"")
                                                (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 5 })")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + SHIFT + 5\"")
                                                (lib.generators.mkLuaInline "hl.dsp.exec_cmd(w5)")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + SHIFT + 6\"")
                                                (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 6 })")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + SHIFT + 6\"")
                                                (lib.generators.mkLuaInline "hl.dsp.exec_cmd(w6)")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + SHIFT + 7\"")
                                                (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 7 })")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + SHIFT + 7\"")
                                                (lib.generators.mkLuaInline "hl.dsp.exec_cmd(w7)")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + SHIFT + 8\"")
                                                (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 8 })")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + SHIFT + 9\"")
                                                (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 9 })")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + SHIFT + 0\"")
                                                (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = 10 })")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + mouse_down\"")
                                                (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = \"e+1\" })")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + mouse_up\"")
                                                (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = \"e-1\" })")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + mouse:272\"")
                                                (lib.generators.mkLuaInline "hl.dsp.window.drag()")
                                        ];
                                }
                                {
                                        _args = [
                                                (lib.generators.mkLuaInline "mainMod .. \" + mouse:273\"")
                                                (lib.generators.mkLuaInline "hl.dsp.window.resize()")
                                        ];
                                }
                            ];
                            config = {
                                    ecosystem = {
                                            no_update_news = true;
                                    };
                                    # xwayland = {
                                    #         create_abstract_socket = true;
                                    #         force_zero_scaling = true;
                                    # };

                                    input = {
                                            kb_layout = "us";
                                            kb_variant = "";
                                            kb_model = "";
                                            kb_options = "";
                                            kb_rules = "";
                                            follow_mouse = 1;
                                            touchpad = {
                                                    natural_scroll = false;
                                            };
                                            sensitivity = 0; # 1.0 - 1.0, 0 means no modification.
                                    };
                                    general = {
                                            gaps_in = 1;
                                            gaps_out = 3;
                                            border_size = 1;
                                            col = {
                                                    active_border = { colors = [ "rgba(427B58ee)" "rgba(076678ee)"]; angle = 45; };
                                                    #  active_border = { colors = [ "rgba(33ccffee)" "rgba(00ff99ee)"]; angle = 45;};
                                                    #  active_border = { colors = [ "rgba(356F89ee)" "rgba(519C62ee)"]; angle = 45;};
                                                    #  active_border = { colors = [ "rgba(E0431Aee)" "rgba(304F47ee)"]; angle = 45;};
                                                    #  active_border = { colors = [ "rgba(40281Bee)" "rgba(3C3836ee)"]; angle = 45;};
                                                    #  active_border = { colors = [ "rgba(7C6F64ee)" "rgba(3C3836ee)"]; angle = 45;};
                                                    inactive_border = "rgba(595959aa)";
                                            };
                                            layout = "dwindle";
                                    };
                                    decoration = {
                                            rounding = 1;
                                            blur = {
                                                    enabled = false;
                                                    size = 3;
                                                    passes = 1;
                                            };
                                            shadow = {
                                                    enabled = false;
                                                    range = 4;
                                                    render_power = 3;
                                                    color = "rgba(1a1a1aee)";
                                            };
                                    };
                                    misc = {
                                            force_default_wallpaper = 0;
                                            disable_hyprland_logo = true;
                                            disable_splash_rendering = true;
                                            mouse_move_enables_dpms = true;
                                            key_press_enables_dpms = true;
                                            vrr = 1;
                                    };
                                    animations = {
                                            enabled = true; 
                                    };
                                    dwindle = {
                                            preserve_split = true; 
                                            smart_resizing = true;
                                    };
                                    master = {
                                            # new_is_master = false;
                                            new_status = "slave";
                                    };
                            };
                    };
            };
    };

}
