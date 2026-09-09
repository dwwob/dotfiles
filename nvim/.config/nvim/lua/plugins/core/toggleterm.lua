-- ~/.config/nvim/lua/plugins/core/toggleterm.lua

return {
	"akinsho/toggleterm.nvim",
	version = "*",
	keys = {
		{ "<C-\\>", "<cmd>ToggleTerm direction=float<cr>", desc = "Toggle Floating Shell" },
	},
	-- 🚀 'init' executes immediately on startup so all user commands are registered instantly!
	init = function()
		local live_preview_group = vim.api.nvim_create_augroup("HtmlLivePreview", { clear = true })
		local server_job_id = nil

		-- =========================================================================
		-- ⚙️ REALTIME HTML PREVIEW FUNCTIONS (KDE PLASMA INTEGRATED)
		-- =========================================================================
		local function start_live_server()
			if server_job_id then
				vim.notify("🌐 Live Server is already running!", vim.log.levels.WARN)
				return
			end

			local target_dir = vim.fn.expand("%:p:h")
			local target_file = vim.fn.expand("%:t")

			-- Uses --no-open to skip headless execution failures inside background jobs
			local cmd = string.format(
				"browser-sync start --server --no-open --files '%s/*' --startPath '%s'",
				target_dir,
				target_file
			)

			-- Load plugin safely and send execution task to isolated Term ID lane 99
			require("lazy").load({ plugins = { "toggleterm.nvim" } })
			require("toggleterm").exec(cmd, 99, nil, target_dir, "horizontal")
			vim.cmd("99ToggleTerm") -- Instantly close the background flash split window drawer
			server_job_id = 99

			-- 🚀 FIX: Introduce a non-blocking delay to let the server start up completely
			vim.defer_fn(function()
				local local_url = "http://localhost:3000/" .. target_file

				-- 1. Open your default web browser smoothly using system layer paths
				vim.fn.jobstart({ "xdg-open", local_url }, { detach = true })

				-- 2. Fetch your system's active KDE Plasma D-Bus command controller binary
				local dbus_cmd = vim.fn.executable("qdbus6") == 1 and "qdbus6" or "qdbus"

				-- 3. Ask Yakuake to slide back up to the ceiling so Firefox is revealed in focus!
				vim.fn.jobstart(
					{ dbus_cmd, "org.kde.yakuake", "/yakuake/window", "toggleWindowState" },
					{ detach = true }
				)

				vim.notify("🌐 Live Preview Server active at " .. local_url, vim.log.levels.INFO)
			end, 1000) -- Delays execution window by exactly 1000 milliseconds (1 second)

			-- Realtime Refresh Hook: Forces browser updates instantly on file save
			vim.api.nvim_create_autocmd("BufWritePost", {
				group = live_preview_group,
				pattern = { "*.html", "*.css", "*.js" },
				callback = function()
					require("toggleterm").exec("browser-sync reload", 99)
					vim.cmd("99ToggleTerm") -- Retain clean viewport view bounds
				end,
			})
		end

		local function stop_live_server()
			if not server_job_id then
				vim.notify("🌐 No live server currently active.", vim.log.levels.WARN)
				return
			end

			-- Clear the save-monitoring event loops completely
			vim.api.nvim_clear_autocmds({ group = live_preview_group })

			-- Kill the terminal task thread running browser-sync
			vim.cmd("99ToggleTerm")
			vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<C-c>", true, false, true), "n", false)
			vim.cmd("bdelete!")

			server_job_id = nil
			vim.notify("🌐 Live Preview Server stopped safely.", vim.log.levels.INFO)
		end

		-- Expose these clean user operations directly to your Neovim command bar
		vim.api.nvim_create_user_command("LivePreview", start_live_server, {})
		vim.api.nvim_create_user_command("LivePreviewStop", stop_live_server, {})
	end,
	opts = {
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
		start_in_insert = true,
		insert_mappings = true,
		terminal_mappings = true,
		persist_size = true,
		direction = "float",
		close_on_exit = true,
		shell = vim.o.shell,
		float_opts = {
			border = "curved",
			winblend = 0,
		},
	},
	config = function(_, opts)
		-- Initialize ToggleTerm with user configurations
		require("toggleterm").setup(opts)

		-- =========================================================================
		-- 📊 YOUR ORIGINAL LAZYGIT CLASS INSTANCE & GLOBAL WRAPPER
		-- =========================================================================
		local Terminal = require("toggleterm.terminal").Terminal
		local lazygit = Terminal:new({
			cmd = "lazygit",
			dir = "git_dir",
			direction = "float",
			float_opts = {
				border = "curved",
			},
			on_open = function(term)
				vim.cmd("startinsert!")
				vim.api.nvim_buf_set_keymap(term.bufnr, "t", "<esc>", "<esc>", { silent = true, noremap = true })
			end,
		})

		_G.toggle_lazygit = function()
			lazygit:toggle()
		end
	end,
}
