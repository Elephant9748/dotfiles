{ pkgs-overlays, vars, ... }: {
    home.packages = with pkgs-overlays; [
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
        rust-bin.stable.latest.default
    ];

    home.stateVersion = "${vars.version}";

    home.file.".config/nvim" = {
        source = ../../../../configs/.config/nvim;
        recursive = true;
    };

    # fish
    # ----
    # manual copy need constant w access
    # ----


    home.file.".config/alacritty" = {
        source = ../../../../configs/.config/alacritty;
        recursive = true;
    };
    home.file.".config/bat" = {
        source = ../../../../configs/.config/bat;
        recursive = true;
    };
    home.file.".config/bottom" = {
        source = ../../../../configs/.config/bottom;
        recursive = true;
    };
    home.file.".config/dunst/dunstrc" = {
        source = ../../../../configs/.config/dunst/dunstrc;
        recursive = true;
    };

    # gtk-*
    # ------
    # manual copy need w access
    # required by nwg-look

    home.file.".config/hypr" = {
        source = ../../../../configs/.config/hypr;
        recursive = true;
    };

    home.file.".config/rofi" = {
        source = ../../../../configs/.config/rofi;
        recursive = true;
    };
    home.file.".config/swappy" = {
        source = ../../../../configs/.config/swappy;
        recursive = true;
    };
    home.file.".config/sway" = {
        source = ../../../../configs/.config/sway;
        recursive = true;
    };
    home.file.".config/waybar" = {
        source = ../../../../configs/.config/waybar;
        recursive = true;
    };
    home.file.".config/yazi" = {
        source = ../../../../configs/.config/yazi;
        recursive = true;
    };

    home.file.".local/share/icons" = {
        source = ../../../../configs/icons;
        recursive = true;
    };
    home.file.".tmux.conf" = {
        source = ../../../../configs/tmux/.tmux.conf;
        recursive = true;
    };
}
