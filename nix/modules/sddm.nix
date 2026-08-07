{
  inputs,
  pkgs,
  ...
}: let
  sddm-astronaut =
    (pkgs.sddm-astronaut.override {
      embeddedTheme = "pixel_aesthetic_static"; # or any other theme
      themeConfig = {
        ScreenWidth = "1920";
        ScreenHeight = "1080";
        ScreenPadding = "";
        Font = "arcadeclassic";
        FontSize = "11";
        KeyboardSize = "0.4";
        RoundCorners = "20";
        Locale = "";
        HourFormat = "HH:mm";
        DateFormat = "dddd d";
        HeaderText = "";
        BackgroundPlaceholder = "";
        Background = "Backgrounds/1.png";
        BackgroundSpeed = "";
        PauseBackground = "";
        DimBackground = "0.0";
        CropBackground = "true";
        BackgroundHorizontalAlignment = "center";
        BackgroundVerticalAlignment = "center";
        HeaderTextColor = "#ae8422";
        DateTextColor = "#ae8422";
        TimeTextColor = "#ae8422";
        FormBackgroundColor = "#21222C";
        BackgroundColor = "#21222C";
        DimBackgroundColor = "#21222C";
        LoginFieldBackgroundColor = "#cccccc";
        PasswordFieldBackgroundColor = "#cccccc";
        LoginFieldTextColor = "#825f23";
        PasswordFieldTextColor = "#825f23";
        UserIconColor = "#6a6954";
        PasswordIconColor = "#6a6954";
        PlaceholderTextColor = "#6a6954";
        WarningColor = "#3d495b";
        LoginButtonTextColor = "#ffffff";
        LoginButtonBackgroundColor = "#3d495b";
        SystemButtonsIconsColor = "#3d495b";
        SessionButtonTextColor = "#786e5d";
        VirtualKeyboardButtonTextColor = "#3d495b";
        DropdownTextColor = "#ffffff";
        DropdownSelectedBackgroundColor = "#697f90";
        DropdownBackgroundColor = "#3d495b";
        HighlightTextColor = "#bbbbbb";
        HighlightBackgroundColor = "#3d495b";
        HighlightBorderColor = "transparent";
        HoverUserIconColor = "#9a5e36";
        HoverPasswordIconColor = "#9a5e36";
        HoverSystemButtonsIconsColor = "#9a5e36";
        HoverSessionButtonTextColor = "#9a5e36";
        HoverVirtualKeyboardButtonTextColor = "#697f90";
        PartialBlur = "";
        FullBlur = "";
        BlurMax = "";
        Blur = "";
        HaveFormBackground = "false";
        FormPosition = "center";
        VirtualKeyboardPosition = "center";
        HideVirtualKeyboard = "true";
        HideSystemButtons = "true";
        HideLoginButton = "true";
        ForceLastUser = "true";
        PasswordFocus = "true";
        HideCompletePassword = "true";
        AllowEmptyPassword = "false";
        AllowUppercaseLettersInUsernames = "false";
        BypassSystemButtonsChecks = "false";
        RightToLeftLayout = "false";
        TranslatePlaceholderUsername = "";
        TranslatePlaceholderPassword = "";
        TranslateLogin = "";
        TranslateLoginFailedWarning = "";
        TranslateCapslockWarning = "";
        TranslateSuspend = "";
        TranslateHibernate = "";
        TranslateReboot = "";
        TranslateShutdown = "";
        TranslateSessionSelection = "";
        TranslateVirtualKeyboardButtonOn = "";
        TranslateVirtualKeyboardButtonOff = "";
      };
    }).overrideAttrs (oldAttrs: {
      installPhase =
        oldAttrs.installPhase
        + ''
          chmod u+w $out/share/sddm/themes/sddm-astronaut-theme/Backgrounds/
          # cp ${../../configs/sddm/sddm-astronaut-theme/Backgrounds/1.png} \
          cp ${inputs.sddm-backgrounds} \
          $out/share/sddm/themes/sddm-astronaut-theme/Backgrounds/1.png
        '';
    });
in {
  imports = [./font-sddm-astronaut.nix];

  environment.systemPackages = [sddm-astronaut];

  services.displayManager.sddm = {
    enable = true;
    package = pkgs.kdePackages.sddm;
    extraPackages = with pkgs; [
      kdePackages.qtmultimedia # Required for video backgrounds/audio
    ];
    theme = "sddm-astronaut-theme";
  };
  services.displayManager.sddm.wayland.enable = true;
}
