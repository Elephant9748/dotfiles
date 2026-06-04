{ pkgs, neovim-nightly, hypr, user, system, ... }:
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

  # opengl vm
  # setting on vm manager GUI on host machine
  # <graphics type="spice">
  #    <listen type="none"/>
  #    <image compression="off"/>
  #    <gl enable="yes" rendernode="/dev/dri/by-path/pci-0000:00:02.0-render"/> # this just pick either betweeb 2 gpu
  # </graphics>
  # <video>
  #       <model type="virtio" heads="1" primary="yes">
  #         <acceleration accel3d="yes"/>
  #       </model>
  #       <alias name="video0"/>
  #       <address type="pci" domain="0x0000" bus="0x00" slot="0x01" function="0x0"/>
  # </video>
  hardware.opengl.enable = true;

  environment = {
        pathsToLink = [ "/share/applications" "/share/xdg-desktop-portal" ];
        # variables.GSETTINGS_SCHEMA_DIR = "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}/glib-2.0/schemas";
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
                          AllowUsers = [ "${user}" ];
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
	    loginShellInit = ''
            if test (tty) = "/dev/tty1"; and test -z "$WAYLAND_DISPLAY"; and test -n "$XDG_VTNR"; and test "$XDG_VTNR" -eq 1
                    exec start-hyprland
                    # mangowm
                    # set -gx WLR_NO_HARDWARE_CURSORS 1 # for vm pointer mouse upside down
                    # exec mango
            end
        '';
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
            package = neovim-nightly.packages.${system}.default;
    };
    gnome-disks.enable = true;
    # mangowm
    # mango.enable = true;
  };

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
    glaze
  ];
}
