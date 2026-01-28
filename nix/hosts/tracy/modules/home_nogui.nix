{ pkgs-overlays, vars, ... }: {
    home.packages = with pkgs-overlays; [
        fastfetch
        nerd-fonts.jetbrains-mono
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif
        noto-fonts
        public-sans
        tmux
    ];

    home.stateVersion = "${vars.version}";

    home.file.".config/nvim" = {
        source = ../../../configs/.config/nvim;
        recursive = true;
    };

    # fish
    # ----
    # manual copy need constant w access
    # ----


    home.file.".config/alacritty" = {
        source = ../../../configs/.config/alacritty;
        recursive = true;
    };
    home.file.".config/bat" = {
        source = ../../../configs/.config/bat;
        recursive = true;
    };
    home.file.".config/bottom" = {
        source = ../../../configs/.config/bottom;
        recursive = true;
    };

    home.file.".tmux.conf" = {
        source = ../../../configs/tmux/.tmux.conf;
        recursive = true;
    };
}

