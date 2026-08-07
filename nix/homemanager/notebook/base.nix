{
  pkgs,
  info,
  ...
}: {
  home.packages = with pkgs; [
    fastfetch
    nerd-fonts.jetbrains-mono
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts
    public-sans
    tmux
  ];

  home.stateVersion = "${info.version}";
}
