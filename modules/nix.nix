{ config, inputs, pkgs, ... }:

{

    age.secrets."netrc".file = ../secrets/netrc.age;
    programs.direnv.enable = true;

    nix = {

        optimise = {
            automatic = true;
        };

        gc = {
            automatic = true;
            dates = "weekly";
            randomizedDelaySec = "30min";
        };

        settings = {
            substituters = [
              "https://cache.nixos.org" # 40
              "https://nix-community.cachix.org" # 41
              "https://cuda-maintainers.cachix.org" # 41
              "https://cache.garnix.io" # 50
            ];
            trusted-public-keys = [
              "cache.pear.local:NdBzAs/wPQnM5PYbpwtyA32z+eDpQ+czQKO+IwvTbkQ="
              "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
              "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
              "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
            ];


            # https://jackson.dev/post/nix-reasonable-defaults/
            trusted-users = [ "@wheel" ];
            system-features = [ "kvm" "big-parallel" "nixos-test" ];
            connect-timeout = 5;
            log-lines = 25;
            max-jobs = "auto";
            min-free = 128000000;
            max-free = 1000000000;
            fallback = true;
            warn-dirty = true;
            keep-outputs = true;
            keep-derivations = true;
            auto-optimise-store = true;
            builders-use-substitutes = true;
            experimental-features = "flakes nix-command";
            netrc-file = config.age.secrets."netrc".path;

        };

        sshServe = {
            enable = false;
            protocol = "ssh-ng";
            keys = [];
        };

        registry.nixpkgs.flake = inputs.nixpkgs;
        nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
    };
}
