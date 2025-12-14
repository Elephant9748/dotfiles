# Structur modules
# -----------------------------------------------
# nix
# ├── flake.nix
# └── hosts
#     ├── default.nix
#     └── tracy-vm
#         ├── default.nix <--- the same as /etc/nixos/configuration.nix
#         ├── hardware-configuration.nix
#         └── home.nix
# -----------------------------------------------
{ lib, vars, inputs, nixpkgs-unstable, home-manager, hyprland,  ... }:
let
    system = "${vars.system}";

    unstable = import nixpkgs-unstable {
        inherit system;
	    config.allowUnfree = true;
    };

    lib = nixpkgs-unstable.lib;
in
{
    # tracy (LVM on LUKS)
    tracy = lib.nixosSystem {
	    specialArgs = {
                inherit inputs system unstable vars;
	        host = {
	            hostname = "${vars.host}";
	        };
	    };
	    modules = [
	        ./${vars.user}

	        home-manager.nixosModules.home-manager {
                home-manager.useGlobalPkgs = true;
	    	    home-manager.useUserPackages = true;
	    	    home-manager.users.${vars.user}.imports = [
                    ./${vars.user}/home.nix
                ];
	        }
	    ];
    };

}

