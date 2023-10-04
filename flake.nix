{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    neovim.url = "git+file:/home/odie/Code/nix/neovim";
    neovim.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, neovim, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          neovim.overlays.${system}.neovim-nightly
          neovim.overlays.${system}.plugins
          neovim.overlays.${system}.neovim-ide
        ];
        config = {
          allowUnfree = true;
        };
      };
      lib = nixpkgs.lib;
    in
    {
      homeConfigurations = {
        odie = home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [
            ./nix/users/odie/home.nix
          ];
        };
      };
      nixosConfigurations = {
        nixos-testing = lib.nixosSystem {
          inherit system;
          inherit pkgs;
          modules = [
            ./nix/hosts/nixos-testing/configuration.nix
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
            }
          ];
        };
      };
    };
}
