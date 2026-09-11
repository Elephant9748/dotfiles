{
  pkgs,
  inputs,
  lib,
  info,
  ...
}: let
  monitors = lib.attrsets.mergeAttrsList [
    (lib.optionalAttrs (info.host == "vm") {
      output = "Virtual-1";
      resolution = "1440x900@60";
      width = 1440;
      height = 900;
      hz = 60;
    })
    (lib.optionalAttrs (info.host == "vm-btrfs") {
      output = "Virtual-1";
      resolution = "1440x900@60";
      width = 1440;
      height = 900;
      hz = 60;
    })
    (lib.optionalAttrs (info.host == "vm-zfs") {
      output = "Virtual-1";
      resolution = "1440x900@60";
      width = 1440;
      height = 900;
      hz = 60;
    })
    (lib.optionalAttrs (info.host == "pc") {
      output = "HDMI-A-1";
      resolution = "1920x1080@60";
      width = 1920;
      height = 1080;
      hz = 60;
    })
    (lib.optionalAttrs (info.host == "netbook") {
      output = "LVDS-1";
      resolution = "1366x768@60";
      width = 1366;
      height = 768;
      hz = 60;
    })
  ];
in {
  imports = [
    inputs.mangowm.hmModules.mango
  ];
  home.packages = with pkgs; [
    swaybg
    wlr-randr
  ];
  home.file.".config/mango/autostart.sh" = {
    source =
      if info.host == "pc"
      then ../../configs/.config/mango/nix/pc/autostart-nix.sh
      else if info.host == "netbook"
      then ../../configs/.config/mango/nix/netbook/autostart-nix.sh
      else ../../configs/.config/mango/nix/vm/autostart-nix.sh;
    recursive = true;
  };
  wayland.windowManager = {
    mango = {
      enable = true;
      # +-------------------------------+
      # for some reason waybar run twice
      # manual use home.file
      # +-------------------------------+
      # autostart_sh = ''
      #   # enable tearing
      #   # export WLR_DRM_NO_ATOMIC=1
      #
      #   user=$(whoami)
      #
      #   # waybar
      #   /run/current-system/sw/bin/pkill -f waybar
      #   /etc/profiles/per-user/${oneuser}/bin/waybar -c ~/.config/waybar/mango-config -s ~/.config/waybar/mango-style.css &
      #
      #   # wallpaper
      #   /etc/profiles/per-user/${oneuser}/bin/swaybg -i ~/Pictures/wallhaven.cc/iii.png &
      #
      #   # extra
      #   # /usr/lib/xdg-desktop-portal-wlr &
      #   # /etc/profiles/per-user/${oneuser}/bin/wl-paste --type text --watch cliphist store &
      #   # /etc/profiles/per-user/${oneuser}/bin/wl-paste --type image --watch cliphist store &
      #   # /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
      #
      # '';
      settings = {
        env = [
          "QT_QPA_PLATFORMTHEME,qt6ct"
          "env=QT_QPA_PLATFORM,wayland;xcb"
        ];
        # monitor
        monitorrule = "name:^${toString monitors.output},width:${toString monitors.width},height:${toString monitors.height},refresh:${toString monitors.hz},x:0,y=0,scale:1"; # for virtual machine
        # monitorrule=name:^HDMI-A-1,width:1920,height:1080,refresh:60,x:0,y=0,scale:1 # for real monitor
        # allow game to bypass the compositors VSync for lower latency
        # allow_tearing=1;
        # autostart
        exec-once = "~/.config/mango/autostart.sh";
        # Window effect
        blur = 0;
        blur_layer = 0;
        blur_optimized = 1;
        blur_params = {
          num_passes = 2;
          radius = 5;
          noise = 0.02;
          brightness = 0.9;
          contrast = 0.9;
          saturation = 1.2;
        };

        shadows = 0;
        layer_shadows = 0;
        shadow_only_floating = 1;
        shadows_size = 10;
        shadows_blur = 15;
        shadows_position_x = 0;
        shadows_position_y = 0;
        shadowscolor = "0x000000ff";

        border_radius = 2;
        no_radius_when_single = 0;
        focused_opacity = 1.0;
        unfocused_opacity = 1.0;
        # Animation Configuration(support type:zoom,slide)
        # tag_animation_direction: 1-horizontal,0-vertical
        animations = 0;
        layer_animations = 0;
        animation_type_open = "slide";
        animation_type_close = "none";
        animation_fade_in = 1;
        animation_fade_out = 1;
        tag_animation_direction = 0;
        zoom_initial_ratio = 0.4;
        zoom_end_ratio = 0.8;
        fadein_begin_opacity = 0.5;
        fadeout_begin_opacity = 0.8;
        animation_duration = {
          move = 500;
          open = 350;
          tag = 250;
          close = 800;
          focus = 0;
        };
        animation_curve = {
          open = "0.46,1.0,0.29,1";
          move = "0.46,1.0,0.29,1";
          tag = "0.46,1.0,0.29,1";
          close = "0.08,0.92,0,1";
          focus = "0.46,1.0,0.29,1";
          opafadeout = "0.5,0.5,0.5,0.5";
          opafadein = "0.46,1.0,0.29,1";
        };
        # Scroller Layout Setting
        scroller_structs = 20;
        scroller_default_proportion = 0.8;
        scroller_focus_center = 0;
        scroller_prefer_center = 0;
        edge_scroller_pointer_focus = 1;
        scroller_default_proportion_single = 1.0;
        scroller_proportion_preset = "0.5,0.8,1.0";

        # Master-Stack Layout Setting
        new_is_master = 1;
        default_mfact = 0.55;
        default_nmaster = 1;
        smartgaps = 0;

        # Overview Setting
        hotarea_size = 10;
        enable_hotarea = 1;
        ov_tab_mode = 0;
        overviewgappi = 5;
        overviewgappo = 30;
        # Misc
        no_border_when_single = 0;
        axis_bind_apply_timeout = 100;
        focus_on_activate = 1;
        idleinhibit_ignore_visible = 0;
        sloppyfocus = 1;
        warpcursor = 0;
        focus_cross_monitor = 0;
        focus_cross_tag = 0;
        enable_floating_snap = 0;
        snap_distance = 30;
        cursor_size = 16;
        cursor_theme = "breeze_cursors";
        drag_tile_to_tile = 1;
        drag_tile_small = 1;

        # keyboard
        repeat_rate = 25;
        repeat_delay = 600;
        numlockon = 0;
        xkb_rules_layout = "us";

        # Trackpad
        # need relogin to make it apply
        disable_trackpad = 0;
        tap_to_click = 1;
        tap_and_drag = 1;
        drag_lock = 1;
        trackpad_natural_scrolling = 0;
        disable_while_typing = 1;
        left_handed = 0;
        middle_button_emulation = 0;
        swipe_min_threshold = 1;
        # mouse
        # need relogin to make it apply
        mouse_natural_scrolling = 0;

        # Appearance
        gappih = 2;
        gappiv = 2;
        gappoh = 4;
        gappov = 2;
        scratchpad_width_ratio = 0.8;
        scratchpad_height_ratio = 0.9;
        borderpx = 1;
        rootcolor = "0x201b14ff";
        bordercolor = "0x595959ff";
        dropcolor = "0x8FBA7C55";
        # default
        # focuscolor=0xb76110ff
        focuscolor = "0x4c4c4cff";
        # focuscolor=0x206469ff
        maximizescreencolor = "0x89aa61ff";
        urgentcolor = "0xad401fff";
        scratchpadcolor = "0x516c93ff";
        # globalcolor=0xb153a7ff
        globalcolor = "0xb76110ff";
        overlaycolor = "0x14a57cff";
        # Key Bindings
        # key name refer to `xev` or `wev` command output,
        # mod keys name: super,ctrl,alt,shift,none

        # reload config
        bind = [
          "SUPER+SHIFT,r,reload_config"

          # menu, terminal, & other
          "SUPER,p,spawn,rofi -opacity 80 -show drun"
          "SUPER+SHIFT,p,spawn,rofi -show power-menu -modi \"power-menu:rofi-power-menu --choices=shutdown/lockscreen/logout/reboot\""
          "SUPER,c,spawn, rofi -show calc -modi calc -no-show-match -no-sort -no-history -calc-command \"echo '{result}' | wl-copy\""
          "SUPER,t,spawn,alacritty"
          "SUPER+SHIFT,o,spawn,hyprpicker -a --format=hex"
          "SUPER,e,spawn, thunar"
          "SUPER,b,spawn_shell, waybar -c ~/.config/waybar/mango-config -s ~/.config/waybar/mango-style.css &"
          "SUPER+SHIFT,b,spawn, pkill waybar"
          "SUPER+SHIFT,x,spawn_shell, grim -g \"$(slurp)\" - | swappy -f -"
          "SUPER,w,spawn, wl-copy -c"

          "NONE,XF86AudioRaiseVolume,spawn,wpctl set-volume @DEFAULT_SINK@ 5%+"
          "NONE,XF86AudioLowerVolume,spawn,wpctl set-volume @DEFAULT_SINK@ 5%-"
          "NONE,XF86AudioMute,spawn,wpctl set-mute @DEFAULT_SINK@ toggle"
          "SHIFT,XF86AudioMute,spawn,wpctl set-mute @DEFAULT_SOURCE@ toggle"
          # exit
          "SUPER+SHIFT,q,quit"
          "SUPER+SHIFT,c,killclient,"
          # switch window focus
          "SUPER,Tab,focusstack,next"
          "SUPER,h,focusdir,left"
          "SUPER,l,focusdir,right"
          "SUPER,k,focusdir,up"
          "SUPER,j,focusdir,down"

          # swap window
          "SUPER+SHIFT,j,exchange_client,up"
          "SUPER+SHIFT,k,exchange_client,down"
          "SUPER+SHIFT,h,exchange_client,left"
          "SUPER+SHIFT,l,exchange_client,right"

          # switch window status
          "SUPER,g,toggleglobal,"
          "ALT,Tab,toggleoverview,"
          "SUPER+SHIFT,s,togglefloating,"
          "ALT,a,togglemaximizescreen,"
          "ALT,f,togglefullscreen,"
          "ALT+SHIFT,f,togglefakefullscreen,"
          "SUPER,i,minimized,"
          "SUPER,o,toggleoverlay,"
          "SUPER+SHIFT,I,restore_minimized"
          "ALT,z,toggle_scratchpad"

          # scroller layout
          "ALT,e,set_proportion,1.0"
          "ALT,x,switch_proportion_preset,"

          # switch layout
          "SUPER,n,switch_layout"
          "ALT,t,setlayout,tile"
          "ALT,s,setlayout,scroller"
          # tag switch
          "SUPER,Left,viewtoleft,0"
          "CTRL,Left,viewtoleft_have_client,0"
          "SUPER,Right,viewtoright,0"
          "CTRL,Right,viewtoright_have_client,0"
          "CTRL+SUPER,Left,tagtoleft,0"
          "CTRL+SUPER,Right,tagtoright,0"

          # tag: move client to the tag and focus it
          # tagsilent: move client to the tag and not focus it
          # "Alt,1,tagsilent,1
          "SUPER+SHIFT,1,tag,1,0"
          "SUPER+SHIFT,2,tag,2,0"
          "SUPER+SHIFT,3,tag,3,0"
          "SUPER+SHIFT,4,tag,4,0"
          "SUPER+SHIFT,5,tag,5,0"
          "SUPER+SHIFT,6,tag,6,0"
          "SUPER+SHIFT,7,tag,7,0"
          "SUPER+SHIFT,8,tag,8,0"
          "SUPER+SHIFT,9,tag,9,0"
          "SUPER+SHIFT,8,tag,8,0"
          "SUPER+SHIFT,9,tag,9,0"

          # monitor switch
          "alt+shift,Left,focusmon,left"
          "alt+shift,Right,focusmon,right"
          "SUPER+Alt,Left,tagmon,left"
          "SUPER+Alt,Right,tagmon,right"

          # gaps
          "ALT+SHIFT,X,incgaps,1"
          "ALT+SHIFT,Z,incgaps,-1"
          "ALT+SHIFT,R,togglegaps"

          # movewin
          "CTRL+SHIFT,Up,movewin,+0,-50"
          "CTRL+SHIFT,Down,movewin,+0,+50"
          "CTRL+SHIFT,Left,movewin,-50,+0"
          "CTRL+SHIFT,Right,movewin,+50,+0"

          # resizewin
          "SUPER+SHIFT+ALT,k,resizewin,+0,-10"
          "SUPER+SHIFT+ALT,j,resizewin,+0,+10"
          "SUPER+SHIFT+ALT,h,resizewin,-10,+0"
          "SUPER+SHIFT+ALT,l,resizewin,+10,+0"

          # bindr extend
          "SUPER,1,view,1,0"
          "SUPER,2,view,2,0"
          "SUPER,3,view,3,0"
          "SUPER,4,view,4,0"
          "SUPER,5,view,5,0"
          "SUPER,6,view,6,0"
          "SUPER,7,view,7,0"
          "SUPER,8,view,8,0"
          "SUPER,9,view,9,0"
        ];
        bindr = [
          "SUPER,2,spawn_shell, pkill swaybg; swaybg -i ~/Pictures/wallhaven.cc/ii.png"
          "SUPER,3,spawn_shell, pkill swaybg; swaybg -i ~/Pictures/wallhaven.cc/iii.png"
          "SUPER,4,spawn_shell, pkill swaybg; swaybg -i ~/Pictures/wallhaven.cc/iv.png"
          "SUPER,5,spawn_shell, pkill swaybg; swaybg -i ~/Pictures/wallhaven.cc/v.png"
          "SUPER,6,spawn_shell, pkill swaybg; swaybg -i ~/Pictures/wallhaven.cc/vi.png"
          "SUPER,7,spawn_shell, pkill swaybg; swaybg -i ~/Pictures/wallhaven.cc/vii.png"
        ];
        mousebind = [
          "SUPER,code:274,killclient,"
          # Mouse Button Bindings
          # btn_left and btn_right can't bind none mod key
          "SUPER,btn_left,moveresize,curmove"
          # "NONE,btn_middle,togglemaximizescreen,0"
          "SUPER,btn_right,moveresize,curresize"
        ];
        windowrule = [
          "appid:localsend,isfloating:1,width:385,height:660,offsetx:98,offsety:99,animation_type_close:none,isglobal:1"
          "tags:2,appid:Alacritty"
          "tags:1,appid:org.qutebrowser.qutebrowser"
          "tags:1,appid:firefox-developer-edition"
          "tags:3,appid:Mullvad Browser Alpha"
          "tags:3,appid:chromium"
          "tags:3,appid:jetbrains-studio"
          "tags:4,appid:virt-manager"
          "tags:4,appid:org.gnome.Nautilus"
          "tags:4,appid:thunar"
          "tags:4,appid:Tor Browser Alpha"
          "title:Picture-in-Picture,isfloating:1,width:625,height:357,offsetx:95,offsety:-99,animation_type_close:none,isglobal:1,animation_type_close:none"
          "appid:Raspberry Pi Imager,isfloating:1,width:612,height:534,offsetx:8,offsety:99,animation_type_close:none,isglobal:1,animation_type_close:none"
          "tags:6,title:Nextcloud,isfloating:1,width:389,height:1054,offsetx:99"
          "tags:6,title:Nextcloud Settings,isfloating:1,width:389,height:1054,offsetx:25"
          "appid:Cryptomator,isfloating:1,width:650,height:537,offsetx:99,offsety:99,animation_type_close:none,isglobal:1"
          # # qemu rule
          "tags:4,appid:qemu-system-x86_64,layer_name:tile"
          # # signal windowrules
          "title:Signal,isfloating:1,width:684,height:830,offsetx:99,offsety:99,animation_type_close:none"
          # # steam windowrules
          "appid:steam,isfloating:1,width:1024,height:660,animation_type_close:none"
          # # scrcpy
          "appid:scrcpy,isfloating:1,width:454,height:984,offsetx:99,isglobal:1"
          # # Gnome calculator
          "appid:org.gnome.Calculator,isfloating:1,width:360,height:616,offsetx:99,offsety:98,isglobal:1,animation_type_close:none"
          # # Veracrypt
          "appid:veracrypt,isfloating:1,width:584,height:553,animation_type_close:none"
          # # disks
          "appid:org.gnome.DiskUtility,isfloating:1,isglobal:1,width:592,height:598,animation_type_close:none,offsetx:99,offsety:99"
        ];
        # # tag 6 rules
        # todo()! for gap in specific tag
        # workspace = 6, gapsout:50 394 50 50, gapsin:5

        # layer rule
        layerrule = [
          "noanim:1,noblur:1,layer_name:rofi"
          "noanim:1,noblur:1,layer_name:rofi"
        ];

        # layout support:
        # tile,scroller,grid,deck,monocle,center_tile,vertical_tile,vertical_scroller
        tagrule = [
          "id:1,no_hide:1,layout_name:dwindle"
          "id:2,no_hide:2,layout_name:dwindle"
          "id:3,no_hide:3,layout_name:tile"
          "id:4,no_hide:4,layout_name:tile"
          "id:5,no_hide:5,layout_name:tile"
          "id:6,no_hide:6,layout_name:dwindle"
          "id:7,no_hide:7,layout_name:tile"
        ];
        # Example dwindle configuration
        dwindle_split_ratio = 0.5;
        dwindle_smart_split = 0;
        dwindle_hsplit = 0;
        dwindle_vsplit = 0;
        dwindle_preserve_split = 0;
        dwindle_smart_resize = 0;
        dwindle_drop_simple_split = 1;
        # Axis Bindings
        axisbind = [
          "SUPER,UP,viewtoleft_have_client"
          "SUPER,DOWN,viewtoright_have_client"
        ];
      };
    };
  };
  # home.file = lib.mkMerge [
  #   (lib.mkIf (info.host == "vm") {
  #     ".config/mango/autostart.sh" = {
  #       source = ../../configs/.config/mango/nix/vm/autostart-nix.sh;
  #       recursive = true;
  #     };
  #     ".config/mango/config.conf" = {
  #       source = ../../configs/.config/mango/nix/vm/config-nix.conf;
  #       recursive = true;
  #     };
  #   })
  #   (lib.mkIf (info.host == "vm-btrfs") {
  #     ".config/mango/autostart.sh" = {
  #       source = ../../configs/.config/mango/nix/vm/autostart-nix.sh;
  #       recursive = true;
  #     };
  #     ".config/mango/config.conf" = {
  #       source = ../../configs/.config/mango/nix/vm/config-nix.conf;
  #       recursive = true;
  #     };
  #   })
  #   (lib.mkIf (info.host == "vm-zfs") {
  #     ".config/mango/autostart.sh" = {
  #       source = ../../configs/.config/mango/nix/vm/autostart-nix.sh;
  #       recursive = true;
  #     };
  #     ".config/mango/config.conf" = {
  #       source = ../../configs/.config/mango/nix/vm/config-nix.conf;
  #       recursive = true;
  #     };
  #   })
  #   (lib.mkIf (info.host == "netbook") {
  #     ".config/mango/autostart.sh" = {
  #       source = ../../configs/.config/mango/nix/netbook/autostart-nix.sh;
  #       recursive = true;
  #     };
  #     ".config/mango/config.conf" = {
  #       source = ../../configs/.config/mango/nix/netbook/config-nix.conf;
  #       recursive = true;
  #     };
  #   })
  #   (lib.mkIf (info.host == "pc") {
  #     ".config/mango/autostart.sh" = {
  #       source = ../../configs/.config/mango/nix/pc/autostart-nix.sh;
  #       recursive = true;
  #     };
  #     ".config/mango/config.conf" = {
  #       source = ../../configs/.config/mango/nix/pc/config-nix.conf;
  #       recursive = true;
  #     };
  #   })
  # ];
}

