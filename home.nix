{ config, pkgs, ... }:

{
  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        ms-python.python
        rust-lang.rust-analyzer
        golang.go
      ];
    };
  };

  programs.alacritty.enable = true;

  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "sky";
  };
  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "26.05";
}
