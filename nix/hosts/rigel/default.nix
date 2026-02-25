{ pkgs, hypr, vars,... }:

{
  imports =
    [ 
      ./hardware-configuration.nix
      ../../../modules/base.nix # <-- define with base or full
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
			"${vars.user}"
            "wheel"
            "networkmanager"
		];
		shell = pkgs.fish;
		useDefaultShell = true;
        # openssh.authorizedKeys.keys = [
        #         "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFCMCsfI7ZZjtHp63JxrFWMfsQHwDUVAb7TbsO3ChOzc walter.vm"
        # ];
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
  networking.firewall.enable = false;
  system.stateVersion = "${vars.version}"; 
}
