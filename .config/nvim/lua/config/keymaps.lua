-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- Quit
vim.keymap.set("n", "<C-q>", ":q <cr>", { desc = "[Q]uit" })
-- Close buffer
vim.keymap.set("n", "<leader>bd", function()
  Snacks.bufdelete()
end, { desc = "Delete Buffer" })

-- Expand LSP error
vim.keymap.set("n", "<leader>de", vim.diagnostic.open_float, { desc = "Open floating [d]iagnostic [e]rror message" })

-- Terminal
vim.keymap.del("n", "<leader>fT")
vim.keymap.del("n", "<leader>ft")

vim.keymap.set("n", "<leader>tb", function()
  Snacks.terminal(nil, { cwd = LazyVim.root(), win = { position = "bottom" } })
end, { desc = "Terminal bottom" })

vim.keymap.set("n", "<leader>tf", function()
  Snacks.terminal(nil, { cwd = LazyVim.root(), win = { position = "float" } })
end, { desc = "Terminal float" })
