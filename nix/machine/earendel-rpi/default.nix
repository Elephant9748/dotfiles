{
  inputs,
  pkgs,
  lib,
  info,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/nix
    ../../users
  ];

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_rpi4;

  networking.hostName = "${lib.elemAt info.hostname 3}";
  networking.networkmanager.enable = true;
  networking.firewall.enable = false;
  # If a board becomes slow or unreachable over Wi-Fi, disable NetworkManager power saving and test again:
  # networking.networkmanager.wifi.powersave = false;

  # Set your time zone.
  time.timeZone = "Asia/Jakarta";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "ter-v16n";
    packages = with pkgs; [terminus_font];
    keyMap = "us";
    useXkbConfig = false; # use xkb.options in tty.
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    users.root = {
      shell = pkgs.fish;
      useDefaultShell = true;
    };
    users.${lib.elemAt info.users 3} = {
      isNormalUser = true;
      createHome = true;
      group = "${lib.elemAt info.users 3}";
      extraGroups = [
        "sudo"
        "${lib.elemAt info.users 3}"
        "wheel"
        "networkmanager"
      ];
      shell = pkgs.fish;
      useDefaultShell = true;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIEiAmmDigF8/qT06o2mQ1HVbJ9QCyxp/v7uRZxlBYMpb brandon.earendel"
      ];
    };
    groups = {
      sudo = {
        gid = 1000;
      };
      ${lib.elemAt info.users 3} = {
        gid = 1001;
      };
    };
  };
  system.stateVersion = "${info.version}";
}
