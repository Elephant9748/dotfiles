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
    hypr = {
      url = "github:hyprwm/Hyprland";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    # overlays
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    neovim-nightly = {                                                                                                                                         │ 19   outputs = inputs @ { self, home-manager, nixpkgs-unstable, hypr, rust-overlay, ... }:
        url = "github:nix-community/neovim-nightly-overlay";                                                                                                   │ 20     let
        inputs.nixpkgs.follows = "nixpkgs-unstable";                                                                                                           │ 21         vars = {
    };
  };

  outputs = inputs @ {
          self, 
          home-manager, 
          nixpkgs-unstable, 
          hypr, 
          # neovim-nightly,
          rust-overlay, ... 
  }:
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
      # define modules with gui or just terminal
      import ./hosts/nogui.nix {
          inherit (nixpkgs-unstable);
          # inherit nixpkgs-unstable inputs home-manager vars hypr rust-overlay neovim-nightly;
          inherit nixpkgs-unstable inputs home-manager vars hypr rust-overlay;
      }
    );
  };
}

