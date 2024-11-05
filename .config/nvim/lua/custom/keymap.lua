-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- general editor actions
vim.keymap.set('n', '<C-s>', ':w <cr>', { desc = '[S]ave (and format)' })
vim.keymap.set('n', '<C-w>', ':bw <cr>', { desc = 'Buffer [W]ipeout' })
vim.keymap.set('n', '<C-q>', ':q <cr>', { desc = '[Q]uit' })

-- vim.keymap.set('i', 'jj', '<Esc>', { desc = 'Escape' })
vim.keymap.set('i', '<C-s>', '<Esc>:w<cr>', { desc = 'Escape' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>de', vim.diagnostic.open_float, { desc = 'Open floating [d]iagnostic [e]rror message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- split navigation
vim.keymap.set('n', '<C-k>', ":wincmd k <cr>", { silent = true })
vim.keymap.set('n', '<C-j>', ":wincmd j <cr>", { silent = true })
vim.keymap.set('n', '<C-h>', ":wincmd h <cr>", { silent = true })
vim.keymap.set('n', '<C-l>', ":wincmd l <cr>", { silent = true })

-- split resizing
vim.keymap.set('n', '<C-Right>', ':vertical resize +5 <cr>')
vim.keymap.set('n', '<C-Left>', ':vertical resize -5 <cr>')
vim.keymap.set('n', '<C-Up>', ':resize +5 <cr>')
vim.keymap.set('n', '<C-Down>', ':resize -5 <cr>')

-- copilot
-- vim.cmd [[imap <silent><script><expr> <C-a> copilot#Accept("\<CR>")]]
-- vim.g.copilot_no_tab_map = true
