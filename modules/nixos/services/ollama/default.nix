{ lib, config, ... }:
{
  options = {
    setup.services.ollama.enable = lib.mkEnableOption "Ollama";
  };

  config = lib.mkIf config.setup.services.ollama.enable {
    services.ollama = {
      enable = true;
      acceleration = "cuda";
      loadModels = [
        "qwen2.5-coder:3b"
      ];
    };
  };
}
