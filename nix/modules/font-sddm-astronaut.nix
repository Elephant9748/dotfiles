{
  inputs,
  pkgs,
  ...
}: let
  sddm-astronaut-font = pkgs.stdenvNoCC.mkDerivation {
    pname = "sddm-astronaut-font";
    version = "1.1";
    src = inputs.font-sddm-manual;
    installPhase = ''
      mkdir -p $out/share/fonts/truetype
      # Copy all ttf/otf files from the src directory
      cp $src/* $out/share/fonts/truetype/ 2>/dev/null || true
    '';
  };
in {
  fonts.packages = [sddm-astronaut-font];
  fonts.fontDir.enable = true;
}
