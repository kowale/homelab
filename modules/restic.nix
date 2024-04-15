{ config, pkgs, ... }:

# https://www.arthurkoziel.com/restic-backups-b2-nixos/
# restic -r /tmp/repo init && restic -r /tmp/repo backup <(echo hi)

{
  services.restic.backups = {
    testing = {
      initialize = true;
      # environmentFile = "";
      # passwordFile = "";
      # repositoryFile = "/tmp/repo";
      repository = "/tmp/repo";
      paths = [
        "/tmp/data"
      ];
      pruneOpts = [
        "--keep-daily 7"
        "--keep-weekly 5"
        "--keep-monthly 12"
      ];
    };
  };
}

