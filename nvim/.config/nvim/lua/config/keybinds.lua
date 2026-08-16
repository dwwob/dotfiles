-- ~/.config/nvim/lua/config-keymaps.lua
local keymap = vim.keymap.set

-- Toggle comment on current line using Ctrl + /
vim.keymap.set("n", "<leader>cc", "gcc", { remap = true, desc = "Toggle Comment" })
vim.keymap.set("n", "<leader>w", ":w<CR>", { desc = "save file " })
vim.keymap.set("n", "<leader>q", ":q<CR>", { desc = "Quit " })
-- Window navigation
keymap("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
keymap("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
keymap("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
keymap("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

vim.keymap.set("n", "<leader>cd", vim.cmd.Ex, { desc = "toggle tree mode" })

-- Map 'jk' to exit Insert mode
vim.keymap.set("i", "jk", "<Esc>", { desc = "exit Insert mode", noremap = true, silent = true })

-- replaces selected text WITHOUT losing what you yanked
vim.keymap.set("x", "p", [["_dp]], { desc = "Paste over selection without losing yanked text" })

-- Delete text without saving it to any registers
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]], { desc = "Delete without yanking" })
vim.keymap.set("n", "<C-c>", "nohl<CR>", { desc = "Clear search highlighting", silent = true })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "moves lines down in visual selection" })
vim.keymap.set("v", "K", ":m '>-2<CR>gv=gv", { desc = "moves lines up in visual selection" })

vim.keymap.set("v", "<", "<gv", { desc = "Unindent and keep selection" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent and keep selection" })

vim.keymap.set("n", "J", "mzJ'z", { desc = "Join lines without moving cursor" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "move down in buffer with cursor centered" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "move up in buffer with cursor centered" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result cursor centered" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result cursor centered" })

vim.keymap.set(
	"n",
	"<leader>s",
	[[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
	{ desc = "Replace word cursor" }
)
vim.keymap.set("n", "<leader>X", "<cmd>!chmod +x %<CR>", { silent = true, desc = "makes file executable" })

vim.keymap.set("n", "<leader>re", "<cmd>restart<CR>", { desc = "Restart Neovim (:restart)" })

-- Native undotree
vim.keymap.set("n", "<leader>u", function()
	vim.cmd.packadd("nvim.undotree")
	require("undotree").open()
end, { desc = "Toggle Builtin Undotree" })
