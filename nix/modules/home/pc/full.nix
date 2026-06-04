{ pkgs, version,  ... }: {

    imports = [
        ../waybar.nix
        ../hyprland.nix
        ../gtk.nix
        ../hyprpaper.nix
    ];

    home.packages = with pkgs; [
        fastfetch
        alacritty
        nerd-fonts.jetbrains-mono
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts
        cantarell-fonts
        public-sans
        tmux
        rofi
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
        # gsettings-desktop-schemas
        # glib
        dconf
        # rust-bin.stable.latest.default
        # remote access / game stream
        iwd
        networkmanager
        networkmanager-vpnc
        networkmanagerapplet
        android-tools
        rustup
        dust
        sunshine
        moonlight-qt
        nvtopPackages.full
        gparted-full
        qpwgraph
        steam 
        steam-run
    ];

    # todo! qt theme

    # themes gtk using dconf
    dconf = {
            enable = true;
            settings = {
                        # to get this value do : dconf dump /
                        "org/gnome/desktop/interface" = {
                                color-scheme = "prefer-dark";
                                theme = "Kripton-standard-buttons-v40";
                                icon-theme="Pop";
                                # cursor-size=24 # --> handle directly by hypr config
                                # cursor-theme="Adwaita";
                                font-antialiasing="grayscale";
                                font-hinting="slight";
                                font-name="Sans 11";
                                font-rgba-order="rgb";
                                gtk-theme="Kripton-standard-buttons-v40";
                                text-scaling-factor=1.0;
                                toolbar-icons-size="small";
                                toolbar-style="both-horiz";
                        };
            };
    };

    services = {
            polkit-gnome = {
                    enable = true;
                    package = pkgs.polkit_gnome;
            };
    };

    xdg.portal = {
            enable = true;
            config = {
                    common = {
                        default = [
                                "hyprland"
                                "gtk"
                        ];
                        "org.freedesktop.impl.portal.FileChooser" = "thunar";
                    };
            };
            extraPortals = with pkgs; [
                xdg-desktop-portal-hyprland
                xdg-desktop-portal-gnome
                xdg-desktop-portal-gtk
                xdg-desktop-portal
            ];
    };

    # systemd.user.services.<name>
    systemd.user.services.polkit-gnome-authentication-agent-1 = {
      Unit = {
              Description = "polkit-gnome-authentication-agent-1";
              Wants = [ "graphical-session.target" ];
              After = [ "graphical-session.target" ];
      };
      Install = {
              WantedBy = [ "graphical-session.target" ];
      };
      Service = {
              Type = "simple";
              ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
              Restart = "on-failure";
              RestartSec = 1;
              TimeoutStopSec = 10;
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
