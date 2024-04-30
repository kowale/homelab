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

-- Colorscheme
-- vim.opt.background = 'dark'
-- vim.g.colors_name = 'hehe'
-- local lush = require('lush')
-- local hsl = lush.hsl
-- local spec = function() {
--     Normal { bg = hsl(0, 10, 10), fg = hsl(0, 10, 10) },
--     Whitespace { fg = Normal.fg.darken(40) },
--     Comment { Whitespace, gui="italic" },
--     CursorLine { },
-- }
-- end
-- lush(spec)
-- vim.cmd[[colorscheme hehe]]

require'treesitter-context'.setup{
  enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
  max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
  min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
  line_numbers = true,
  multiline_threshold = 20, -- Maximum number of lines to show for a single context
  trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
  mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
  -- Separator between context and content. Should be a single character string, like '-'.
  -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
  separator = nil,
  zindex = 20, -- The Z-index of the context window
  on_attach = nil, -- (fun(buf: integer): boolean) return false to disable attaching
}

require'nvim-treesitter.configs'.setup {
  textobjects = {
    select = {
      enable = true,

      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,

      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        -- You can optionally set descriptions to the mappings (used in the desc parameter of
        -- nvim_buf_set_keymap) which plugins like which-key display
        ["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
        -- You can also use captures from other query groups like `locals.scm`
        ["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
      },
      -- You can choose the select mode (default is charwise 'v')
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg '@function.inner'
      -- * method: eg 'v' or 'o'
      -- and should return the mode ('v', 'V', or '<c-v>') or a table
      -- mapping query_strings to modes.
      selection_modes = {
        ['@parameter.outer'] = 'v', -- charwise
        ['@function.outer'] = 'V', -- linewise
        ['@class.outer'] = '<c-v>', -- blockwise
      },
      -- If you set this to `true` (default is `false`) then any textobject is
      -- extended to include preceding or succeeding whitespace. Succeeding
      -- whitespace has priority in order to act similarly to eg the built-in
      -- `ap`.
      --
      -- Can also be a function which gets passed a table with the keys
      -- * query_string: eg '@function.inner'
      -- * selection_mode: eg 'v'
      -- and should return true or false
      include_surrounding_whitespace = true,
    },
  },
}

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
  direction = "horizontal",
  shade_terminals = true
}

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
require("leap").add_default_mappings()
require("leap").setup {
    safe_labels = {}
}
vim.keymap.set("n", "<c-_>", function ()
  local current_window = vim.fn.win_getid()
  require('leap').leap { target_windows = { current_window } }
end)

-- Treesitter
-- TODO: add textsubjects and textobjects
require("nvim-treesitter.configs").setup {
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

-- Language server protocol (LSP)
-- TODO: consider writing these myself
local lspconfig = require('lspconfig')
lspconfig.pyright.setup({})

-- Completions
local cmp = require('cmp')
local select_opts = { behavior = cmp.SelectBehavior.Select }

cmp.setup({
  sources = {
    { name = 'nvim_lsp', keyword_length = 3 },
    { name = 'buffer', keyword_length = 3 },
    { name = 'path', keyword_length = 2 },
    { name = 'rg', keyword_length = 3 },
    { name = 'calc', keyword_length = 3 },
  },
  formatting = {
    fields = {'menu', 'abbr', 'kind'},
    format = function(entry, item)
      item.menu = ({
        nvim_lsp = 'L',
        buffer = 'B',
        path = 'P',
        rg = 'R',
        calc = 'C',
      })[entry.source.name]
      return item
    end
  },
  mapping = {
    ['<Up>'] = cmp.mapping.select_prev_item(select_opts),
    ['<Down>'] = cmp.mapping.select_next_item(select_opts),
    ['<CR>'] = cmp.mapping.confirm({
        --select = false,
        select = true,
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
})

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

