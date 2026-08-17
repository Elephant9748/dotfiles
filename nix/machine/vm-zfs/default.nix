{
  inputs,
  pkgs,
  lib,
  info,
  config,
  ...
}: let
  zfsCompatibleKernelPackages =
    lib.filterAttrs (
      name: kernelPackages:
        (builtins.match "linux_[0-9]+_[0-9]+" name)
        != null
        && (builtins.tryEval kernelPackages).success
        && (!kernelPackages.${config.boot.zfs.package.kernelModuleAttribute}.meta.broken)
    )
    pkgs.linuxKernel.packages;
  latestKernelPackage = lib.last (
    lib.sort (a: b: (lib.versionOlder a.kernel.version b.kernel.version)) (
      builtins.attrValues zfsCompatibleKernelPackages
    )
  );
in {
  imports = [
    ./hardware-configuration.nix
    ../../modules/nix
    ../../users
  ];

  # Use latest kernel.
  boot.kernelPackages = latestKernelPackage;

  networking.hostName = "${lib.elemAt info.hostname 0}";
  networking.hostId = "8425e349";

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
    users.${lib.elemAt info.users 0} = {
      isNormalUser = true;
      createHome = true;
      group = "${lib.elemAt info.users 0}";
      extraGroups = [
        "sudo"
        "${lib.elemAt info.users 0}"
        "wheel"
        "networkmanager"
      ];
      shell = pkgs.fish;
      useDefaultShell = true;
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFCMCsfI7ZZjtHp63JxrFWMfsQHwDUVAb7TbsO3ChOzc walter.vm"
      ];
    };
    groups = {
      sudo = {
        gid = 1000;
      };
      ${lib.elemAt info.users 0} = {
        gid = 1001;
      };
    };
  };
  networking.firewall.enable = false;
  system.stateVersion = "${info.version}";
}
