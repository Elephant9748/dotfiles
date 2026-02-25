# { vars, inputs, nixpkgs, home-manager, hypr, rust-overlay, ... }:
{ vars, inputs, nixpkgs, home-manager, ... }:
let
    system = "${vars.system}";

    pkgs = import nixpkgs {
        inherit system;
	    config.allowUnfree = true;
        # overlays = [ (import rust-overlay) ];
    };

    lib = nixpkgs.lib;
in
{
    # tracy (LVM on LUKS)
    ${vars.user} = lib.nixosSystem {
	    specialArgs = {
                # inherit inputs system pkgs vars hypr;
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
                    ../modules/home_base.nix
                ];
	        }
	    ];
    };

}

