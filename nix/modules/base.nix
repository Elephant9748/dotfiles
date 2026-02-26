{ pkgs, user, version, host, ... }:
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
  };

  services = {
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
  };

  programs = {
	fish = {
		enable = true;
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
  };

  environment.systemPackages = with pkgs; [
    home-manager
    gnupg
    git
    procps
    pciutils
    lsb-release
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
    just
  ];
}

