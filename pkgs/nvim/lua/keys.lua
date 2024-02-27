local bind = vim.keymap.set
local remap = { remap = true }

-- Ctrl+S to write in N and I modes
bind("n", "<c-s>", "<cmd>w<cr>")
bind("i", "<c-s>", "<cmd>w<cr>")

-- Ctrl+D to exit in N and I modes
bind("n", "<c-d>", "<cmd>q<cr>")
bind("i", "<c-d>", "<cmd>q<cr>")

-- Ctrl+Z to undo in N and I modes
bind("n", "<c-z>", "<cmd>undo<cr>")
bind("i", "<c-z>", "<cmd>undo<cr>")

-- Ctrl+F to explore files in N and I modes
bind("n", "<c-f>", "<cmd>Lexplore<cr>")
bind("i", "<c-f>", "<cmd>Lexplore<cr>")

-- TODO: add osc yank signal support
-- TODO: use Ctrl+C/V for copy and pasting
-- bind("v", "<c-c>", "y")
-- bind("n", "<c-p>", "p")

-- Ctrl+Up/Down to move lines in N and I
bind("n", "<c-up>", "ddkP")
bind("i", "<c-up>", "<esc>ddkPi")
bind("n", "<c-down>", "ddjP")
bind("i", "<c-down>", "<esc>ddjPi")

-- Traverse buffers with tabs
bind("n", "<tab>", "<cmd>bnext<cr>")
bind("n", "<s-tab>", "<cmd>bprevious<cr>")

-- Send visual selection to terminal buffer
-- bind("n", "ts", "y<c-w>wpa<cr><c-\\><c-n><c-w>p")
-- vim.cmd [[ noremap ts y<C-w>wpa<CR><C-\\><C-n><C-w>p ]]

