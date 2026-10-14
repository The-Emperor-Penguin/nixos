{ config, pkgs, lib, ... }:

{

  imports = [
    ./hyprland-config.nix
    ./waybar-config.nix
  ];

  home.packages = with pkgs; [
    chafa
  ];

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "x-scheme-handler/http" = "app.zen_browser.zen.desktop";
      "x-scheme-handler/https" = "app.zen_browser.zen.desktop";
      "x-scheme-handler/unknown" = "app.zen_browser.zen.desktop";
    };
  };

  xdg.portal = {
    enable = true;
    
    # Let Home Manager know which backend configurations exist
    configPackages = [
      pkgs.xdg-desktop-portal-hyprland
      pkgs.xdg-desktop-portal-gtk
    ];

    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
    ];

    config = {
      common = {
        default = [ "hyprland" "gtk" ];
        "org.freedesktop.impl.portal.OpenURI" = [ "gtk" ];
      };
      hyprland = {
        default = [ "hyprland" "gtk" ];
        "org.freedesktop.impl.portal.OpenURI" = [ "gtk" ];
      };
    };
  };

  services = {
    hyprpolkitagent.enable = true;

    hyprpaper = {
     enable = true;
     settings = {
       splash = false;
       wallpaper = [
         {
           monitor = "";
           path = "/share/wallpapers/penguins.jpg";
         }
       ];
      };
    };
  };

  programs = {

    rofi = {
      enable = true;
      plugins = [ pkgs.rofi-calc ];
    };

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
      settings = {
        "remember_window_size" = "no";
      };
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
