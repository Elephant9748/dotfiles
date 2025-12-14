{ pkgs, vars, ... }: {
    home.packages = with pkgs; [ htop ];

    home.file.".config/nvim" = {
        source = ../../../configs/.config/nvim;
        recursive = true;
    };

    home.file.".config/fish" = {
        source = ../../../configs/.config/fish;
        recursive = true;
    };

    home.file.".config/hypr" = {
        source = ../../../configs/.config/hypr;
        recursive = true;
    };

    home.stateVersion = "${vars.version}"";
}

