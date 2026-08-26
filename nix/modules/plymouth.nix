{pkgs, ...}: {
  boot = {
    plymouth = {
      enable = true;
      font = "${pkgs.nerd-fonts.jetbrains-mono}/share/fonts/truetype/NerdFonts/JetBrainsMono/JetBrainsMonoNerdFont-Thin.ttf";
      # themePackages = with pkgs; [
      #   (pkgs.adi1090x-plymouth-themes.override {
      #     selected_themes = [ "cuts_alt" ];
      #   })
      # ];
      # theme = "cuts_alt";
      logo = "${pkgs.nixos-icons}/share/icons/hicolor/128x128/apps/nix-snowflake.png";
    };
  };
}
