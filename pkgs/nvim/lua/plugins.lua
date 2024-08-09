-- Telescope
require('telescope').setup {
    defaults = {
        layout_strategy = 'vertical',
        layout_config = {
            height = 0.9,
            width = 0.9,

        },
    }
}
local tb = require('telescope.builtin')
vim.keymap.set('n', 'ff', tb.find_files, {})
vim.keymap.set('n', 'fg', tb.live_grep, {})
vim.keymap.set('n', 'fs', tb.grep_string, {})
vim.keymap.set('n', 'fb', tb.buffers, {})
vim.keymap.set('n', 'fr', tb.registers, {})
vim.keymap.set('n', 'fo', tb.oldfiles, {})

-- Harpoon
require'harpoon'.setup {
    save_on_toggle = true,
}
local mark = require'harpoon.mark'
local ui = require'harpoon.ui'
vim.keymap.set("n", "<leader>a", function() mark.add_file() end)
vim.keymap.set("n", "<leader><leader>", function() ui.toggle_quick_menu() end)
vim.keymap.set("n", "<leader>1", function() ui.nav_file(1) end)
vim.keymap.set("n", "<leader>2", function() ui.nav_file(2) end)
vim.keymap.set("n", "<leader>3", function() ui.nav_file(3) end)
vim.keymap.set("n", "<leader>4", function() ui.nav_file(4) end)

-- Treesitter base
require("nvim-treesitter.configs").setup {
    auto_install = false,

    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = "<cr>",
            node_incremental = "<cr>",
            node_decremental = "<bs>"
        },
    },
    highlight = {
        enable = true
    },
    indent = {
        enable = true
    },
}

-- Treesitter textsubjects
require('nvim-treesitter.configs').setup {
    textsubjects = {
        enable = true,
        prev_selection = ',', -- (Optional) keymap to select the previous selection
        keymaps = {
            ['.'] = 'textsubjects-smart',
            [';'] = 'textsubjects-container-outer',
            ['i;'] = 'textsubjects-container-inner',
        },
    },
}

-- Treesitter textobjects
require'nvim-treesitter.configs'.setup {
  textobjects = {
    select = {
      enable = true,
      lookahead = true,
      keymaps = {
        -- textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
        ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
      },
      selection_modes = {
        ['@parameter.outer'] = 'v', -- charwise
        ['@function.outer'] = 'V', -- linewise
        ['@class.outer'] = '<c-v>', -- blockwise
      },
      include_surrounding_whitespace = false,
    },
  },
}

-- Treesitter context
require'treesitter-context'.setup{
  enable = true,
  max_lines = 5,
  min_window_height = 0,
  line_numbers = true,
  multiline_threshold = 5,
  trim_scope = 'outer',
  mode = 'cursor',
  separator = nil,
  zindex = 20,
  on_attach = nil,
}

-- Treesitter refactor
require'nvim-treesitter.configs'.setup {
  refactor = {
      navigation = {
        enable = true,
        keymaps = {
          goto_definition = "gnd",
          list_definitions = "gnD",
          list_definitions_toc = "gO",
          goto_next_usage = "<a-*>",
          goto_previous_usage = "<a-#>",
        },
      },
    },
    highlight_current_scope = { enable = true },
    highlight_definitions = {
      enable = true,
      -- Set to false if you have an `updatetime` of ~100.
      clear_on_cursor_move = true,
    },
  }

-- Git gutter
require('gitsigns').setup {
    signcolumn = false,
    numhl = true,
}

-- TODO: add support for pre-commit-hooks.nix
-- -- LSP from non-LSP sources
-- local null_ls = require("null-ls")
-- null_ls.setup {
--     sources = {
--         null_ls.builtins.formatting.black,
--         null_ls.builtins.formatting.ruff,
--         null_ls.builtins.diagnostics.ruff,
--     }
-- }

-- TODO: add snippet manager (luasnip + cmp_luasnip?)
-- TODO: add undo manager (undotree?)

-- Terminal
require("toggleterm").setup {
  open_mapping = "<c-t>",
  insert_mappings = true,
  terminal_mappings = true,
  direction = "horizontal",
  shade_terminals = false,
}
vim.keymap.set("v", "t", function()
    require("toggleterm").send_lines_to_terminal("visual_lines", true, { args = vim.v.count })
end)
vim.keymap.set("n", "tt", function()
    require("toggleterm").send_lines_to_terminal("single_line", true, { args = vim.v.count })
end)

-- Trouble
require("trouble").setup {
    mode = "document_diagnostics",
    icons = false,
    fold_open = "v",
    fold_closed = ">",
    indent_lines = false,
    padding = false,
    group = false,
    use_diagnostic_signs = false,
    signs = {
        error = "E",
        warning = "W",
        hint = "H",
        information = "I",
        other = "?",
    },
}
vim.keymap.set("n", "<s-t>", "<cmd>TroubleToggle<cr>")

-- Leap
-- require("leap").add_default_mappings()
require("leap").setup {
    safe_labels = {}
}
vim.keymap.set("n", "s", function ()
  local current_window = vim.fn.win_getid()
  require('leap').leap { target_windows = { current_window } }
end)

-- LSP configs
-- <https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md>

-- Python

require'lspconfig'.ruff.setup {}
-- require'lspconfig'.pyright.setup {
    -- analysis = {
    --     autoSearchPaths = true,
    --     useLibraryCodeForTypes = true,
    -- }
-- }

-- Nix
-- require'lspconfig'.statix.setup {}
require'lspconfig'.nixd.setup {}
require'lspconfig'.nil_ls.setup {}
require'lspconfig'.statix.setup {}

-- Elixir
-- require'lspconfig'.elixirls.setup {
--     cmd = { "elixir-ls" }
-- }

-- Lua
-- require'lspconfig'.lua_ls.setup {}

-- JS
require'lspconfig'.biome.setup{}

-- Uiua
require'lspconfig'.uiua.setup{}

-- Gleam
require'lspconfig'.gleam.setup{}

-- Writing
-- TODO: try textlsp, vale-ls, prosemd-lsp
-- marksman doesn't handle ref links
-- ltex is way too heavy for me

-- Completions
local cmp = require'cmp'
local select_opts = { behavior = cmp.SelectBehavior.Select }
cmp.setup {
  sources = {
    { name = 'nvim_lsp', keyword_length = 3 },
    { name = 'buffer', keyword_length = 3 },
    { name = 'path', keyword_length = 2 },
    { name = 'git', keyword_length = 3 },
    -- { name = 'rg', keyword_length = 3 },
    -- { name = 'calc', keyword_length = 3 },
  },

  formatting = {
    fields = {'menu', 'abbr', 'kind'},
    format = function(entry, item)
      item.menu = ({
        nvim_lsp = 'L',
        buffer = 'B',
        path = 'P',
        git = 'G',
        -- rg = 'R',
        -- calc = 'C',
      })[entry.source.name]
      return item
    end
  },

  mapping = {
    ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
    ['<Down>'] = cmp.mapping.select_next_item(select_opts),
    ['<CR>'] = cmp.mapping.confirm({
        select = false,
        --select = true,
        behavior = cmp.ConfirmBehavior.Replace
    }),

    ['<Tab>'] = cmp.mapping(function(fallback)
      local col = vim.fn.col('.') - 1

      if cmp.visible() then
        cmp.select_next_item(select_opts)
      elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
        fallback()
      else
        cmp.complete()
      end
    end, {'i', 's'}),

    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item(select_opts)
      else
        fallback()
      end
    end, {'i', 's'}),
  },

}

-- Remove "virtual text" and make floating info smaller
vim.diagnostic.config({
  virtual_text = false,
  severity_sort = true,
  float = {
    source = false,
    header = '',
    prefix = '',
  },
})


-- Lean
require('lean').setup {
    mappings = true
}

-- Actions preview
require("actions-preview").setup {}
vim.keymap.set({ "v", "n" }, "gf", require("actions-preview").code_actions)

-- Goto preview
require('goto-preview').setup {
    default_mappings = true
}

-- Ollama
require("ollama").setup {
    model = "llama3.1",
    url = "http://ollama.pear.local",
}
vim.keymap.set({ "v", "n" }, "op", ":<c-u>lua require('ollama').prompt()<cr>")
vim.keymap.set({ "v", "n" }, "og", ":<c-u>lua require('ollama').prompt('Generate_Code')<cr>")

