-- Session management
vim.keymap.set("n", "<C-q>", ":q<cr>", { desc = "[Q]uit" })
vim.keymap.set({ "i", "n" }, "<C-s>", "<esc>:w<cr>", { desc = "[S]ave" })
vim.keymap.set("n", "<leader>bd", ':lua MiniBufremove.delete()<CR>', { desc = "[B]uffer [d]elete" })
vim.keymap.set("n", "<leader>bD", ":bw<CR>", { desc = "[B]uffer [w]ipeout" })

-- navigation
vim.keymap.set('n', '<C-j>', '<C-w>j', { desc = 'Switch to lower pane' })
vim.keymap.set('n', '<C-k>', '<C-w>k', { desc = 'Switch to upper pane' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Switch to right pane' })
vim.keymap.set('n', '<leader>e', ':lua MiniFiles.open()<CR>', { desc = 'File [e]xplorer' })

vim.keymap.set('n', '<Leader>-', ':sp<CR>', { desc = "Split down", noremap = true, silent = true })
vim.keymap.set('n', '<Leader>|', ':vsp<CR>', { desc = "Split right", noremap = true, silent = true })

-- LSP
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { desc = '[G]o to [d]efinition' })
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { desc = '[G]o to [d]eclaration' })
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { desc = 'Show hover' })
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { desc = '[G]o to [i]mplementation' })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { desc = '[G]o to [r]eferences' })
vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, { desc = '[C]ode [a]ction' })
vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Switch to left pane' })
