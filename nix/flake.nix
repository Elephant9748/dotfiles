{
  description = "Nixos Flake";

  nixConfig = {
    extra-substituters = [ "https://cache.numtide.com" ];
    extra-trusted-public-keys = [
      "niks3.numtide.com-1:DTx8wZduET09hRmMtKdQDxNNthLQETkc/yaX7M4qK0g="
    ];
  };

  inputs = {

    # STABLE
    # --------------------------------------------------------------
	nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";	

	home-manager = {                                                  
        url = "github:nix-community/home-manager/release-25.11";
        inputs.nixpkgs.follows = "nixpkgs";
    };
    # --------------------------------------------------------------

    # UNSTABLE
    # --------------------------------------------------------------
	nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";	

	home-manager = {                                                  
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
    };
    # --------------------------------------------------------------

    
    # Overlays / Another source
    # --------------------------------------------------------------
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
    # --------------------------------------------------------------
  };

  outputs = {
          self, 
          nixpkgs,
          home-manager, 
          # nixpkgs-unstable, 
          # hypr, 
          # neovim-nightly,
          # rust-overlay, 
          ...
  } @inputs:
  let
      mkMachine = { user, host, system, version, editor, ... }:
        nixpkgs.lib.nixosSystem {
                inherit system;
                specialArgs = { 
                        inherit user version host system;
                };
                modules = [
                        ./hosts/${user}
                        #base = mininmal, full = with gui desktop
                        (import ./modules/base.nix)
                        home-manager.nixosModules.home-manager {
                                home-manager.useGlobalPkgs = true;
                                home-manager.useUserPackages = true;
                                home-manager.extraSpecialArgs = { 
                                        inherit version user; 
                                };
                                home-manager.users.${user}.imports = [
                                        ./modules/home_base.nix
                                ];
                        }
                ];
        };
          machine = {
                  tracy = {
                          user = "tracy";
                          host = "pineapple-vm";
                          system = "x86_64-linux";
                          version = "25.11";
                          editor = "nvim";
                  };
                  rigel = {
                          user = "rigel";
                          host = "starfish-small";
                          system = "x86_64-linux";
                          version = "25.11";
                          editor = "nvim";
                  };
          };

  in
  {
          nixosConfigurations = nixpkgs.lib.mapAttrs (name: config: mkMachine config) machine;
  };
}
