{
    description = "Computers under my care";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
        hardware.url = "github:nixos/nixos-hardware";
        agenix = {
          url = "github:ryantm/agenix";
          inputs.nixpkgs.follows = "nixpkgs";
        };
        rocs = {
            url = "github:kowale/rocs";
            inputs.nixpkgs.follows = "nixpkgs";
        };

        nix-darwin = {
          url = "github:LnL7/nix-darwin";
          inputs.nixpkgs.follows = "nixpkgs";
        };
    };

    outputs = { self, nixpkgs, ... } @ inputs:

    let

        system = "x86_64-linux";

        pkgs = import nixpkgs {
            inherit system;
        };

    in {

      packages.${system} = {

          nvim = pkgs.callPackage ./pkgs/nvim {};

          run-host-vm = pkgs.writeScriptBin "run-host-vm" ''
            set -eou pipefail
            nix build .#nixosConfigurations."$1".config.system.build.vm -vv -L
            ./result/bin/run-"$1"-vm
          '';
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

          six = nixpkgs.lib.nixosSystem {
            system = "x86_64-linux";
            modules = with inputs; [
                hardware.nixosModules.lenovo-thinkpad-t14-amd-gen5
                agenix.nixosModules.default
                ./hosts/six
            ];
            specialArgs = self;
          };

        };

    };
}
