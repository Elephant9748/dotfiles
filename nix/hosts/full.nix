# Structur modules
# -----------------------------------------------
# nix
# ├── flake.nix
# └── hosts
#     ├── base.nix
#     ├── full.nix
#     ├── rigel
#     │   ├── default.nix
#     │   ├── hardware-configuration.nix
#     │   └── modules
#     │       ├── base.nix <--- the same as /etc/nixos/configuration.nix
#     │       ├── full.nix <--- the same as /etc/nixos/configuration.nix
#     │       ├── home_base.nix
#     │       └── home_full.nix
#     └── tracy
#         ├── default.nix
#         ├── hardware-configuration.nix
#         └── modules
#             ├── base.nix <--- the same as /etc/nixos/configuration.nix
#             ├── full.nix <--- the same as /etc/nixos/configuration.nix
#             ├── home_base.nix
#             └── home_full.nix
# -----------------------------------------------
# { vars, inputs, nixpkgs, home-manager, hypr, rust-overlay, neovim-nightly, ... }:
{ vars, inputs, nixpkgs, home-manager, ... }:
let
    system = "${vars.system}";

    pkgs = import nixpkgs {
        inherit system;
	    config.allowUnfree = true;
        # overlays = [ 
        #         (import rust-overlay) 
        #         (import neovim-nightly) 
        # ];
    };

    lib = nixpkgs.lib;
in
{
    # tracy (LVM on LUKS)
    ${vars.user} = lib.nixosSystem {
	    specialArgs = {
                # inherit inputs system pkgs vars hypr neovim-nightly;
                inherit inputs system pkgs vars;
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
                        inherit vars pkgs; 
                };
	    	    home-manager.users.${vars.user}.imports = [
                    ./${vars.user}/modules/home_full.nix
                ];
	        }
	    ];
    };

}

