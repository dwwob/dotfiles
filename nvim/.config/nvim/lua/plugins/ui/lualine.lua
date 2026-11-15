-- ~/.config/nvim/lua/plugins/ui/lualine.lua
--
-- Cleaned-up version of your original file.
-- Every setting is the same as before -- nothing was changed,
-- moved in order, or removed.
-- Changes are only to layout: one header style throughout, matching
-- indent-blankline.lua, color.lua, which-key.lua,
-- vim-fugitive.lua, trouble.lua, telescope.lua, inline.lua,
-- nvim-lint.lua, toggleterm.lua, git.lua, ts-autopairs.lua,
-- treesitter.lua, nvim-lspconfig.lua, lsp_signature.lua,
-- goto-preview.lua, emmet_vim.lua, mason.lua, conform.lua,
-- blink.lua, init.lua, lazy.lua, auto.lua, keybinds.lua, and
-- options.lua, and the spec kept together under its own header.
-- Your paste had two top lines, statusline.lua and
-- lualine.lua -- the statusline.lua line is dropped and
-- lualine.lua is used, as in your request.
-- The rocket / folder comment banners are reworded to plain
-- text; the emoji inside the returned strings ("No LSP" and
-- the LSP names prefix) are kept exactly, since those are
-- displayed values in the statusline itself.
--
-- Plays-together check against your other files:
--   * This file will load. lazy.lua's scanner registers "plugins"
--     plus one import per subdirectory under lua/plugins/, and
--     this file sits in lua/plugins/ui/, so it is covered by
--     the "plugins.ui" import.
--   * No lazy / event / cmd / keys trigger here, so lazy.nvim
--     loads it at startup -- the statusline is there from the
--     start. With opts and no config function, lazy.nvim calls
--     require("lualine").setup(opts) for it.
--   * options.lua lines up with it: laststatus = 2 there
--     means a statusline is always shown, which is what
--     lualine replaces and draws.
--   * No theme is set in opts, so lualine uses its default
--     "auto" theme and picks up the active colourscheme --
--     tokyonight (moon, transparent) from color.lua, which
--     loads at startup with priority = 1000.
--   * get_active_lsp uses vim.lsp.get_clients({ bufnr = 0 }),
--     the Neovim 0.12+ getter, filtered to the current buffer
--     -- that matches your Neovim 0.12.5 and the clients
--     nvim-lspconfig.lua / mason.lua start. It skips a client
--     named "copilot" and joins the rest with "|"; no copilot
--     plugin is in the other cleaned files, so that filter
--     is harmless and left as-is. When no client is attached
--     it returns the "No LSP" string instead.
--   * lualine_b's "branch" and "diff" sit alongside git.lua
--     (gitsigns) and vim-fugitive.lua: they display branch /
--     change counts in the statusline, while gitsigns keeps
--     the signs, hunks, and blame and fugitive keeps the
--     :Git panel -- display only here, no overlap.
--   * lualine_b's "diagnostics" shows the counts from
--     vim.diagnostic -- the same diagnostics options.lua
--     signs, inline.lua displays inline, nvim-lint.lua's
--     write-good produces, and trouble.lua lists in a panel.
--     This file only counts them; it changes no diagnostic
--     setting.
--   * No keymaps, user commands, autocmds, or save hooks
--     here of its own, so nothing overlaps conform.lua's
--     format on save, nvim-lint.lua's lint autocmds, or
--     auto.lua's compile-and-run, and no <leader> keys clash
--     with keybinds.lua, telescope.lua, trouble.lua, or
--     which-key.lua.
--
-- ---------------------------------------------------------------------------
-- Lualine (statusline)
-- ---------------------------------------------------------------------------

-- Modern 0.12+ LSP statusline resolver
local function get_active_lsp()
	-- Uses the new 0.12+ client getter filtered directly to your active buffer (bufnr = 0)
	local buf_clients = vim.lsp.get_clients({ bufnr = 0 })

	if #buf_clients == 0 then
		return "🔇 No LSP"
	end

	local names = {}
	for _, client in ipairs(buf_clients) do
		-- Filter out any diagnostic helper abstractions, showing only your hard binaries
		if client.name ~= "copilot" then
			table.insert(names, client.name)
		end
	end

	return "📡 " .. table.concat(names, "|")
end

-- Pass this function variable directly into your lualine sections grid layout:
return {
	"nvim-lualine/lualine.nvim",
	opts = {
		sections = {
			lualine_a = { "mode" },
			lualine_b = { "branch", "diff", "diagnostics" },

			-- Left-aligned filename paths
			lualine_c = { { "filename", path = 1, shorting_target = 40 } },

			-- Right-aligned component: tracks your running language servers actively
			lualine_x = { get_active_lsp, "encoding", "fileformat", "filetype" },

			lualine_y = { "progress" },
			lualine_z = { "location" },
		},
	},
}
