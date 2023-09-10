{
    description = "bobthebob's system configuration";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/23.05";
    };

    outputs = inputs:
        let
            username = "bobthebob";
            system = "x86_64-linux";
        in
        {
            nixosConfigurations = {
                nixos = inputs.nixpkgs.lib.nixosSystem
                {
                    system = system;
                    specialArgs = { inherit inputs; };
                    modules = [ ./configuration.nix ];
                };

                nixos-iso = inputs.nixpkgs.lib.nixosSystem
                {
                    system = system;
                    specialArgs = { inherit inputs; };
                    modules = [
                        ./configuration.nix
                        "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
                    ];

                    isoImage.squashfsCompression = "gzip -Xcompression-level 1";
                };
            };
        };
}
