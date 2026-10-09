{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    chafa
  ];

  programs = {

    bash = {
      enable = true;
      initExtra = ''
        chafa -s 20 ~/.penguin_term.png
        cal
        '';
    };

    vscode = {
      enable = true;
      profiles.default = {
        enableUpdateCheck = false;
        enableExtensionUpdateCheck = false;
        extensions = lib.mkForce (with pkgs.vscode-extensions; [
          catppuccin.catppuccin-vsc
          catppuccin.catppuccin-vsc-icons
          ms-python.python
          rust-lang.rust-analyzer
          golang.go
          mkhl.direnv
          bbenoist.nix
        ]);
        userSettings = {
          "rust-analyzer.server.path" = "rust-analyzer";
        };
      };
    };

    direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv.enable = true;
    };

    kitty = {
      enable = true;
      enableGitIntegration = true;
    };
  };
  catppuccin = {
    enable = true;
    flavor = "mocha";
    accent = "sky";
    vscode = {
      profiles."default" = {
        enable = true;
      };
    };
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
