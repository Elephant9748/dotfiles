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

{
  description = "Nixos Flake";

  inputs = {
	nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";	

	home-manager = {                                                  
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = inputs @ { self, home-manager, nixpkgs-unstable, hyprland }: 
    let
        vars = { 
                # changed this if using another profile
                # this where host/user --flake
                user = "tracy";
                host = "tracy-vm";
                system = "x86_64-linux";
                version = "121425_1212";
                editor = "nvim";
        };
    in
    {
      nixosConfigurations = (
        import ./hosts {
            inherit (nixpkgs-unstable) lib;
            inherit inputs nixpkgs-unstable home-manager vars;
        }
      );
    };
}

