-- Set leader to comma
vim.keymap.set("n", " ", "<Nop>", { silent = true, remap = false })
vim.g.mapleader = ","

-- Speed up start
vim.loader.enable()

-- Search text as UTF-8,
-- ignore casing unless
-- it's the first letter.
vim.opt.encoding = "utf8"
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Clipboard
vim.cmd [[set clipboard+=unnamedplus]]

-- Set up a colorscheme
vim.opt.termguicolors = true
vim.cmd [[colorscheme lunaperche]]

-- Don't wrap any lines
vim.opt.wrap = false

-- Tabs are 4 spaces, and are
-- converted automatically,
-- and indents carry on
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.autoindent = true

-- Show title as filename
vim.opt.title = true

-- No swap and no backup
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false

-- File explorer using built-in :Lexplore
-- TODO: close buffer after opening file
vim.g.netrw_banner = 0
vim.g.netrw_winsize = 30

-- Grep settings (requires rg at runtime)
vim.opt.grepprg = "rg --vimgrep --follow"
vim.opt.errorformat:append("%f:%l:%c%p%m")

-- For faster responses, but make sure swaps are off
vim.o.updatetime = 300

-- Number column
vim.wo.signcolumn = "number"
vim.opt.relativenumber = true
vim.opt.numberwidth = 1

-- Status line
vim.cmd [[ hi StatusLine guibg=grey guifg=black ]]

-- Completion settings
-- https://neovim.io/doc/user/options.html#'completeopt'
vim.opt.completeopt = {'menu', 'menuone', 'noinsert', 'noselect'}

-- Highlight trailing whitespace
vim.cmd [[ match Todo /\s\+$/ ]]
vim.cmd [[ hi Todo guibg=white ]]

-- Save undo history between sessions
vim.opt.undofile = true
vim.cmd [[ set undodir=$HOME/.config/undo ]]

-- Status line and winbar
-- vim.opt.statusline = "%f %r %y %l,%c %p%%"
-- vim.opt.winbar = "%= %m %f"
-- %{luaeval("print(1)")}
-- #vim.diagnostic.get(0, {severity=vim.diagnostic.severity.ERROR}
-- #vim.lsp.buf.server_ready()
vim.opt.statusline = [[%< %f%m%r %= %l/%L,%c %n]]

-- Keep 8 rows around cursor
vim.opt.scrolloff = 8

-- Remove providers
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0

-- Change color of matched parens
vim.cmd [[ hi MatchParen gui=bold guibg=darkblue guifg=lightblue ]]

