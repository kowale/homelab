{
  lib,
  neovim-unwrapped,
  wrapNeovimUnstable,
  wrapNeovim,
  writeShellApplication,
  neovimUtils,
  vimUtils,
  vimPlugins,
  symlinkJoin,
  elixir-ls,
  nixd,
  nil,
  statix,
  ruff,
  uiua,
  gleam,
  biome,
  black,
  stylua,
  nerd-fonts,
  clang-tools,
  vscode-css-languageserver
}:

let

    # self = vimUtils.buildVimPlugin {
    #   name = "nvim-lua-cfg";
    #   src = ./.;
    # };

    runtimeDeps = [
      elixir-ls
      nixd
      nil
      statix
      ruff
      uiua
      gleam
      biome
      black
      stylua
      nerd-fonts.fira-code
      nerd-fonts.droid-sans-mono
      clang-tools
      vscode-css-languageserver
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
        # nvim-lspconfig
        nvim-treesitter.withAllGrammars
        nvim-treesitter-context
        nvim-treesitter-refactor
        nvim-treesitter-textobjects
        nvim-treesitter-textsubjects
        nvim-cmp

        leap-nvim
        plenary-nvim
        trouble-nvim
        gitsigns-nvim
        toggleterm-nvim
        telescope-nvim
        lean-nvim
        actions-preview-nvim
        ollama-nvim

        harpoon
        goto-preview

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

        neogit
        blink-cmp
        conform-nvim

      ];
    };

    nvim = wrapNeovimUnstable neovim-unwrapped nvimConfig;


in

    symlinkJoin {
      name = "nvim-with-deps";
      paths = [ nvim ] ++ runtimeDeps;
    }
