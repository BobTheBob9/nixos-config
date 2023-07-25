{
  description = "bobthebob's home manager configuration";

  inputs = {
    # Specify the source of Home Manager and Nixpkgs.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
    nur.url = "github:nix-community/NUR";
    
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    plasma-manager.url = "github:pjones/plasma-manager";
    plasma-manager.inputs.nixpkgs.follows = "nixpkgs";
    plasma-manager.inputs.home-manager.follows = "home-manager";
  };

  outputs = inputs:
    let
      system = "x86_64-linux";
      username = "bobthebob";
      pkgs = import inputs.nixpkgs 
      { 
        inherit system;
        allowUnfree = true;
        overlays = [ inputs.nur.overlay ];
      };
    in 
    {
      homeConfigurations.${username} = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        # Specify your home configuration modules here, for example,
        # the path to your home.nix.
        modules = [ 
          ./home.nix 

          inputs.plasma-manager.homeManagerModules.plasma-manager 
        ];

        # Optionally use extraSpecialArgs
        # to pass through arguments to home.nix
	      extraSpecialArgs = { inherit inputs; };
      };
    };
}
