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
  hardware.opengl.enable = true;

  environment.pathsToLink = [ "/share/applications" "/share/xdg-desktop-portal" ];

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
