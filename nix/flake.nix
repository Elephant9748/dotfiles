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
	# nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";	
	#
	# home-manager = {                                                  
	#        url = "github:nix-community/home-manager/release-25.11";
	#        inputs.nixpkgs.follows = "nixpkgs";
	#    };
    # --------------------------------------------------------------

    # UNSTABLE
    # --------------------------------------------------------------
	nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";	

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
      mkMachine = { user, host, system, version, editor, label, ... }:
        nixpkgs.lib.nixosSystem {
                inherit system;
                specialArgs = { 
                        inherit user version host system;
                };
                modules = [
                        ./hosts/${label}
                        #base = mininmal, full = with gui desktop
                        (import ./modules/${label}_base.nix)
                        # nix-ld
                        # (import ./modules/nix_ld.nix)
                        # overlays
                        # (import ./overlays/rust.nix)
                        # (import ./overlays/neovim.nix)
                        # Impl packaging
                        # ({ pkgs, ... }: {
                        #         environment.systemPackages = [(pkgs.callPackage ./packaging/paperpass.nix {})];
                        #  })
                        # home-manager
                        home-manager.nixosModules.home-manager {
                                home-manager.useGlobalPkgs = true;
                                home-manager.useUserPackages = true;
                                home-manager.extraSpecialArgs = { 
                                        inherit version user; 
                                };
                                home-manager.users.${user}.imports = [
                                        ./modules/home/${label}_base.nix
                                ];
                        }
                ];
        };
          machine = {
                  vm = {
                          user = "tracy";
                          host = "pineapple-vm";
                          system = "x86_64-linux";
                          version = "25.11";
                          editor = "nvim";
                          label = "vm";
                  };
                  notebook = {
                          user = "rigel";
                          host = "starfish-small";
                          system = "x86_64-linux";
                          version = "25.11";
                          editor = "nvim";
                          label = "notebook";
                  };
          };

  in
  {
          nixosConfigurations = nixpkgs.lib.mapAttrs (name: config: mkMachine config) machine;
  };
}
