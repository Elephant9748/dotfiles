{ inputs, pkgs, vars,... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
    ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "${vars.host}"; 

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Jakarta";


  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
    useXkbConfig = false; # use xkb.options in tty.
  };

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
	users.root = {
		shell = pkgs.fish;
		useDefaultShell = true;
	};
  	users.${vars.user} = {
		isNormalUser = true;
		createHome = true;
		group = "${vars.user}";
		extraGroups = [
			"sudo"
			"tracy"
		];
		packages = with pkgs; [
		   tree
		];
		shell = pkgs.fish;
		useDefaultShell = true;
	};
	groups = {
		sudo = {
			gid = 1000;
		};
		${vars.user} = {
			gid = 1001;
		};
	};
  };

  security.sudo = {
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
    vim
    neovim
    ripgrep
    fd
    bottom
    bat
    openssh
    eza
    make
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
    fish
  ];

  # Enable the OpenSSH daemon.
  services = {
  	openssh.enable = true;
	xserver.enable = false;
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "${vars.version}"; # Did you read the comment?

}


