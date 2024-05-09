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
            # https://jackson.dev/post/nix-reasonable-defaults/
            trusted-users = [ "@wheel" ];
            system-features = [ "kvm" ];
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
