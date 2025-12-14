{ pkgs, vars, ... }: {
    home.packages = with pkgs; [ htop ];

    home.stateVersion = "${vars.version}";

    home.file.".config/nvim" = {
        source = ../../../configs/.config/nvim;
        recursive = true;
    };

    # fish
    home.file.".config/fish/config.fish" = {
        source = ../../../configs/.config/fish/config.fish;
        recursive = true;
    };
    home.file.".config/fish/completions" = {
        source = ../../../configs/.config/fish/completions;
        recursive = true;
    };
    home.file.".config/fish/conf.d" = {
        source = ../../../configs/.config/fish/conf.d;
        recursive = true;
    };
    home.file.".config/fish/functions" = {
        source = ../../../configs/.config/fish/functions;
        recursive = true;
    };

}

