# dotnix

Personal NixOS config, managed as a flake. One host (`inferno`), one user (`r7fx`).

## Structure

Built using the **dendritic pattern** via [den](https://github.com/denful/den).
Every `.nix` file under `modules/` gets auto-discovered and merged
(`import-tree`), so folder layout is just for organization, not function.

Flake inputs are managed with [flake-file](https://github.com/denful/flake-file)
instead of editing `flake.nix` directly. To regenerate it after adding an
input somewhere in `modules/`:

```sh
nix run .#write-flake
```

`flake.nix` is generated, don't edit it by hand.

## Layout

- `modules/base/` -> core system config (boot, fonts, timezone, etc.)
- `modules/desktop/` -> desktop environments and WM configs
- `modules/apps/` -> applications
- `modules/gaming/` -> steam, proton, gamescope
- `modules/virtualization/` -> docker, VM with GPU passthrough, waydroid
- `modules/programming/` -> language toolchains, editors
- `modules/hosts/inferno/` -> host-specific hardware config
- `modules/users/r7fx.nix` -> user configuration

## Usage

```sh
nh os switch . -H inferno
```

Home-manager config is applied as part of the above, but it can also be
switched on its own:

```sh
nh home switch . -c r7fx
```
