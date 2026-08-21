{
  inputs,
  lib,
  pkgs,
  info,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/nix
    ../../users
  ];

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "${lib.elemAt info.hostname 1}";

  # Configure network connections interactively with nmcli or nmtui.
  networking.networkmanager.enable = true;

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
    users.${lib.elemAt info.users 1} = {
      isNormalUser = true;
      createHome = true;
      group = "${lib.elemAt info.users 1}";
      extraGroups = [
        "sudo"
        "${lib.elemAt info.users 1}"
        "wheel"
        "networkmanager"
      ];
      shell = pkgs.fish;
      useDefaultShell = true;
      openssh.authorizedKeys.keys = [
              "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB4NEx9uDMJfHm8kHVhkuAGeEn5zlUlfoq8jDZAO6pKr netbook.nix"
      ];
    };
    groups = {
      sudo = {
        gid = 1000;
      };
      ${lib.elemAt info.users 1} = {
        gid = 1001;
      };
    };
  };
  networking.firewall.enable = false;
  system.stateVersion = "${info.version}";
}
