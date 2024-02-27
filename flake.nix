{
    description = "Konstanty's homelab";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
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

    };
}
