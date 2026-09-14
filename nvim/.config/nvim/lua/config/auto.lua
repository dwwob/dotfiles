-- ~/.config/nvim/lua/config/auto.lua

-- =========================================================================
-- 1. ASYNC BACKGROUND SAVE-COMPILERS (WITH FOOLPROOF C23 BYPASS)
-- =========================================================================
local compile_group = vim.api.nvim_create_augroup("AutoCompileAndRun", { clear = true })

vim.api.nvim_create_autocmd("BufWritePost", {
	group = compile_group,
	pattern = { "*.c", "*.cpp", "*.py", "*.cob", "*.cbl", "*.sh" },
	callback = function()
		local target_dir = vim.fn.expand("%:p:h")
		local file_name = vim.fn.expand("%:t")
		local base_name = vim.fn.expand("%:t:r")
		local extension = vim.fn.expand("%:e")

		local exec_cmd = nil
		local bypass_error_check = false

		-- Construct flat executing parameters with zero internal quote marks
		if extension == "py" then
			exec_cmd = "python3 " .. file_name
		elseif extension == "c" then
			-- 🚀 FIXED: Extract the first index string out of the table buffer array cleanly
			local lines = vim.api.nvim_buf_get_lines(0, 0, 1, false)
			local first_line = (lines and lines[1]) or ""
			local std_flag = ""

			-- Uses direct literal lookups to turn off regex parsing errors
			if first_line:find("std=c23", 1, true) or first_line:find("std=gnu23", 1, true) then
				std_flag = " -std=gnu23 "
				bypass_error_check = true -- 🚀 UNLOCKED: Let GCC handle compiling directly
			end

			exec_cmd = "gcc " .. file_name .. std_flag .. " -o " .. base_name .. " && ./" .. base_name
		elseif extension == "cpp" or extension == "cc" then
			-- 🚀 FIXED: Extract the first index string out of the table buffer array cleanly
			local lines = vim.api.nvim_buf_get_lines(0, 0, 1, false)
			local first_line = (lines and lines[1]) or ""
			local std_flag = ""

			if first_line:find("std=c++23", 1, true) or first_line:find("std=gnu++23", 1, true) then
				std_flag = " -std=c++23 "
				bypass_error_check = true
			elseif first_line:find("std=c++20", 1, true) or first_line:find("std=gnu++20", 1, true) then
				std_flag = " -std=c++20 "
				bypass_error_check = true
			end

			exec_cmd = "g++ " .. file_name .. std_flag .. " -o " .. base_name .. " && ./" .. base_name
		elseif extension == "cob" or extension == "cbl" then
			exec_cmd = "cobc -x " .. file_name .. " && ./" .. base_name
		elseif extension == "sh" then
			exec_cmd = "./" .. file_name
		end

		-- 🩺 LSP SAFETY CHECK: Run only if we aren't bypassing it for a modern standard
		if not bypass_error_check then
			local active_diagnostics = vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
			local critical_syntax_errors = 0

			for _, diag in ipairs(active_diagnostics) do
				local source = (diag.source or ""):lower()
				if not source:find("cspell") then
					critical_syntax_errors = critical_syntax_errors + 1
				end
			end

			if critical_syntax_errors > 0 then
				vim.notify("⚠️ Auto-compile blocked: Fix critical syntax errors first.", vim.log.levels.WARN)
				return
			end
		end

		if exec_cmd then
			-- Chaining shell exit ensures ToggleTerm disposes its window automatically on [Enter]
			local final_payload = exec_cmd .. ' && echo "" && read -p "Press [Enter] to close..." _ && exit'

			-- Ensure lazy.nvim loads ToggleTerm's modules instantly
			require("lazy").load({ plugins = { "toggleterm.nvim" } })

			-- Pass execution payload straight into ToggleTerm's native Lua thread API
			require("toggleterm").exec(final_payload, 100, nil, target_dir, "float")
		end
	end,
})

-- =========================================================================
-- 2. NATIVE LSP PROGRESS TOAST NOTIFICATION BRIDGE
-- =========================================================================
local progress_group = vim.api.nvim_create_augroup("NativeLspProgress", { clear = true })

vim.api.nvim_create_autocmd("LspProgress", {
	group = progress_group,
	callback = function(ev)
		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		local value = ev.data.params.value
		if not client or type(value) ~= "table" then
			return
		end

		if value.kind == "begin" or value.kind == "report" then
			vim.notify(value.message or "Initializing environment...", vim.log.levels.INFO, {
				title = "📡 LSP: " .. client.name,
				icon = "📥",
				timeout = 1500,
			})
		end
	end,
})

-- =========================================================================
-- 3. COBOL RE-CASING & COLUMN CLEANER HOOK
-- =========================================================================
local cobol_format_group = vim.api.nvim_create_augroup("CobolFormatLines", { clear = true })

vim.api.nvim_create_autocmd("BufWritePost", {
	group = cobol_format_group,
	pattern = { "*.cob", "*.cbl" },
	callback = function()
		local file_path = vim.fn.expand("%:p")

		local commands = {
			"sed -i 's/\\bidentification division\\b/IDENTIFICATION DIVISION/gI' " .. vim.fn.shellescape(file_path),
			"sed -i 's/\\benvironment division\\b/ENVIRONMENT DIVISION/gI' " .. vim.fn.shellescape(file_path),
			"sed -i 's/\\bdata division\\b/DATA DIVISION/gI' " .. vim.fn.shellescape(file_path),
			"sed -i 's/\\bworking-storage section\\b/WORKING-STORAGE SECTION/gI' " .. vim.fn.shellescape(file_path),
			"sed -i 's/\\bprocedure division\\b/PROCEDURE DIVISION/gI' " .. vim.fn.shellescape(file_path),
		}

		for _, cmd in ipairs(commands) do
			vim.fn.jobstart(cmd, { detach = true })
		end

		vim.cmd("checktime")
	end,
})
