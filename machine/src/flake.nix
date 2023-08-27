{
    description = "bobthebob's system configuration";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/23.05";
    };

    outputs = inputs:
        let
            system = "x86_64-linux";
            username = "bobthebob";
            pkgs = import inputs.nixpkgs
            {
                inherit system;
                allowUnfree = true;
            };
        in
        {
            nixosConfigurations = {
                nixos = inputs.nixpkgs.lib.nixosSystem {
                    system = system;
                    modules = [ ./configuration.nix ];
                    specialArgs = { inherit inputs; };
                };
            };
        };
}
