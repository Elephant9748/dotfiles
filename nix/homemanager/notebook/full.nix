{
  pkgs,
  version,
  lb,
  system,
  hypr,
  ...
}: {
  imports = [
    ../../modules/waybar.nix
    ../../modules/gtk.nix
    ../../modules/qt.nix
    ../../modules/hyprland.nix
    ../../modules/hyprpaper.nix
    ../../modules/mangowm.nix
  ];

  home.packages = with pkgs; [
    fastfetch
    waybar
    alacritty
    nerd-fonts.jetbrains-mono
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts
    public-sans
    tmux
    rofi
    wl-clipboard
    imagemagick
    pavucontrol
    pulseaudio
    nwg-look
    rofi-power-menu
    rofi-calc
    cryptomator
    libreoffice-fresh
    obs-studio
    qutebrowser
    wmctrl
    termusic
    audacity
    signal-desktop
    mpv
    grim
    slurp
    localsend
    # gsettings-desktop-schemas
    # glib
    dconf
    # rust-bin.stable.latest.default
    rustup
    iwd
    networkmanager
    networkmanager-vpnc
    networkmanagerapplet
    android-tools
    dust
    # bluetooth
    bluez
    bluez-tools
    bluetui
    gparted-full
    qpwgraph
    vulkan-tools
    glmark2
    mesa-demos
    sunshine
    moonlight-qt
    appimage-run
    # paperpass.packages.${pkgs.system}.default
  ];

  # todo! qt theme

  # themes gtk using dconf
  dconf = {
    enable = true;
    settings = {
      # to get this value do : dconf dump /
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
        theme = "Kripton-standard-buttons-v40";
        icon-theme = "Pop";
        # cursor-size=24 # --> handle directly by hypr config
        # cursor-theme="Adwaita";
        font-antialiasing = "grayscale";
        font-hinting = "slight";
        font-name = "Cantarell 10";
        font-rgba-order = "rgb";
        gtk-theme = "Kripton-standard-buttons-v40";
        text-scaling-factor = 0.86;
        toolbar-icons-size = "small";
        toolbar-style = "both-horiz";
      };
    };
  };

  xdg.portal = {
    enable = true;
    config = {
      common = {
        default = [
          "hyprland"
          "gtk"
        ];
        "org.freedesktop.impl.portal.FileChooser" = "thunar";
      };
    };
    extraPortals = with pkgs; [
      # hypr.packages.${system}.xdg-desktop-portal-hyprland
      xdg-desktop-portal-hyprland
      xdg-desktop-portal-gnome
      xdg-desktop-portal-gtk
      xdg-desktop-portal
    ];
  };

  services = {
    polkit-gnome = {
      enable = true;
      package = pkgs.polkit_gnome;
    };
  };

  # systemd.user.services.<name>
  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    Unit = {
      Description = "polkit-gnome-authentication-agent-1";
      Wants = ["graphical-session.target"];
      After = ["graphical-session.target"];
    };
    Install = {
      WantedBy = ["graphical-session.target"];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  home.stateVersion = "${info.version}";
}
