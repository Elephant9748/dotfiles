{ pkgs, version,  ... }: {
    home.packages = with pkgs; [
        fastfetch
        waybar
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
        # rust-bin.stable.latest.default
    ];

    programs.waybar = {
            enable = true;
            package = pkgs.waybar;
    };

	programs.fish.loginShellInit = ''
            if test (tty) = "/dev/tty1"; and test -z "$WAYLAND_DISPLAY"; and test -n "$XDG_VTNR"; and test "$XDG_VTNR" -eq 1
                    exec start-hyprland
            end
    '';

    services = {
            polkit-gnome = {
                    enable = true;
                    package = pkgs.polkit_gnome;
            };
    };

    xdg.portal = {
            enable = true;
            extraPortals = with pkgs; [
                xdg-desktop-portal-hyprland
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
            };
    };

    home.stateVersion = "${version}";

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
    #
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
