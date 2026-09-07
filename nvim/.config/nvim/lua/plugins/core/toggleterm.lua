-- ~/.config/nvim/lua/plugins/core/toggleterm.lua

return {
	"akinsho/toggleterm.nvim",
	version = "*",
	config = function()
		require("toggleterm").setup({
			size = function(term)
				if term.direction == "horizontal" then
					return 15
				elseif term.direction == "vertical" then
					return vim.o.columns * 0.4
				end
			end,
			open_mapping = [[<C-\>]],
			hide_numbers = true,
			shade_terminals = true,
			shading_factor = 2,
			start_in_insert = true,
			insert_mappings = true,
			terminal_mappings = true,
			persist_size = true,
			direction = "float",
			close_on_exit = true,
			shell = vim.o.shell,
			float_opts = {
				border = "curved",
				winblend = 3,
			},
		})

		-- Modern Neovim API wrapper for clean autocommands
		local toggleterm_group = vim.api.nvim_create_augroup("ToggleTermKeymaps", { clear = true })

		vim.api.nvim_create_autocmd("TermOpen", {
			pattern = "term://*",
			group = toggleterm_group,
			callback = function()
				local opts = { buffer = 0 }
				-- Smooth window navigation from within terminal insert mode
				vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
				vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]], opts)
				vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]], opts)
				vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]], opts)
				vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]], opts)
				vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
			end,
		})

		-- Create a dedicated Lazygit terminal class instance
		local Terminal = require("toggleterm.terminal").Terminal
		local lazygit = Terminal:new({
			cmd = "lazygit",
			dir = "git_dir",
			direction = "float",
			float_opts = {
				border = "curved",
			},
			-- Hide status line and line numbers for a clean look
			on_open = function(term)
				vim.cmd("startinsert!")
				vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<esc>", "<esc>", { silent = true, noremap = true })
			end,
		})

		-- Global wrapper function so your keybinds file can access it easily
		_G.toggle_lazygit = function()
			lazygit:toggle()
		end
	end,
}
