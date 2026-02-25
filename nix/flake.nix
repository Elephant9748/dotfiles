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

  nixConfig = {
    extra-substituters = [ "https://cache.numtide.com" ];
    extra-trusted-public-keys = [
      "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
    ];
  };

  inputs = {
	nixpkgs-unstable = {
        url = "github:nixos/nixpkgs/nixos-unstable";	
        flake = false;
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
    neovim-nightly = {                                                                                                                                     
        url = "github:nix-community/neovim-nightly-overlay";                                                                                               
        inputs.nixpkgs.follows = "nixpkgs-unstable";                                                                                                       
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
      import ./hosts/base.nix {
          inherit (nixpkgs-unstable);
          # inherit nixpkgs-unstable inputs home-manager vars hypr rust-overlay neovim-nightly;
          inherit nixpkgs-unstable inputs home-manager vars hypr rust-overlay;
      }
    );
  };
}

