{pkgs, ...}: {
  environment.cosmic.excludePackages = with pkgs; [
    cosmic-greeter
  ];

  services = {
    desktopManager = {
      cosmic = {
        enable = true;
        showExcludedPkgsWarning = false;
      };
    };
    displayManager = {
      cosmic-greeter = {
        enable = false;
      };
    };
  };
}
