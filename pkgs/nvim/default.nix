{
  lib,
  neovim-unwrapped,
  wrapNeovimUnstable,
  wrapNeovim,
  writeShellApplication,
  neovimUtils,
  vimUtils,
  nodePackages,
  vimPlugins,
  symlinkJoin,
  pyright,
  elixir-ls,
  statix,
  nixd,
  nil,
}:

let

    # self = vimUtils.buildVimPlugin {
    #   name = "nvim-lua-cfg";
    #   src = ./.;
    # };

    runtimeDeps = [
      pyright
      elixir-ls
      nixd
      nil
    ];

    nvimConfig = neovimUtils.makeNeovimConfig {
      withRuby = false;
      withPython3 = false;
      extraPackages = runtimeDeps;

      wrapperArgs = [
        "--prefix"
        "PATH"
        ":"
        "${lib.makeBinPath runtimeDeps}"
      ];

      customRC = ''
        set runtimepath^=${./.}
        source ${./.}/lua/settings.lua
        source ${./.}/lua/keys.lua
        source ${./.}/lua/plugins.lua
        source ${./.}/lua/autos.lua
      '';

      plugins = with vimPlugins; [
        nvim-lspconfig
        nvim-treesitter.withAllGrammars
        nvim-treesitter-context
        nvim-treesitter-refactor
        nvim-treesitter-textobjects
        nvim-treesitter-textsubjects

        leap-nvim
        plenary-nvim
        trouble-nvim
        gitsigns-nvim
        toggleterm-nvim
        telescope-nvim

        harpoon

        nvim-cmp
        cmp-path
        cmp-buffer
        cmp-nvim-lsp
        cmp-rg
        cmp-calc
        cmp-git

        vim-sleuth
        vim-nix
        vim-elixir
        vim-oscyank
        vim-commentary
        vim-fugitive
        vim-surround
        vim-repeat
      ];
    };

    nvim = wrapNeovimUnstable neovim-unwrapped nvimConfig;


in

    # nvim

    symlinkJoin {
      name = "nvim-with-deps";

      # https://ertt.ca/blog/2022/01-12-nix-symlinkJoin-nodePackages/
      # https://discourse.nixos.org/t/symlinkjoin-and-nodepackages/34542
      postBuild = ''
        for f in $out/lib/node_modules/.bin/*; do
          path="$(readlink --canonicalize-missing "$f")"
          ln -s "$path" "$out/bin/$(nasename $f)"
        done
      '';

      paths = [

        (  writeShellApplication {
          name = "pyright-langserver";
          runtimeInputs = [ pyright ];
          text = "pyright-langserver";
        } )

        nvim
        pyright
        nodePackages.pyright
        nixd
        nil
      ];
    }
