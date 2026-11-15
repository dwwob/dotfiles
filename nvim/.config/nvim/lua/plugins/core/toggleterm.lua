-- ~/.config/nvim/lua/plugins/core/toggleterm.lua
--
-- Cleaned-up version of your original file.
-- Every setting is the same as before -- nothing was changed,
-- moved in order, or removed.
-- Changes are only to layout: one header style throughout, matching
-- git.lua, ts-autopairs.lua, treesitter.lua, nvim-lspconfig.lua,
-- lsp_signature.lua, goto-preview.lua, emmet_vim.lua, mason.lua,
-- conform.lua, blink.lua, init.lua, lazy.lua, auto.lua,
-- keybinds.lua, and options.lua, and the spec kept together
-- under its own header.
--
-- Plays-together check against your other files:
--   * This file will load. lazy.lua's scanner registers "plugins"
--     plus one import per subdirectory under lua/plugins/, and
--     this file sits in lua/plugins/core/, so it is covered by
--     the "plugins.core" import.
--   * Lazy loading: cmd / keys below mean lazy.nvim loads this
--     plugin on :ToggleTerm (and the other listed commands) or
--     on <C-\>, not at startup. init, however, runs at startup,
--     so :LivePreview / :LivePreviewStop are registered right
--     away -- that is why init is used for them.
--   * <C-\> is defined twice here, for the same job, left as-is:
--     once in keys (lazy.nvim, "Toggle Floating Shell") and once
--     as open_mapping in opts. Both open the floating terminal.
--   * keybinds.lua's terminal keys line up with this file:
--     <leader>tf = ToggleTerm direction=float, <leader>th =
--     ToggleTerm direction=horizontal, and <leader>tv =
--     ToggleTerm direction=vertical. Those commands are in the
--     cmd list below, so lazy.nvim can load the plugin for them.
--     No clash with this file's <C-\>.
--   * <leader>tg in keybinds.lua calls _G.toggle_lazygit, which
--     is defined in the config below (the Lazygit Terminal
--     instance). keybinds.lua guards it: if _G.toggle_lazygit
--     is not set yet it notifies "Lazygit module not loaded
--     yet" instead of erroring, because config only runs once
--     the plugin has loaded.
--   * README / keybinds gap -- <leader>tp / <leader>tP, flagged
--     and left as-is: the README lists <leader>tp and
--     <leader>tP for LivePreview, but keybinds.lua has NO tp /
--     tP mappings, and this file defines none either. The only
--     LivePreview controls that exist are the :LivePreview and
--     :LivePreviewStop user commands created in init below.
--     So <leader>tp / <leader>tP do nothing until mappings for
--     them are added; the commands themselves work as-is.
--   * Port clash -- http://localhost:3000, flagged and left
--     as-is: start_live_server below builds the preview URL as
--     "http://localhost:3000/" .. target_file, which is
--     browser-sync's default port. That is also my-first-app's
--     port (http://localhost:3000). If my-first-app is running
--     when you start LivePreview, browser-sync cannot take
--     port 3000, or the browser may open my-first-app instead
--     of the previewed file. Nothing was changed here.
--   * LivePreview save hook: start_live_server creates a
--     BufWritePost autocmd (group HtmlLivePreview) for *.html,
--     *.css, and *.js that sends "browser-sync reload" to
--     terminal 99. stop_live_server clears that group's
--     autocmds. It is separate from conform.lua's BufWritePre
--     format on save, and from auto.lua's compile-and-run
--     hooks, so there is no duplicate hook for the same job.
--   * Terminal 99 is LivePreview's own lane: browser-sync runs
--     there, in a horizontal terminal, and is hidden again with
--     99ToggleTerm. It does not use the floating / horizontal /
--     vertical terminals from <C-\> or <leader>tf / th / tv.
--   * KDE / Yakuake step is kept as-is: after a 1000 ms delay
--     the preview is opened with xdg-open, then Yakuake is
--     toggled away via qdbus6 (falling back to qdbus) on
--     org.kde.yakuake /yakuake/window toggleWindowState.

-- ---------------------------------------------------------------------------
-- ToggleTerm
-- ---------------------------------------------------------------------------
return {
	"akinsho/toggleterm.nvim",
	version = "*",
	cmd = { "ToggleTerm", "ToggleTermToggleAll", "ToggleTermSendVisualLines", "ToggleTermSendVisualSelection" },
	keys = {
		{ "<C-\\>", "<cmd>ToggleTerm direction=float<cr>", desc = "Toggle Floating Shell" },
	},
	-- 'init' executes immediately on startup so all user commands are registered instantly
	init = function()
		local live_preview_group = vim.api.nvim_create_augroup("HtmlLivePreview", { clear = true })
		local server_job_id = nil

		-- -------------------------------------------------------------------
		-- Realtime HTML preview functions (KDE Plasma integrated)
		-- -------------------------------------------------------------------
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

			-- Introduce a non-blocking delay to let the server start up completely
			vim.defer_fn(function()
				local local_url = "http://localhost:3000/" .. target_file

				-- 1. Open your default web browser smoothly using system layer paths
				vim.fn.jobstart({ "xdg-open", local_url }, { detach = true })

				-- 2. Fetch your system's active KDE Plasma D-Bus command controller binary
				local dbus_cmd = vim.fn.executable("qdbus6") == 1 and "qdbus6" or "qdbus"

				-- 3. Ask Yakuake to slide back up to the ceiling so Firefox is revealed in focus
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

		-- -------------------------------------------------------------------
		-- Lazygit class instance & global wrapper
		-- -------------------------------------------------------------------
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
