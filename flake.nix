# DO-NOT-EDIT. This file was auto-generated using github:vic/flake-file.
# Use `nix run .#write-flake` to regenerate it.
{
  description = "My NixOS config :)";

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);

  inputs = {
    auto-cpufreq = {
      url = "github:AdnanHodzic/auto-cpufreq";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    dankmaterialshell = {
      url = "github:AvengeMedia/DankMaterialShell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    den.url = "github:denful/den";
    flake-file.url = "github:denful/flake-file";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };
    hardware.url = "github:nixos/nixos-hardware";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    import-tree.url = "github:denful/import-tree";
    mango = {
      url = "github:DreamMaoMao/mango";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:epireyn/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-alien = {
      url = "github:thiagokokada/nix-alien";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "nixpkgs/nixos-unstable";
    noctalia.url = "github:noctalia-dev/noctalia/cachix";
    noctalia-greeter = {
      url = "github:noctalia-dev/noctalia-greeter";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvix = {
      url = "github:niksingh710/nvix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pedantix.url = "github:swarsel/pedantix";
    qtengine = {
      url = "github:kossLAN/qtengine";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    thorium-browser = {
      url = "github:Rishabh5321/custom-packages-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt.url = "github:numtide/treefmt-nix";
    umbriel = {
      url = "github:noctalia-dev/umbriel";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    xdg-desktop-portal-umbriel = {
      url = "github:noctalia-dev/xdg-desktop-portal-umbriel";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake/67202a6dc9ad712796fe31ef7797084d1fb8dbfe";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
