-- Telescope
require("telescope").setup({
	defaults = {
		layout_strategy = "vertical",
		layout_config = {
			height = 0.9,
			width = 0.9,
		},
	},
})
local tb = require("telescope.builtin")
vim.keymap.set("n", "ff", tb.find_files, {})
vim.keymap.set("n", "fg", tb.live_grep, {})
vim.keymap.set("n", "fs", tb.grep_string, {})
vim.keymap.set("n", "fb", tb.buffers, {})
vim.keymap.set("n", "fr", tb.registers, {})
vim.keymap.set("n", "fo", tb.oldfiles, {})

-- Harpoon
require("harpoon").setup({
	save_on_toggle = true,
})
local mark = require("harpoon.mark")
local ui = require("harpoon.ui")
vim.keymap.set("n", "<leader>a", function()
	mark.add_file()
end)
vim.keymap.set("n", "<leader><leader>", function()
	ui.toggle_quick_menu()
end)
vim.keymap.set("n", "<leader>1", function()
	ui.nav_file(1)
end)
vim.keymap.set("n", "<leader>2", function()
	ui.nav_file(2)
end)
vim.keymap.set("n", "<leader>3", function()
	ui.nav_file(3)
end)
vim.keymap.set("n", "<leader>4", function()
	ui.nav_file(4)
end)

-- Treesitter base
require("nvim-treesitter.configs").setup({
	auto_install = false,

	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "<cr>",
			node_incremental = "<cr>",
			node_decremental = "<bs>",
		},
	},
	highlight = {
		enable = true,
	},
	indent = {
		enable = true,
	},
})

-- -- Treesitter textsubjects
-- require("nvim-treesitter.configs").setup({
-- 	textsubjects = {
-- 		enable = true,
-- 		prev_selection = ",", -- (Optional) keymap to select the previous selection
-- 		keymaps = {
-- 			["."] = "textsubjects-smart",
-- 			[";"] = "textsubjects-container-outer",
-- 			["i;"] = "textsubjects-container-inner",
-- 		},
-- 	},
-- })

-- -- Treesitter textobjects
-- require("nvim-treesitter.configs").setup({
-- 	textobjects = {
-- 		select = {
-- 			enable = true,
-- 			lookahead = true,
-- 			keymaps = {
-- 				-- textobjects.scm
-- 				["af"] = "@function.outer",
-- 				["if"] = "@function.inner",
-- 				["ac"] = "@class.outer",
-- 				["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
-- 				["as"] = { query = "@scope", query_group = "locals", desc = "Select language scope" },
-- 			},
-- 			selection_modes = {
-- 				["@parameter.outer"] = "v", -- charwise
-- 				["@function.outer"] = "V", -- linewise
-- 				["@class.outer"] = "<c-v>", -- blockwise
-- 			},
-- 			include_surrounding_whitespace = false,
-- 		},
-- 	},
-- })

-- -- Treesitter context
-- require("treesitter-context").setup({
-- 	enable = true,
-- 	max_lines = 5,
-- 	min_window_height = 0,
-- 	line_numbers = true,
-- 	multiline_threshold = 5,
-- 	trim_scope = "outer",
-- 	mode = "cursor",
-- 	separator = nil,
-- 	zindex = 20,
-- 	on_attach = nil,
-- })

-- -- Treesitter refactor
-- require("nvim-treesitter.configs").setup({
-- 	refactor = {
-- 		navigation = {
-- 			enable = true,
-- 			keymaps = {
-- 				goto_definition = "gnd",
-- 				list_definitions = "gnD",
-- 				list_definitions_toc = "gO",
-- 				goto_next_usage = "<a-*>",
-- 				goto_previous_usage = "<a-#>",
-- 			},
-- 		},
-- 	},
-- 	highlight_current_scope = { enable = true },
-- 	highlight_definitions = {
-- 		enable = true,
-- 		-- Set to false if you have an `updatetime` of ~100.
-- 		clear_on_cursor_move = true,
-- 	},
-- })

-- Git gutter
require("gitsigns").setup({
	signcolumn = false,
	numhl = true,
})

-- TODO: add undo manager (undotree?)

-- Terminal
require("toggleterm").setup({
	open_mapping = "<c-t>",
	insert_mappings = true,
	terminal_mappings = true,
	direction = "horizontal",
	shade_terminals = false,
})
vim.keymap.set("v", "t", function()
	require("toggleterm").send_lines_to_terminal("visual_lines", true, { args = vim.v.count })
end)
vim.keymap.set("n", "tt", function()
	require("toggleterm").send_lines_to_terminal("single_line", true, { args = vim.v.count })
end)

-- Leap
-- require("leap").add_default_mappings()
require("leap").setup({
	safe_labels = {},
})
vim.keymap.set("n", "s", function()
	local current_window = vim.fn.win_getid()
	require("leap").leap({ target_windows = { current_window } })
end)

-- LSP configs
require("lspconfig")

local lsps = {
	{ "ruff" },
	-- { "nil_ls" },
	{ "statix" },
	{ "nixd" },
	{ "rust_analyzer" },
	{ "cssls" },
	{ "lua_ls" },
	{
		"clangd",
		{
			init_options = {
				fallbackFlags = { "--std=c23" },
			},
		},
	},
}

for _, lsp in pairs(lsps) do
	local name, config = lsp[1], lsp[2]
	vim.lsp.enable(name)
	if config then
		vim.lsp.config(name, config)
	end
end

-- Blink
require("blink.cmp").setup({
	keymap = { preset = "super-tab" },
	appearance = {
		nerd_font_variant = "mono",
	},
	completion = {
		documentation = { auto_show = false, auto_show_delay_ms = 500 },
		ghost_text = { enabled = true },
		menu = {
			draw = {
				padding = { 0, 1 },
				components = {
					kind_icon = {
						text = function(ctx)
							return ctx.kind:sub(1, 1)
						end,
					},
				},
			},
		},
	},
	sources = {
		default = { "lsp", "path", "snippets", "buffer" },
	},
	fuzzy = { implementation = "prefer_rust_with_warning" },
})

-- Snippets

-- -- Conform
-- require("conform").setup({
-- 	formatters_by_ft = {
-- 		lua = { "stylua" },
-- 		python = { "black" },
-- 		rust = { "rustfmt" },
-- 		-- javascript = { "biome format" },
-- 	},
-- })
-- require("conform").setup({
-- 	format_on_save = {
-- 		timeout_ms = 500,
-- 		lsp_format = "fallback",
-- 	},
-- })

-- Remove "virtual text" and make floating info smaller
vim.diagnostic.config({
	virtual_text = false,
	severity_sort = true,
	float = {
		source = false,
		header = "",
		prefix = "",
	},
})

-- Lean
require("lean").setup({
	mappings = true,
})

-- Actions preview
require("actions-preview").setup({})
vim.keymap.set({ "v", "n" }, "gf", require("actions-preview").code_actions)

-- Goto preview
require("goto-preview").setup({
	default_mappings = true,
})

-- Ollama
-- require("ollama").setup({
-- 	model = "llama3.1",
-- 	url = "http://ollama.pear.local",
-- })
-- vim.keymap.set({ "v", "n" }, "op", ":<c-u>lua require('ollama').prompt()<cr>")
-- vim.keymap.set({ "v", "n" }, "og", ":<c-u>lua require('ollama').prompt('Generate_Code')<cr>")

-- -- Neogit
-- require("neogit").setup({})
-- vim.keymap.set({ "n" }, "<c-n>", ":Neogit<cr>")
