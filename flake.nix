{
    description = "Konstanty's homelab";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
        hardware.url = "github:nixos/nixos-hardware";
        agenix = {
          url = "github:ryantm/agenix";
          inputs.nixpkgs.follows = "nixpkgs";
        };
        # lanzaboote = {
        #   url = "github:nix-community/lanzaboote/v0.3.0";
        #   inputs.nixpkgs.follows = "nixpkgs";
        # };
    };

    outputs = { self, nixpkgs, ... } @ inputs:

    let

        system = "x86_64-linux";

        pkgs = import nixpkgs {
            inherit system;
        };

    in {

        devShells.${system} = {
          tools = pkgs.callPackage;
        };

        packages.${system} = {
          nvim = pkgs.callPackage ./pkgs/nvim {};
          tools = {
            run-host-vm = pkgs.writeScriptBin "run-host-vm" ''
              set -eou pipefail
              nix build .#nixosConfigurations."$1".config.system.build.vm -vv -L
              ./result/bin/run-"$1"-vm
            '';
          };
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

            five = nixpkgs.lib.nixosSystem {
              system = "x86_64-linux";
              modules = with inputs; [
                  hardware.nixosModules.lenovo-thinkpad-t14
                  agenix.nixosModules.default
                  ./hosts/five
              ];
              specialArgs = self;
          };
      };
    };
}
