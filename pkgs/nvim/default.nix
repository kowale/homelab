{ neovim, vimUtils, vimPlugins }:

let
    self = vimUtils.buildVimPlugin {
        name = "nvim-lua-cfg";
        src = ./.;
    };

    nvim = neovim.override {
        configure = {
            customRC = ''
                lua << EOF
                    require("settings")
                    require("keys")
                    require("plugins")
                    require("autos")
                EOF
            '';
            packages.plugins = with vimPlugins; {
                opt = [];
                start = [

                    nvim-lspconfig
                    nvim-treesitter.withAllGrammars

                    leap-nvim
                    plenary-nvim
                    trouble-nvim
                    gitsigns-nvim
                    toggleterm-nvim
                    telescope-nvim
                    nvim-treesitter-context
                    nvim-treesitter-refactor
                    nvim-treesitter-textobjects

                    nvim-cmp
                    cmp-path
                    cmp-buffer
                    cmp-nvim-lsp
                    cmp-rg
                    cmp-calc

                    vim-nix
                    vim-oscyank
                    vim-commentary
                    vim-fugitive
                    vim-surround
                    vim-repeat

                    self
                ];
            };
        };
    };

in
    nvim
    #pkgs.mkShell { buildInputs = [ nvim ]; }
