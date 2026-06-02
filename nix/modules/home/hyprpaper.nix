{ pkgs, version, lib,  ... }: {
        services.hyprpaper = {
                package = pkgs.hyprpaper;
                enable = true;
                settings = {
                        # preload = ~/Pictures/wallhaven.cc/i.png
                        preload = [
                                "~/Pictures/wallhaven.cc/ii.png"
                                "~/Pictures/wallhaven.cc/iii.png"
                                "~/Pictures/wallhaven.cc/iv.png"
                                "~/Pictures/wallhaven.cc/v.png"
                                "~/Pictures/wallhaven.cc/vi.png"
                                "~/Pictures/wallhaven.cc/vii.png"
                        ];
                        wallpaper = [
                                { 
                                        monitor = "Virtual-1";
                                        path = "~/Pictures/wallhaven.cc/ii.png";
                                        fit_mode = "cover";
                                }
                                { 
                                        monitor = "HDMI-A-1";
                                        path = "~/Pictures/wallhaven.cc/ii.png";
                                        fit_mode = "cover";
                                }
                                { 
                                        monitor = "eDP-1";
                                        path = "~/Pictures/wallhaven.cc/ii.png";
                                        fit_mode = "cover";
                                } 
                        ];
                        #splash = false
                        #ipc = off #off safe battery life
                        splash = false;
                        ipc = true; #off safe battery life
                };
        };
}
