{
  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-26.05/nixexprs.tar.xz";
    catppuccin.url = "github:catppuccin/nix/release-26.05";
    home-manager.url = "github:nix-community/home-manager/release-26.05";
  };
  outputs = { self, nixpkgs, home-manager, catppuccin, ... }@inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hardware-configuration.nix
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.users.josiah = {
              imports = [
                ./home.nix
                catppuccin.homeModules.catppuccin
              ];
            };
          }
        ];
      };
    };
  };
}
