{ pkgs, version, lib,  ... }: {

    home.file.".config/mango/autostart-nix.sh" = {
        source = ../../../configs/.config/mango/autostart-nix.sh;
        recursive = true;
    };
    home.file.".config/mango/config.conf" = {
        source = ../../../configs/.config/mango/config-nix.conf;
        recursive = true;
    };
    home.packages = with pkgs; [
        swaybg
        wlr-randr
    ];
}
