{
  description = "Home Manager configuration of bobthebob";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = github:nix-community/NUR;
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { nixpkgs, nur, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = import inputs.nixpkgs { 
               inherit system;
               allowUnfree = true;
               overlays = [ inputs.nur.overlay ];
             };
    in {
      homeConfigurations.bobthebob = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ ./home.nix ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
	extraSpecialArgs = { inherit inputs; };
      };
  };
}
