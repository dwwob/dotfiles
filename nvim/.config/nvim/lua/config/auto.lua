-- ./config/nvim/lua/config/auto.lua

-- ============================================
-- Setup autoclose plugin
-- ============================================

require("ibl").setup({
	indent = {
		char = "│", -- Set the vertical char acter line
	},
	scope = {
		enabled = true, -- Highlights the current block scope you are working in
		show_start = false,
		show_end = false,
	},
})

local highlight = {
	"RainbowRed",
	"RainbowYellow",
	"RainbowBlue",
	"RainbowOrange",
	"RainbowGreen",
	"RainbowViolet",
	"RainbowCyan",
}

local hooks = require("ibl.hooks")
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
	vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
	vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
	vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
	vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
	vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
	vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
	vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
end)

require("ibl").setup({ indent = { highlight = highlight } })

-- ~/.config/nvim/lua/config/auto.lua

local compile_group = vim.api.nvim_create_augroup("AutoCompileAndRun", { clear = true })

vim.api.nvim_create_autocmd("BufWritePost", {
	group = compile_group,
	pattern = { "*.c", "*.cpp", "*.py", "*.cob", "*.cbl", "*.sh" },
	callback = function()
		-- 🩺 LSP SAFETY CHECK: Count active syntax errors in the current buffer
		local errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })

		-- If there are any syntax errors blocking the file, abort compilation completely
		if errors > 0 then
			vim.notify("⚠️ Auto-compile blocked: Fix active syntax errors first.", vim.log.levels.WARN)
			return
		end

		local target_dir = vim.fn.expand("%:p:h")
		local file_name = vim.fn.expand("%:t")
		local base_name = vim.fn.expand("%:t:r")
		local extension = vim.fn.expand("%:e")

		local exec_cmd = nil

		-- Construct compiling parameters clearly
		if extension == "py" then
			exec_cmd = "python3 " .. file_name
		elseif extension == "c" then
			exec_cmd = "gcc " .. file_name .. " -o " .. base_name .. " && ./" .. base_name
		elseif extension == "cpp" or extension == "cc" then
			exec_cmd = "g++ " .. file_name .. " -o " .. base_name .. " && ./" .. base_name
		elseif extension == "cob" or extension == "cbl" then
			exec_cmd = "cobc -x " .. file_name .. " && ./" .. base_name
		elseif extension == "sh" then
			exec_cmd = "./" .. file_name
		end

		if exec_cmd then
			-- Append the pause prompt so the console window locks open
			local final_payload = exec_cmd .. ' && echo "" && read -p "Press [Enter] to close..." _'

			-- 🚀 FIX: Invoke the native Lua API executor instead of VIM command routing strings
			require("toggleterm").exec(final_payload, nil, nil, target_dir, "float")
		end
	end,
})
