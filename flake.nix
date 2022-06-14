{
  description = "My home manager configuration";
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.05";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  
  outputs = { self, nixpkgs, home-manager}:
    let
      system = "x86_64-linux";
      username = "sda";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in {
      hmConfig.${username} = home-manager.lib.homeManagerConfiguration {
	inherit system username pkgs;

        configuration = import ./home.nix;
        homeDirectory = "/home/${username}";
        stateVersion = "22.05";
      };
    };
}
