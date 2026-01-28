{ pkgs-overlays, hypr, vars, ... }:
{
  security = { 
          sudo = {
              enable = true;
              extraRules = [{
                  groups = [ "sudo" ];
                  host = "ALL";
                  runAs = "ALL:ALL";
                  commands = [
                    {
                        command = "ALL";
                    }
                  ];
              }];
          };
          polkit = {
                  enable = true;
          };
  };

  services = {
          pipewire = {
                  enable = true;
                  pulse.enable = true;
          };
          openssh = {
                  enable = true;
                  ports = [ 22 ];
                  settings = {
                          PermitRootLogin = "no";
                          PasswordAuthentication = false;
                          KbdInteractiveAuthentication = false;
                          AllowUsers = [ "${vars.user}" ];
                  };
          };
          xserver.enable = false;
          udisks2 = {
                  enable = true;
                  package = pkgs-overlays.udisks;
          };
  };

  programs = {
	fish = {
		enable = true;
        loginShellInit = ''
                if test (tty) = "/dev/tty1"; and test -z "$WAYLAND_DISPLAY"; and test -n "$XDG_VTNR"; and test "$XDG_VTNR" -eq 1
                    exec start-hyprland
                  end
        '';
	};
	ssh = {
		package = pkgs-overlays.openssh;
		kexAlgorithms = ["mlkem768x25519-sha256"];
	};
	gnupg = {
		agent = {
			enable = true;
			enableSSHSupport = true;
		};
	};
    hyprland = {
            enable = true;
            package = hypr.packages.${vars.system}.hyprland;
            portalPackage = hypr.packages.${vars.system}.xdg-desktop-portal-hyprland;
    };
    gnome-disks.enable = true;
  };

  environment.systemPackages = with pkgs-overlays; [
    home-manager
    gnupg
    git
    procps
    pciutils
    lsb-release
    vim
    neovim
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
    cryptomator
    polkit_gnome
  ];
}
