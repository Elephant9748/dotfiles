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
    neovim-nightly = {                                                                                                                                     
        url = "github:nix-community/neovim-nightly-overlay";                                                                                               
        inputs.nixpkgs.follows = "nixpkgs";                                                                                                       
    };

    # mangoWM
    mangowm = {
        url = "github:mangowm/mango/wl-only";
        inputs.nixpkgs.follows = "nixpkgs";
    };

    # waybar from source
    waybar-git = {
        url = "github:Alexays/Waybar";
        inputs.nixpkgs.follows = "nixpkgs";
    };

    # sddm backgrounds and font path
    sddm-backgrounds = {
            url = "path:../configs/sddm/sddm-astronaut-theme/Backgrounds/1.png";
            flake = false;
    };
    font-sddm-manual = {
            url = "path:../configs/sddm/sddm-astronaut-theme/Fonts";
            flake = false;
    };

    # paperpass = {
    #         url = "git+https://codeberg.org/rigel254/paperpass.git?ref=main";
    #         inputs.nixpkgs.follows = "nixpkgs";
    # };

    # --------------------------------------------------------------
  };

  outputs = {
          self, 
          nixpkgs,
          home-manager, 
          # hypr, 
          neovim-nightly,
          # rust-overlay, 
          mangowm,
          waybar-git,
          sddm-backgrounds,
          font-sddm-manual,
          # paperpass,
          ...
  } @inputs:
  let
      system = "x86_64-linux";
      version = "26.05";
      editor = "nvim";
      machine = {
              vm = {
                      user = "rigel";
                      host = "citrullus-lanatus";
                      label = "vm";
                      inherit system version editor;
              };
              notebook = {
                      user = "rigel";
                      host = "starfish-small";
                      label = "notebook";
                      inherit system version editor;
              };
              pc = {
                      user = "rigel";
                      host = "rigel-pc";
                      label = "pc";
                      inherit system version editor;
              };
      };
      mkMachine = { user, host, system, version, editor, label, ... }:
        nixpkgs.lib.nixosSystem {
                inherit system;
                specialArgs = { 
                        inherit user version host system neovim-nightly sddm-backgrounds font-sddm-manual;
                };
                modules = [
                        ./hosts/${label}
                        (import ./modules/${label})
                        # mangowm
                        # mangowm.nixosModules.mango
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
                                        inherit version user waybar-git; 
                                };
                                home-manager.users.${user}.imports = [
                                        ./homemanager/${label}
                                ];
                        }
                ];
        };

  in
  {
          nixosConfigurations = nixpkgs.lib.mapAttrs (name: config: mkMachine config) machine;
  };
}
