{pkgs, ...}: let
  pack_theme = "spin";
in {
  boot = {
    plymouth = {
      enable = true;
      font = "${pkgs.nerd-fonts.jetbrains-mono}/share/fonts/truetype/NerdFonts/JetBrainsMono/JetBrainsMonoNLNerdFont-Medium.ttf";
      themePackages = with pkgs; [
        # (pkgs.adi1090x-plymouth-themes.override {
        #   selected_themes = [ "spin" ];
        # })
        (
          pkgs.adi1090x-plymouth-themes.overrideAttrs (oldAttrs: {
            installPhase = ''
              mkdir -p $out/share/plymouth/themes
              for theme in ${toString ["${pack_theme}"]}; do
                mv $theme $out/share/plymouth/themes/$theme
              done
              find $out/share/plymouth/themes/ -name \*.plymouth -exec sed -i "s@\/usr\/@$out\/@" {} \;

              runHook postInstall
            '';
            postInstall = ''
              cp ${pkgs.nixos-icons}/share/icons/hicolor/64x64/apps/nix-snowflake-white.png \
                      $out/share/plymouth/themes/${pack_theme}/logo.png
              cat >> $out/share/plymouth/themes/${pack_theme}/${pack_theme}.script << 'EOF'
                      logo_image = Image("logo.png");
                      logo_sprite = Sprite();

                      logo_sprite.SetImage(logo_image);
                      logo_sprite.SetX(Window.GetX() + (Window.GetWidth() / 2 - logo_image.GetWidth() / 2));
                      logo_sprite.SetY(Window.GetX() + (Window.GetHeight() / 2 - logo_image.GetHeight() / 2));
              EOF
            '';
          })
        )
      ];
      theme = "${pack_theme}";
      # logo = "${pkgs.nixos-icons}/share/icons/hicolor/128x128/apps/nix-snowflake-white.png";
    };
  };
}
