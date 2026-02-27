
# nix-build -E 'with import <nixpkgs> {}; callPackage ./paperpass.nix {}'

# nixconfigurations
# { config, pkgs, ... }:
# {
#   environment.systemPackages = [
#     (pkgs.callPackage ./my-package.nix {})
#   ];
# }

{ stdenv, lib, fetchurl, gnutar }:

stdenv.mkDerivation rec {
  pname = "paperpass";
  version = "1.1.10";

  src = fetchurl {
    url = "https://codeberg.org/rigel254/paperpass/releases/download/${version}/${pname}-${version}-${stdenv.hostPlatform.system}-gnu.tar.gz";
    sha256 = "d8d8cb47c5831bb19ad1032aeb44195ccdb2b7f91f1d8584a59df90f51030389";
  };

  # dontBuild = true;

  buildInputs = [ gnutar ];

  unpackPhase = ''
        tar -zxvf $src
  '';

  installPhase = ''
        mkdir -p $out/bin
        cp -r ${pname}-${version}-${stdenv.hostPlatform.system}-gnu/* $out/bin
  '';

  meta = with lib; {
    description = "Paperpass terminal password manager simillar to pass or gopass";
    homepage = "http://codeberg.org/rigel254/paperpass.git";
    license = licenses.mit;
    platforms = platforms.unix;
  };
}
