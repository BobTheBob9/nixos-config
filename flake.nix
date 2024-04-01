{
    description = "bobthebob's system configuration";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/23.11";
        nixpkgs-unstable.url = "github:nixos/nixpkgs"; # for things that expect/benefit from frequent updates and not having a pinned version: e.g. mostly parsec and games
        pkgs-waylandFlameshot.url = "github:haizaar/nixpkgs?rev=ca6081cbce02589ad9594350ce6e5bca39b09ad1";
        nix-gaming.url = "github:fufexan/nix-gaming";
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
                    specialArgs = {
                                    pkgs-unstable = import inputs.nixpkgs-unstable { system = system; };
                                    pkgs-waylandFlameshot = import inputs.pkgs-waylandFlameshot { system = system; };
                                    nix-gaming = inputs.nix-gaming;
                                };
                    modules = [ ./configuration.nix ];
                };
            };
        };
}
