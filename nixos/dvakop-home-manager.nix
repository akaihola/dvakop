{ config, pkgs, lib, ... }:

{
  # Required for keyboard layout customization.
  xdg.enable = true;

  home.file = {
    ".config/xkb/rules/evdev".source = config.lib.file.mkOutOfStoreSymlink ./dvakop/rules/evdev;
    ".config/xkb/rules/evdev.xml".source = config.lib.file.mkOutOfStoreSymlink ./dvakop/rules/evdev.xml;
    ".config/xkb/symbols/dvakop".source = config.lib.file.mkOutOfStoreSymlink ./dvakop/symbols/dvakop;
  };
}
