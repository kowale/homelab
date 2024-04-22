{ config, pkgs, ... }:

  # https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
  # https://github.com/ohmyzsh/ohmyzsh/wiki/Plugins

{

  environment.shellAliases = {
      ll = "ls -lah";
      v = "nvim";
      p = "python -q";
      cat = "bat --plain -P";
      gl = "git lo";
      gs = "git st";
      ga = "git add -A";
      gd = "git diff";
      ff = "firefox";
      cd = "z";
      sw = "sudo nixos-rebuild switch --flake .#$(hostname) -vv";
    };

  environment.systemPackages = with pkgs; [
    zoxide
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
        dir="/home/kon/notes/$(date -d today '+%Y/%m')"
        file="/home/kon/notes/$(date -d today '+%Y/%m/%d.md')"
        mkdir -p $dir
        [ -f $file ] || { echo "# $(date -d today '+%Y-%m-%d')\n\n" > $file }
        nvim -c "normal G" -- $file
    }

    f() {
        file=$(
            fzf -m \
            --bind ctrl-a:select-all,ctrl-d:deselect-all,ctrl-t:toggle-all \
            --print0 \
            --preview 'bat --theme Dracula --color=always {}'
        ) || return
        nvim -- $file
    }

    '';
    ohMyZsh = {
        enable = true;
        theme = "fishy";
        plugins = [
          "timer"
          "zoxide"
        ];
        customPkgs = with pkgs; [
          nix-zsh-completions
          zsh-nix-shell
          zsh-git-prompt
          zsh-fast-syntax-highlighting
          zsh-system-clipboard
        ];
    };
  };
}
