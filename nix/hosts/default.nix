# Structur modules
# -----------------------------------------------
# nix
# ├── flake.nix
# └── hosts
#     ├── default.nix
#     └── tracy
#         ├── default.nix <--- the same as /etc/nixos/configuration.nix
#         ├── hardware-configuration.nix
#         └── home.nix
# -----------------------------------------------
{ vars, inputs, nixpkgs-unstable, home-manager, rust-overlay, ... }:
let
    system = "${vars.system}";

    pkgs-overlays = import nixpkgs-unstable {
        inherit system;
	    config.allowUnfree = true;
        overlays = [ (import rust-overlay) ];
    };

    lib = nixpkgs-unstable.lib;
in
{
    # tracy (LVM on LUKS)
    tracy = lib.nixosSystem {
	    specialArgs = {
                inherit inputs system pkgs-overlays vars;
                host = {
                        hostname = "${vars.host}";
                };
	    };
	    modules = [
	        ./${vars.user}

	        home-manager.nixosModules.home-manager {
                home-manager.useGlobalPkgs = true;
	    	    home-manager.useUserPackages = true;
                home-manager.extraSpecialArgs = { 
                        inherit vars pkgs-overlays; 
                };
	    	    home-manager.users.${vars.user}.imports = [
                    ./${vars.user}/home.nix
                ];
	        }
	    ];
    };

}

