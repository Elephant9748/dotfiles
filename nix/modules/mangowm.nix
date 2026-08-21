{pkgs, lib, info, ...}: 
{
  home.file = lib.mkMerge [
        (lib.mkIf (info.host == "vm") {
                ".config/mango/autostart.sh" = {
                        source = ../../configs/.config/mango/nix/vm/autostart-nix.sh;
                        recursive = true;
                };
                ".config/mango/config.conf" = {
                        source = ../../configs/.config/mango/nix/vm/config-nix.conf;
                        recursive = true;
                };
        })
        (lib.mkIf (info.host == "vm-btrfs") {
                ".config/mango/autostart.sh" = {
                        source = ../../configs/.config/mango/nix/vm/autostart-nix.sh;
                        recursive = true;
                };
                ".config/mango/config.conf" = {
                        source = ../../configs/.config/mango/nix/vm/config-nix.conf;
                        recursive = true;
                };
        })
        (lib.mkIf (info.host == "vm-zfs") {
                ".config/mango/autostart.sh" = {
                        source = ../../configs/.config/mango/nix/vm/autostart-nix.sh;
                        recursive = true;
                };
                ".config/mango/config.conf" = {
                        source = ../../configs/.config/mango/nix/vm/config-nix.conf;
                        recursive = true;
                };
        })
        (lib.mkIf (info.host == "netbook") {
                ".config/mango/autostart.sh" = {
                        source = ../../configs/.config/mango/nix/netbook/autostart-nix.sh;
                        recursive = true;
                };
                ".config/mango/config.conf" = {
                        source = ../../configs/.config/mango/nix/netbook/config-nix.conf;
                        recursive = true;
                };
        })
        (lib.mkIf (info.host == "pc") {
                ".config/mango/autostart.sh" = {
                        source = ../../configs/.config/mango/nix/pc/autostart-nix.sh;
                        recursive = true;
                };
                ".config/mango/config.conf" = {
                        source = ../../configs/.config/mango/nix/pc/config-nix.conf;
                        recursive = true;
                };
        })
  ];

  home.packages = with pkgs; [
    swaybg
    wlr-randr
  ];
}
