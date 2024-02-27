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

