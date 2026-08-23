{
  inputs,
  outputs,
  lib,
  pkgs,
  info,
  ...
}: {
  imports = [
    ../../modules/ly.nix
    # ../../modules/sddm.nix
    # ../../modules/cosmic.nix
    inputs.nix-index-database.nixosModules.default
    inputs.mangowm.nixosModules.mango
  ];

  environment.systemPackages = with pkgs; [
    home-manager
    gnupg
    git
    procps
    pciutils
    lsb-release
    vim
    # neovim
    ripgrep
    fd
    jq
    bottom
    bat
    openssh
    eza
    gettext
    ninja
    meson
    curl
    gnumake
    gcc
    wget
    unzip
    zip
    fzf
    just
    # glaze
    # virtiofs mount
    guestfs-tools
    virtiofsd
    comma
  ];

  security = {
    sudo = {
      enable = true;
      extraRules = [
        {
          groups = ["sudo"];
          host = "ALL";
          runAs = "ALL:ALL";
          commands = [
            {
              command = "ALL";
            }
          ];
        }
      ];
    };
    polkit = {
      enable = true;
    };
  };

  environment = {
    pathsToLink = ["/share/applications" "/share/xdg-desktop-portal"];
    variables = {
      # WLR_NO_HARDWARE_CURSORS = "1";
      # GSETTINGS_SCHEMA_DIR = "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}/glib-2.0/schemas";
    };
  };

  services = {
    pipewire = {
      enable = true;
      pulse.enable = true;
    };
    openssh = {
      enable = true;
      ports = [22];
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        AllowUsers = ["${lib.elemAt info.users 0}"];
      };
    };
    xserver.enable = false;
    udisks2 = {
      enable = true;
      package = pkgs.udisks;
    };
  };

  programs = {
    fish = {
      enable = true;
      package = pkgs.fish;
      # loginShellInit = ''
      #        if test (tty) = "/dev/tty1"; and test -z "$WAYLAND_DISPLAY"; and test -n "$XDG_VTNR"; and test "$XDG_VTNR" -eq 1
      #                exec start-hyprland
      #                # mangowm
      #                # set -gx WLR_NO_HARDWARE_CURSORS 1 # for vm pointer mouse upside down
      #                # exec mango
      #        end
      #    '';
    };
    ssh = {
      package = pkgs.openssh;
      kexAlgorithms = ["mlkem768x25519-sha256"];
    };
    gnupg = {
      agent = {
        enable = true;
        enableSSHSupport = true;
      };
    };
    neovim = {
      enable = true;
      package = inputs.neovim-nightly.packages."${pkgs.stdenv.hostPlatform.system}".default;
    };
    gnome-disks.enable = true;
    thunar = {
      enable = true;
      plugins = with pkgs; [
        gvfs
        tumbler
        thunar-volman
        thunar-archive-plugin
      ];
    };
    # mangowm so we cant list wayland-session directory
    mango.enable = true;
    # mango = {
    #         enable = true;
    #         package = inputs.mangowm.packages.${pkgs.stdenv.hostPlatform.system}.mango;
    # };

    # hyprland so we cant list wayland-session directory
    hyprland.enable = true;
    # hyprland = {
    #         enable = true;
    #         # package = inputs.hypr.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    #         # portalPackage = inputs.hypr.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    # };
    nix-index-database.comma.enable = true;
    appimage = {
        enable = true;
        binfmt = true;
    };
  };
}
