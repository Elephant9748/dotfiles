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
{
  description = "Nixos Flake";

  nixConfig = {
    extra-substituters = [ "https://cache.numtide.com" ];
    extra-trusted-public-keys = [
      "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
    ];
  };

  inputs = {
	# nixpkgs = {
	#        url = "github:nixos/nixpkgs/nixos-unstable";	
	#        flake = false;
	#    };
    
	nixpkgs = {
	       url = "github:NixOS/nixpkgs/nixos-25.11";	
	       flake = false;
	   };

	home-manager = {                                                  
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
    };
	# home-manager = {                                                  
	#        url = "github:nix-community/home-manager";
	#        inputs.nixpkgs.follows = "nixpkgs";
	#    };
    # hypr = {
    #   url = "github:hyprwm/Hyprland";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    # overlays
    # rust-overlay = {
    #   url = "github:oxalica/rust-overlay";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
    # neovim-nightly = {                                                                                                                                     
    #     url = "github:nix-community/neovim-nightly-overlay";                                                                                               
    #     inputs.nixpkgs.follows = "nixpkgs";                                                                                                       
    # };
  };

  outputs = inputs @ {
          self, 
          home-manager, 
          # nixpkgs-unstable, 
          nixpkgs,
          # hypr, 
          # neovim-nightly,
          # rust-overlay, 
          ...
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
          # inherit (nixpkgs);
          # inherit nixpkgs inputs home-manager vars hypr rust-overlay neovim-nightly;
          inherit (nixpkgs);
          inherit nixpkgs inputs home-manager vars;
      }
    );
  };
}

