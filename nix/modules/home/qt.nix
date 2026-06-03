{ pkgs, version, lib,  ... }: {

  home.packages = with pkgs; [
    kdePackages.qt6ct
  ];

  qt = {
    enable = true;
    platformTheme = "qtct"; 
    style.name = "Fusion";  
    qt5ctSettings = {
      Appearance = {
        color_scheme_path = "/usr/share/qt6ct/colors/darker.conf";
        custom_palette = true;
        icon_theme = "cosmic-icons";
        standard_dialogs = "default";
        style = "Fusion";
      };

      Fonts = {
        fixed = "\"Noto Sans Mono,9,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular,0,0\"";
        general = "\"JetBrainsMono Nerd Font,9,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular,0,0\"";
      };

      Interface = {
        activate_item_on_single_click = 1;
        buttonbox_layout = 0;
        cursor_flash_time = 1000;
        dialog_buttons_have_icons = 1;
        double_click_interval = 400;
        keyboard_scheme = 2;
        menus_have_icons = true;
        show_shortcuts_in_context_menus = true;
        toolbutton_style = 4;
        underline_shortcut = 1;
        wheel_scroll_lines = 3;
      };
      Troubleshooting = {
        force_raster_widgets = 1;
      };
    };
    qt6ctSettings = {
      Appearance = {
        color_scheme_path = "/usr/share/qt6ct/colors/darker.conf";
        custom_palette = true;
        icon_theme = "cosmic-icons";
        standard_dialogs = "default";
        style = "Fusion";
      };

      Fonts = {
        fixed = "\"Noto Sans Mono,9,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular,0,0\"";
        general = "\"JetBrainsMono Nerd Font,9,-1,5,400,0,0,0,0,0,0,0,0,0,0,1,Regular,0,0\"";
      };

      Interface = {
        activate_item_on_single_click = 1;
        buttonbox_layout = 0;
        cursor_flash_time = 1000;
        dialog_buttons_have_icons = 1;
        double_click_interval = 400;
        keyboard_scheme = 2;
        menus_have_icons = true;
        show_shortcuts_in_context_menus = true;
        toolbutton_style = 4;
        underline_shortcut = 1;
        wheel_scroll_lines = 3;
      };
      Troubleshooting = {
        force_raster_widgets = 1;
      };
    };
  };
}   
