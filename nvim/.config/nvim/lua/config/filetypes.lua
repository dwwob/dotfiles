vim.filetype.add({
	extension = {
		mdx = "markdown",
		env = "sh",
		conf = "config",
	},
	filename = {
		[".env.local"] = "sh",
		["tsconfig.json"] = "jsonc",
	},
})
