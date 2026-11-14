{
  pkgs,
  lib,
  ...
}: {
  home.packages = [
    (pkgs.termusic.overrideAttrs
    (newAttrs: oldAttrs: {
      pname = "termusic";
      src = pkgs.fetchFromGitHub {
        owner = "tramhao";
        repo = "termusic";
        rev = "f9c9cec1408b3b73fbef8d6ecb9414b308f29d3e";
        hash = "sha256-34FM6Vs7ND1W8PxAHCCsyG81iz4bcaKEwrfcSRwtcdg=";
      };

      cargoHash = "sha256-aFh6QmV3qwQU5xq144pUCRHoGnB8gk+kArV6DqukQqg=";
      buildPhase = ''
        cargo build --release --all
      '';
      checkPhase = ''
        echo ":: SKIP CARGO TEST"
      '';
      installPhase = ''
        mkdir -p $out/local/bin
        install -Dm755 target/release/termusic $out/bin/termusic
        install -Dm755 target/release/termusic-server $out/bin/termusic-server
      '';

    }))
  ];
}

