return {
	"saghen/blink.cmp",
	-- optional: use a release tag to download pre-built binaries
	version = "*",
	-- build = "cargo build --release", -- uncomment if you want to build locally
	opts = {
		-- 'default' for mappings similar to cmp-tabbed/menu behaviors
		-- 'super-tab' for tab-based navigation
		-- 'enter' for accept via enter key
		keymap = { preset = "enter" },

		appearance = {
			-- set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "mono",
		},

		-- default sources are provided out of the box: lsp, path, snippets, buffer
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},
	},
	opts_extend = { "sources.default" },
}
