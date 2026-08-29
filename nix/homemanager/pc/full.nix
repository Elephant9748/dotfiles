{
  pkgs,
  info,
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
    alacritty
    nerd-fonts.jetbrains-mono
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    noto-fonts
    cantarell-fonts
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
    libreoffice
    obs-studio
    qutebrowser
    firefox-devedition
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
    # remote access / game stream
    iwd
    networkmanager
    networkmanager-vpnc
    networkmanagerapplet
    android-tools
    dust
    sunshine
    # moonlight-qt
    # moonshine
    nvtopPackages.full
    gparted-full
    qpwgraph
    # steam
    steam-run
    vulkan-tools
    glmark2
    mesa-demos
    appimage-run
    # paperpass.packages.${pkgs.system}.default
    image-roll
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

  # programs = {
  #   gpg = {
  #     enable = true;
  #     package = pkgs.callPackage ../../pkgs/gnupg/24.nix {};
  #   };
  # };

  services = {
    # gpg-agent = {
    #   enable = true;
    #   enableSshSupport = true;
    # };
    polkit-gnome = {
      enable = true;
      package = pkgs.polkit_gnome;
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
