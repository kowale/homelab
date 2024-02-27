-- Highlight text on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    desc="Highlight text on yank",
    callback=function(event)
        vim.highlight.on_yank({higroup="Todo", timeout=100})
    end
})

-- Configure keybindings for LSP
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function()
    local bufmap = function(mode, lhs, rhs)
      local opts = {buffer = true}
      vim.keymap.set(mode, lhs, rhs, opts)
    end

    -- Displays hover information about the symbol under the cursor
    bufmap('n', 'K', vim.lsp.buf.hover)

    -- Jump to the definition
    bufmap('n', 'gd', vim.lsp.buf.definition)

    -- Jump to declaration
    bufmap('n', 'gD', vim.lsp.buf.declaration)

    -- Lists all the implementations for the symbol under the cursor
    bufmap('n', 'gi', vim.lsp.buf.implementation)

    -- Jumps to the definition of the type symbol
    bufmap('n', 'go', vim.lsp.buf.type_definition)

    -- Format code
    bufmap('n', '<F3>', vim.lsp.buf.format)
    bufmap('x', '<F3>', vim.lsp.buf.format)

    bufmap('n', 'gr', vim.lsp.buf.references)
    bufmap('n', 'gR', vim.lsp.buf.rename)

    -- Displays a function's signature information
    bufmap('n', '<C-k>', vim.lsp.buf.signature_help)

    -- Selects a code action available at the current cursor position
    bufmap('n', '<F4>', vim.lsp.buf.code_action)
    bufmap('x', '<F4>', vim.lsp.buf.code_action)

    -- Show diagnostics in a floating window
    bufmap('n', 'gl', vim.diagnostic.open_float)

    -- Move to the previous diagnostic
    bufmap('n', '[d', vim.diagnostic.goto_prev)

    -- Move to the next diagnostic
    bufmap('n', ']d', vim.diagnostic.goto_next)
  end
})

