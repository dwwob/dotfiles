-- ~/.config/nvim/lua/plugins/coding/nvim-lspconfig.lua
--
-- Cleaned-up version of your original file.
-- Every setting is the same as before -- nothing was changed,
-- moved in order, or removed.
-- Changes are only to layout: one header style throughout, matching
-- lsp_signature.lua, goto-preview.lua, emmet_vim.lua, mason.lua,
-- conform.lua, blink.lua, init.lua, lazy.lua, auto.lua,
-- keybinds.lua, and options.lua.
--
-- Plays-together check against your other files:
--   * This file will load. lazy.lua's scanner registers "plugins"
--     plus one import per subdirectory under lua/plugins/, and
--     this file sits in lua/plugins/coding/ in your tree, so it
--     is covered by the "plugins.coding" import.
--   * Not lazy-loaded: lazy = false with priority = 900 means
--     lazy.nvim loads this spec at startup, ahead of normal
--     plugins, so the LspAttach keymaps, the server configs, and
--     the mason-lspconfig setup below are all in place before
--     any server attaches.
--   * Correction to the earlier mason.lua / goto-preview.lua /
--     lsp_signature.lua notes: there IS a mason-lspconfig
--     bridge in your setup. It is not a separate
--     mason-lspconfig.lua file -- it is here, as the
--     "mason-org/mason-lspconfig.nvim" dependency of this spec,
--     and it is set up at the end of the config function below.
--     So servers installed through :Mason ARE auto-enabled,
--     except angularls. The earlier flag that there was no
--     bridge was wrong.
--   * Dependencies line up: "williamboman/mason.nvim" is the
--     same plugin as mason.lua's spec, and "saghen/blink.cmp"
--     is the same plugin as blink.lua's spec, so lazy.nvim
--     merges each into one plugin, not two copies.
--   * LspAttach keymaps below are buffer-local and Normal mode
--     only: K (hover), gd (definition), gD (declaration), gi
--     (implementation), gr (references), <leader>cr (rename),
--     and <leader>ca (code action). No clash with
--     goto-preview.lua: its default mappings are gpd, gpt, gpi,
--     gpD, gpr, and gP -- all start with "gp", not gd / gi / gr.
--     No clash with keybinds.lua either: its LSP keys are
--     [d / ]d and <leader>dl, and <leader>cc / <leader>cb are
--     different keys from <leader>cr / <leader>ca. blink.lua
--     and emmet_vim.lua work in Insert mode, so no clash there.
--   * Also on LspAttach: lsp_signature.lua loads on the same
--     event, but it only shows the signature window -- it sets
--     no keymaps, so both LspAttach handlers run side by side.
--     auto.lua's LspProgress autocmd is a different event.
--   * Capabilities: this file takes blink.cmp's capabilities
--     with require("blink.cmp").get_lsp_capabilities() and
--     applies them to every server with vim.lsp.config("*", ...)
--     -- that is why blink.cmp is a dependency here.
--   * Order inside config is right: the lua_ls and emmet_ls
--     profiles are set with vim.lsp.config BEFORE
--     mason-lspconfig is set up, so they are already in place
--     when automatic_enable starts the servers.
--   * lua_ls: diagnostics globals = { "vim" } stops "undefined
--     global vim" warnings in your own config files, and
--     workspace checkThirdParty = false turns off third-party
--     library prompts. Left as-is.
--   * emmet_ls filetypes: { "html", "css", "sass", "scss",
--     "less", "javascript" }. Note it DOES include plain
--     "javascript", but it does NOT include
--     "javascriptreact", "typescriptreact", or "vue". That is
--     the opposite split from emmet_vim.lua, whose ft list is
--     { "html", "css", "javascriptreact", "typescriptreact",
--     "vue" } with no plain javascript: react and vue files
--     get emmet-vim, plain javascript gets emmet_ls, and html
--     and css get both. Left as-is.
--   * emmet_ls also sets html output.selfClosingStyle = "xhtml"
--     in init_options, for self-closing web tags. Left as-is.
--   * mason-lspconfig: automatic_enable excludes only
--     "angularls", so every other server installed in :Mason
--     auto-starts. There is still no ensure_installed list in
--     this file or in mason.lua, so servers are not installed
--     automatically -- they have to be installed by hand
--     through :Mason first, then this bridge enables them.
--   * conform.lua's lsp_format = "fallback" depends on this
--     file: when a formatter binary is missing, the fallback
--     is formatting from a server enabled here.

-- ---------------------------------------------------------------------------
-- LSP Config
-- ---------------------------------------------------------------------------
return {
	"neovim/nvim-lspconfig",
	lazy = false,
	priority = 900,
	dependencies = {
		"williamboman/mason.nvim",
		"mason-org/mason-lspconfig.nvim", -- CRITICAL BRIDGE TO AUTOMATE 0.12+ AUTOSTART
		"saghen/blink.cmp",
	},
	config = function()
		-- -----------------------------------------------------------------
		-- LSP Attach Keymaps
		-- -----------------------------------------------------------------
		local lsp_group = vim.api.nvim_create_augroup("UserLspConfig", { clear = true })
		vim.api.nvim_create_autocmd("LspAttach", {
			group = lsp_group,
			callback = function(args)
				local bufnr = args.buf
				local opts = { buffer = bufnr, silent = true }

				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
				vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { buffer = bufnr, desc = "Rename Symbol" })
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code Action" })
			end,
		})

		-- -----------------------------------------------------------------
		-- Completion Capabilities
		-- -----------------------------------------------------------------
		-- Fetch blink.cmp's optimized native completion capabilities
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		-- Apply global capabilities to all servers natively via the 0.12 wildcard
		vim.lsp.config("*", { capabilities = capabilities })

		-- -----------------------------------------------------------------
		-- Server Configurations
		-- -----------------------------------------------------------------
		-- Inject specific configuration profiles BEFORE auto-enable maps them
		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					diagnostics = { globals = { "vim" } },
					workspace = { checkThirdParty = false },
				},
			},
		})

		-- Configures self-closing formatting templates for web files natively
		vim.lsp.config("emmet_ls", {
			filetypes = { "html", "css", "sass", "scss", "less", "javascript" },
			init_options = {
				html = { options = { ["output.selfClosingStyle"] = "xhtml" } },
			},
		})

		-- -----------------------------------------------------------------
		-- Mason Bridge
		-- -----------------------------------------------------------------
		-- This automatically reads what you installed inside your :Mason window,
		-- appends the binary execution paths, and fires native autostarts safely!
		require("mason-lspconfig").setup({
			-- Exclude angularls here so it can never trigger background console spams
			automatic_enable = {
				exclude = { "angularls" },
			},
		})
	end,
}
