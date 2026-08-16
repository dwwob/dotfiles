-- ~/.config/nvim/lua/plugins/blink.lua
return {
	"saghen/blink.cmp",
	version = "*", -- Downloads pre-compiled native binaries
	opts = {
		keymap = { preset = "default" },
		appearance = {
			use_nvim_cmp_as_default = true,
			nerd_font_variant = "mono",
		},
		sources = {
			default = { "lsp", "path", "snippets", "buffer" },
		},
	},
	opts_extend = { "sources.default" },
}
