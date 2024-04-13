{
    description = "Konstanty's homelab";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
        agenix = {
            url = "github:ryantm/agenix";
            inputs.nixpkgs.follows = "nixpkgs";
        };
        hardware.url = "github:nixos/nixos-hardware";
    };

    outputs = { self, nixpkgs, ... } @ inputs:

    let

        system = "x86_64-linux";

        pkgs = import nixpkgs {
            inherit system;
        };

    in rec {

        packages.${system} = rec {
            nvim = pkgs.callPackage ./pkgs/nvim {};
        };

        nixosConfigurations = {
            twelve = nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                modules = with inputs; [
                    hardware.nixosModules.lenovo-thinkpad-t480
                    agenix.nixosModules.default
                    ./hosts/twelve
                ];
                specialArgs = self;
            };
        };

    };
}
