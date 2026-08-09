# Custom packages, that can be defined similarly to ones from nixpkgs
# You can build them using 'nix build .#example'
pkgs: {
  gnupg = pkgs.callPackage ./gnupg/24.nix {};
}
