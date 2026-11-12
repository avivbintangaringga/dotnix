{
  dotnix.v4l2loopback = {
    nixos = { config, ... }: {
      boot = {
        extraModprobeConfig = ''
          options v4l2loopback video_nr=10 card_label="scrcpy-panel" exclusive_caps=0
        '';
        extraModulePackages = [
          config.boot.kernelPackages.v4l2loopback
        ];
        kernelModules = [
          "v4l2loopback"
        ];
      };
    };
  };
}
