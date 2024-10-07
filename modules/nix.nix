{ inputs, pkgs, ... }:

{

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
            # cache.nixos.org is built-in and has priority of 40
            # cache.pear.local is e.g. harmonia and has priority of 20
            # various caches from cachix should be added with ~30 priority
            extra-substituters = [
                "https://cache.garnix.io"
            ];
            extra-trusted-public-keys = [
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
