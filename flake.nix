{
  inputs = {
    nixpkgs.url = "https://channels.nixos.org/nixos-26.05/nixexprs.tar.xz";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    catppuccin.url = "github:catppuccin/nix/release-26.05";
    home-manager.url = "github:nix-community/home-manager/release-26.05";
  };
  outputs = { self, nixpkgs, home-manager, catppuccin, nixpkgs-unstable, ... }@inputs: 
    let
      system = "x86_64-linux";
      
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations = {
        nixos = nixpkgs.lib.nixosSystem {
          inherit system;
          specialArgs = {
            inherit inputs pkgs-unstable;
          };
          modules = [
            ./hardware-configuration.nix
            ./configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.backupFileExtension = "backup";
              home-manager.extraSpecialArgs = { 
	        inherit inputs pkgs-unstable;
              };
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
