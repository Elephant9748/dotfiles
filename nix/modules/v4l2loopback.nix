{ config, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    v4l-utils
  ];

  boot = {
    extraModulePackages = with config.boot.kernelPackages; [
      v4l2loopback
    ];
    extraModprobeConfig = ''
      options v4l2loopback video_nr=2 card_label="vv4l2loopback_screen_sharing" exclusive_caps=1
    '';
    kernelModules = [
      # Virtual camera.
      "v4l2loopback"
      # Virtual Microphone. Custom DroidCam v4l2loopback driver needed for audio.
      # "snd-aloop"
    ];
  };
}
