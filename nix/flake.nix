{
  description = "Nixos Earendel";

  inputs = {
    # STABLE
    # --------------------------------------------------------------
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    #
    # home-manager = {
    #        url = "github:nix-community/home-manager/release-25.11";
    #        inputs.nixpkgs.follows = "nixpkgs"; }; --------------------------------------------------------------

    # UNSTABLE
    # --------------------------------------------------------------
    # nixpkgs.url = "https://channels.nixos.org/nixpkgs-unstable/nixexprs.tar.zst";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # --------------------------------------------------------------

    # Overlays / Another source
    # --------------------------------------------------------------
    # hypr = {
    #   # url = "github:hyprwm/Hyprland?submodule=1";
    #   url = "github:hyprwm/Hyprland?rev=64962f89e48a1b50214dd3eeb001aa1cc010ff25&submodule=1";
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

    # populate index database manual inside dotfiles/bins/nix/nix-index-manual
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # --------------------------------------------------------------

    # rpi
    nixos-hardware = {
      url = "github:NixOS/nixos-hardware/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    ...
  }: let
    inherit (self) outputs;

    # for packages not flake configurations
    systems = [
      "aarch64-linux"
      "x86_64-linux"
    ];
    var = {
      version = "26.11";
      editor = "nvim";
      hostname = ["citrullus-lanatus" "starfish-small" "rigel-pc" "earendel"];
      users = ["rigel" "kelly" "tracy" "brandon"];
    };

    forAllSystems = nixpkgs.lib.genAttrs systems;

    machine = host: modules: let
      info = var // {host = "${host}";};
    in
      nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs outputs info;
        };
        modules =
          [
            ./machine/${host}
          ]
          ++ modules;
      };
  in {
    # Your custom packages
    # Accessible through 'nix build', 'nix shell', etc
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    # nix fmt --pretty .
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    nixosConfigurations = {
      vm = machine "vm" [];
      netbook = machine "netbook" [];
      pc = machine "pc" [];
      vm-btrfs = machine "vm-btrfs" [
        # ./overlays
      ];
      vm-zfs = machine "vm-zfs" [];
      earendel-rpi = machine "earendel-rpi" [
        inputs.nixos-hardware.nixosModules.raspberry-pi-4
      ];
    };

    nixosMachines = forAllSystems (
      system: let
        # Filter the configurations to those that match the current system
        matchingSystemConfigurations = nixpkgs.lib.filterAttrs (_: c: c.pkgs.stdenv.hostPlatform.system == system) self.nixosConfigurations;

        # Map each matching configuration to its top-level system derivation
        toplevelDerivations = nixpkgs.lib.mapAttrs (_: c: c.config.system.build.toplevel) matchingSystemConfigurations;
      in
        toplevelDerivations
    );

    # Executed by `nix flake check`
    checks =
      forAllSystems (
        system:
          {
          }
          # Add all our homemanager configurations
          // (nixpkgs.lib.mapAttrs (_: c: c.activationPackage) (nixpkgs.lib.filterAttrs (_: c: c.pkgs.stdenv.hostPlatform.system == system) self.homeConfigurations))
      )
      // self.nixosMachines;
  };
}
