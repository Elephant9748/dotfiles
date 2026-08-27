{
  pkgs,
  lib,
  ...
}: let
  apparmorProfiles = "${pkgs.apparmor-profiles}/share/apparmor/extra-profiles";
  files = lib.filterAttrs (x: y: y == "regular" && x != "README") (builtins.readDir apparmorProfiles);
in {
  security = {
    auditd.enable = true;
    apparmor = {
      enable = true;
      packages = with pkgs; [
        apparmor-profiles
        apparmor-parser
        apparmor-utils
      ];
      policies =
        (lib.mapAttrs (file_name: _: {
            state = "enforce";
            path = apparmorProfiles + "/${file_name}";
          })
          files)
        // {};
      includes = {
        "local/nixos" = ''
          /nix/store/** r,
          /nix/store/*/bin/** mr,
          /nix/store/*/lib/** mr,
        '';
      };
    };
  };
}
