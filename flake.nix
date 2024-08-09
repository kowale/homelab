{
    description = "Konstanty's homelab";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs/nixos-24.05";
        hardware.url = "github:nixos/nixos-hardware";
        agenix = {
          url = "github:ryantm/agenix";
          inputs.nixpkgs.follows = "nixpkgs";
        };
        # lanzaboote = {
        #   url = "github:nix-community/lanzaboote/v0.3.0";
        #   inputs.nixpkgs.follows = "nixpkgs";
        # };
        rocs = {
            url = "github:kowale/rocs";
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

          docs = inputs.rocs.lib.buildSite {
            inherit pkgs;
            root = self.outPath;
            emoji = "⚗️";
          };

          nvim = pkgs.callPackage ./pkgs/nvim {};
          tools = {
            name = "tools";
            type = "derivation";
            run-host-vm = pkgs.writeScriptBin "run-host-vm" ''
              set -eou pipefail
              nix build .#nixosConfigurations."$1".config.system.build.vm -vv -L
              ./result/bin/run-"$1"-vm
            '';
        };
      };

        # checks.${system} = {
          # eval-self = pkgs.writeText "eval-self" (builtins.deepSeq self "OK");
        # };

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

            pear = nixpkgs.lib.nixosSystem {
              system = "x86_64-linux";
              modules = with inputs; [
                  agenix.nixosModules.default
                  ./hosts/pear
              ];
              specialArgs = self;
          };

      };
    };
}
