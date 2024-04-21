{ config, pkgs, ... }:

# https://blog.gitbutler.com/fosdem-git-talk/

let

    keys = import ../secrets/keys.nix;

    base = {
      init.defaultBranch = "main";
      log.date = "iso";
      pull.rebase = true;
      push.autoSetupRemote = true;
      rebase.autosquash = true;
      rebase.autostash = true;
      rerere.enabled = true;
      colum.ui = "auto";
      branch.sort = "-committerdate";
      fetch.writeCommitGraph = true;
      core.untrackedcache = true;
      core.fsmonitor = true;
      advice.addEmptyPathspec = false;
      core.pager = "cat";
    };

    alias.alias = {
      cb = "symbolic-ref --short HEAD";
      bl = "blame -w -C -C -C";
      pu = "push --signed --force-if-includes --force-with-lease";
      co = "commit -S -a -m";
      st = "status --short";
      di = "diff --staged";
      lo = "log --oneline -10";
      ad = "add -p";
      cl = "clone --filter=tree:0";
    };

    user = {
      user.name = "Konstanty Kowalewski";
      user.email = "konstanty@kszk.eu";
      # gpg.format = "ssh";
      # user.signingKey = keys.kon;
    };

in {
  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    config = [ base alias user ];
  };
}

