{
    description = "bobthebob's home manager configuration";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/23.11";
        nixpkgs-unstable.url = "github:nixos/nixpkgs";

        nur.url = "github:nix-community/NUR";

        nix-gaming.url = "github:fufexan/nix-gaming";
        ssbm.url = "github:djanatyn/ssbm-nix";
        aagl.url = "github:ezKEa/aagl-gtk-on-nix";

        home-manager.url = "github:nix-community/home-manager/release-23.11";
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
                extraSpecialArgs = { inherit inputs; pkgs-unstable = import inputs.nixpkgs-unstable { system = "x86_64-linux"; }; };
            };
        };
}
