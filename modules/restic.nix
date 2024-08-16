{ config, pkgs, ... }:

# restic -r /tmp/repo init
# restic -r /tmp/repo backup <(echo hi)
# https://www.arthurkoziel.com/restic-backups-b2-nixos/

{
  age.secrets = {
    "restic/env".file = ../secrets/restic/env.age;
    "restic/repo".file = ../secrets/restic/repo.age;
    "restic/password".file = ../secrets/restic/password.age;
  };

  services.restic.backups = {
    daily = {
      initialize = true;

      environmentFile = config.age.secrets."restic/env".path;
      repositoryFile = config.age.secrets."restic/repo".path;
      passwordFile = config.age.secrets."restic/password".path;

      paths = [
        "/home/kon/notes"
        "/home/kon/other/persist"
      ];

      exclude = [
        "/home/**/.cache"
        "/home/**/.venv"
      ];

      pruneOpts = [
        "--keep-daily 7"
        "--keep-weekly 5"
        "--keep-monthly 12"
      ];

    };
  };
}

