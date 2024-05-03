{
  lib,
  neovim-unwrapped,
  wrapNeovimUnstable,
  wrapNeovim,
  neovimUtils,
  vimUtils,
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
      paths = [
        nvim

        # TODO: https://discourse.nixos.org/t/symlinkjoin-and-nodepackages/34542
        # (  writeShellApplication {
        #   name = "pyright-langserver";
        #   runtimeInputs = [ pyright ];
        #   text = "pyright-langserver";
        # } )

        pyright
        elixir-ls
        nixd
        nil
      ];
    }
