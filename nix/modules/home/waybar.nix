{ pkgs, version, lib,  ... }: {

    home.file.".config/waybar/mango-config" = {
        source = ../../../configs/.config/waybar/mango-config-nix;
        recursive = true;
    };

    home.file.".config/waybar/mango-style.css" = {
        source = ../../../configs/.config/waybar/mango-style-nix.css;
        recursive = true;
    };

    # config & style from dotfiles
    programs.waybar = {
            enable = true;
            package = pkgs.waybar;
            # systemd.enable = true;
            style = builtins.readFile ../../../configs/.config/waybar/style.css;
            settings = {
                    mainbar = {
                            position = "bottom";
                            modules-left = ["clock" "hyprland/workspaces"];
                            modules-center = ["hyprland/window"];
                            modules-right = ["network" "pulseaudio/slider" "pulseaudio" "cpu" "memory" "battery" "privacy" "tray"];
                            "hyprland/workspaces" = {
		                                "disable-scroll" = true;
                                        "all-outputs" = false;
                                        "format" = "{icon}";
                                        "sort-by-number" = true;
                                        "sort-by-name" = true;
                                        # "on-click" = "activate";
                                        "format-icons" = {
                                                "1" = "web";
                                                "2" = "code";
                                                "3" = "3";
                                                "4" = "4";
                                                "5" = "5";
                                                "6" = "6";
                                                "7" = "7";
                                                "urgent" = "";
                                                "focused" = "";
                                                "default" = "";
                                        };
                                        "persistent-workspaces" = {
                                                "1" = [];
                                                "2" = [];
                                                "3" = [];
                                                "4" = [];
                                                "5" = [];
                                                "6" = [];
                                                "7" = [];
                                        };
                            };
                            "pulseaudio/slider" = {
                                    "min" = 0;
                                    "max" = 145;
                                    "orientation" = "horizontal";
                            };
                            "custom/clock_manual" = {
                                    "exec" = "~/project/dotfiles/scripts/arch/clock_manual_waybar";
                                    "interval" = 1;
                            };
                            "wlr/mode" = {
                                    "format" = "<span style=\"italic\">{}</span>";
                            };
                            "custom/arch_update" = {
                                    "format" = "<span color='#589df6'></span>{}";
                                    "interval" = 30;
                                    "exec" = "~/.config/i3blocks/bin/arch_update.py -b '#e4e4e4' -u '#e4e4e4' -q";
                            };
                            "custom/disk_home" = {
                                    "format" = "🏠 {} ";
                                    "interval" = 30;
                                    "exec" = "df -h --output=avail $HOME | tail -1 | tr -d ' '";
                            };
                            "custom/disk_root" = {
                                    "format" = "💽 {} ";
                                    "interval" = 30;
                                    "exec" = "df -h --output=avail / | tail -1 | tr -d ' '";
                            };
                            "temperature" = {
                                    "critical-threshold" = 80;
                                    "format" = "<span color='#e88939'>{icon}</span> {temperatureC}°C";
                                    "format-icons" = ["" "" ""];
                            };
                            "cpu" = {
                                    "format" = " {usage}%";
                                    "tooltip" = false;
                                    "states" = {
                                            "normal" = 0;
                                            "medium" = 50;
                                            "high" = 70;
                                    };
                            };
                            "memory" = {
                                    "format" = " {used:0.1f}G";
                                    "states" = {
                                            "normal" = 0;
                                            "medium" = 50;
                                            "high" = 70;
                                    };
                            };
                            "custom/mail" = {
                                    "format" = "📩{}";
                                    "interval" = 30;
                                    "exec" = "notmuch count tag:flagged OR tag:inbox AND NOT tag:killed";
                            };
                            "network" = {
                                    "family" = "ipv4";
                                    "format-wifi" = "<span color='#6D8086'> </span> <span color='#3C3836'>{signalStrength}% {signaldBm}dBm</span> ";
                                    "format-ethernet" = "<span color='#6D8086'>🖧 </span> <span color='#3C3836'>{ifname}</span> ";
                                    "format-linked" = "{ifname} (No IP) ";
                                    "format-disconnected" = "Disconnected ⚠";
                                    "format-alt" = "{essid} {ifname} = {ipaddr}/{cidr}";
                                    "interval" = 5;
                            };
                            "backlight" = {
                                    "format" = "{icon} {percent}%";
                                    "format-icons" = ["🔅" "🔆"];
                            };
                            "pulseaudio" = {
                                    "format" = "  {volume}% {format_source}";
                                    "format-muted" = "🔇 {format_source}";
                                    "format-bluetooth" = "{icon} {volume}% {format_source}";
                                    "format-bluetooth-muted" = "🔇 {format_source}";

                                    "format-source" = " {volume}%";
                                    "format-source-muted" = "";
                                    "max-volume" = 145;

                                    "format-icons" = {
                                            "headphones" = "";
                                            "handsfree" = "";
                                            "headset" = "";
                                            "phone" = "";
                                            "portable" = "";
                                            "car" = "";
                                            "default" = ["🔈" "🔉" "🔊"];
                                    };
                                    "on-click-right" = "pavucontrol";
                            };
                            "clock" = {
                                    "interval" = 1;
                                    "format" = "⏲ {:%a %d %b %I:%M %p}";
                                    "tooltip-format" = "{:%Y-%m-%d | %H:%M:%S}";
                                    "timezone" = "Asia/Jakarta";
                            };
                            "battery" = {
                                    "states" = {
                                            "warning" = 20;
                                            "critical" = 10;
                                    };
                                    "format" = "<span color='#e88939'>{icon}</span> {capacity}% ({time})";
                                    "format-charging" = "<span color='#e88939'> </span>{capacity}%";
                                    "format-plugged" =  "<span color='#e88939'>{icon} </span> {capacity}% ({time})";
                                    "format-icons" = [" " " " " " " " " "];
                            };
                            "battery#bat1" = {
                                    "bat" = "BAT1";
                            };
                            "idle_inhibitor" = {
                                    "format" = "<span color='#589df6'>{icon}</span>";
                                    "format-icons" = {
                                            "activated" = "";
                                            "deactivated" = "";
                                    };
                                    "on-click-right" = "wlrlock -eFfki ~/.config/lockscreen-origin.png";
                            };
                            "tray" = {
                                    "icon-size" = 12;
                                    "spacing" = 10;
                            };
                            "custom/media" = {
                                    "format" = "{icon} {}";
                                    "return-type" = "json";
                                    "max-length" = 40;
                                    "format-icons" = {
                                            "spotify" = "";
                                            "default" = "🎜";
                                    };
                                    "escape" = true;
                                    "exec" = "$HOME/.config/waybar/mediaplayer.py 2> /dev/null"; # Script in resources folder
                            };
                            "mpd" = {
                                    "format" = "{stateIcon} {consumeIcon}{randomIcon}{repeatIcon}{singleIcon}{artist} - {album} - {title} ({elapsedTime:%M:%S}/{totalTime:%M:%S}) ";
                                    "format-disconnected" = "Disconnected ";
                                    "format-stopped" = "{consumeIcon}{randomIcon}{repeatIcon}{singleIcon}Stopped ";
                                    "unknown-tag" = "N/A";
                                    "interval" = 2;
                                    "consume-icons" = {
                                            "on" = " ";
                                    };
                                    "random-icons" = {
                                            "off" = "<span color=\"#f53c3c\"></span> ";
                                            "on" = " ";
                                    };
                                    "repeat-icons" = {
                                            "on" = " ";
                                    };
                                    "single-icons" = {
                                            "on" = "1 ";
                                    };
                                    "state-icons" = {
                                            "paused" = "";
                                            "playing" = "";
                                    };
                                    "tooltip-format" = "MPD (connected)";
                                    "tooltip-format-disconnected" = "MPD (disconnected)";
                            };
                            "privacy" = {
                                    "icon-spacing" = 4;
                                    "icon-size" = 14;
                                    "transition-duration" = 250;
                                    "modules" = [
                                    {
                                            "type" = "screenshare";
                                            "tooltip" = true;
                                            "tooltip-icon-size" = 16;
                                    }
                                    {
                                            "type" = "audio-out";
                                            "tooltip" = true;
                                            "tooltip-icon-size" = 16;
                                    }
                                    {
                                            "type" = "audio-in";
                                            "tooltip" = true;
                                            "tooltip-icon-size" = 16;
                                    }
                                    ];
                            };
                    };
            };
    };
}
