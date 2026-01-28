# Structur modules
# -----------------------------------------------
# nix
# ├── flake.nix
# └─── hosts
#     ├── gui.nix <--- the same as /etc/nixos/configuration.nix
#     ├── nogui.nix <--- the same as /etc/nixos/configuration.nix
#     └── tracy
#         ├── default.nix
#         ├── hardware-configuration.nix
#         └── modules
#             ├── base.nix
#             ├── full.nix
#             ├── home.nix
#             └── home_nogui.nix
# -----------------------------------------------
{ vars, inputs, nixpkgs-unstable, home-manager, hypr, rust-overlay, neovim-nightly, ... }:
let
    system = "${vars.system}";

    pkgs-overlays = import nixpkgs-unstable {
        inherit system;
	    config.allowUnfree = true;
        overlays = [ 
                (import rust-overlay) 
                (import neovim-nightly) 
        ];
    };

    lib = nixpkgs-unstable.lib;
in
{
    # tracy (LVM on LUKS)
    ${vars.user} = lib.nixosSystem {
	    specialArgs = {
                inherit inputs system pkgs-overlays vars hypr neovim-nightly;
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
                    ./${vars.user}/modules/home.nix
                ];
	        }
	    ];
    };

}

