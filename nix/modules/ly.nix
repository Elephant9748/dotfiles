{pkgs, ...}: {
  services = {
    displayManager = {
      ly = {
        enable = true;
        package = pkgs.ly;
        x11Support = false;
        settings = {
          save = true;
          animation = "none";
          asterik = "*";
          auth_fails = "5";
          clock = "%c";
          lang = "en";
          shell = false; # issue cant login using shell nixos 25,11 up
          # bigclock = "en";
          full_color = true;
          ly_log = "/var/log/ly.log";
          numlock = false;
          service_name = "ly";
          border_fg = "0x00FFFFFF";
          error_bg = "0x00000000";
          error_fg = "0x01FF0000";
          fg = "0x00FFFFFF";
          default_input = "login";
          margin_box_h = "2";
          margin_box_v = "1";
          show_tty = false;
          hide_version_string = false;
        };
      };
    };
  };
}
