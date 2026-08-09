{
  description = "Gnupg PQC";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
        gnupg = pkgs.callPackage ./default.nix {};
      in {
        packages.default = gnupg;
        devShells.default = pkgs.mkShell {
          buildInputs = [gnupg];
        };
        apps.default = flake-utils.lib.mkApp {
          drv = gnupg;
        };
      }
    );
}
