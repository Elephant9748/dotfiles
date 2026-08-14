{
  inputs,
  outputs,
  lib,
  pkgs,
  info,
  ...
}: let
  oneuser =
    if info.host == "vm"
    then lib.elemAt info.users 0
    else if info.host == "notebook"
    then lib.elemAt info.users 1
    else if info.host == "pc"
    then lib.elemAt info.users 2
    else lib.elemAt info.users 0;
in {
  imports = [
    ./${info.host}
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit inputs outputs info;
    };
  };

  home-manager.users.${oneuser}.imports = [
    ../homemanager/${info.host}
  ];
}
