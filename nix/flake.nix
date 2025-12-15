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

{
  description = "Nixos Flake";

  inputs = {
	nixpkgs-unstable = {
        url = "github:nixos/nixpkgs/nixos-unstable";	
    };

	home-manager = {                                                  
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    hypr = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs = inputs @ { self, home-manager, nixpkgs-unstable, hypr, rust-overlay, ... }:
    let
        vars = { 
                # changed this if using another profile
                # this where host/user --flake
                user = "tracy";
                host = "tracy-vm";
                system = "x86_64-linux";
                version = "26.05";
                editor = "nvim";
        };
    in
    {
      nixosConfigurations = (
        import ./hosts {
            inherit (nixpkgs-unstable);
            inherit nixpkgs-unstable inputs home-manager vars hypr rust-overlay;
        }
      );
    };
}

