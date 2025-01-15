{ config, pkgs, ... }:

let

  ip-info = pkgs.writeScriptBin "ip-info" ''
    ip -j a | jq '.[].addr_info.[].local' -r
  '';

in {

  environment.variables = {
    TERM = "linux";
    EDITOR = "nvim";
  };

  environment.shellAliases = {
      ll = "ls -lah";
      v = "nvim";
      p = "python -q";
      t = "tmux new -A -s $1";
      cat = "bat --plain -P";
      gl = "git lo";
      gs = "git st";
      ga = "git add -A";
      gd = "git diff";
      ff = "firefox";
      c = "z";
      sw = "sudo nixos-rebuild switch --flake .#$(hostname) -vv";
    };

  environment.systemPackages = with pkgs; [
    ip-info
  ];

  users.defaultUserShell = pkgs.zsh;
  environment.shells = [ pkgs.zsh ];

  programs.zsh = {
    enable = true;
    histSize = 100000;
    setOptions = [
      "CORRECT"
      "NO_BEEP"
      "NOTIFY"
      "INC_APPEND_HISTORY_TIME"
      "HIST_VERIFY"
      "HIST_IGNORE_DUPS"
      "EXTENDED_HISTORY"
      "RM_STAR_WAIT"

    ];
    shellInit = ''

      TIMER_FORMAT='%d'

      n() {
          root="/home/kon/notes"
          dir="$root/$(date -d today '+%Y/%m')"
          file="$root/$(date -d today '+%Y/%m/%d.md')"
          mkdir -p $dir
          [ -f $file ] || { echo "# $(date -d today '+%Y-%m-%d')\n\n" > $file }
          nvim -c "normal G" -- $file
      }

    '';

    ohMyZsh = {
        enable = true;
        theme = "fishy";
        # plugins = [
        #   "timer"
        # ];
        # customPkgs = with pkgs; [
        #   nix-zsh-completions
        #   zsh-nix-shell
        #   zsh-git-prompt
        #   zsh-fast-syntax-highlighting
        #   zsh-system-clipboard
        # ];
    };
  };
}
