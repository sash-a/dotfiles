-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- general editor actions
vim.keymap.set('n', '<C-s>', ':w <cr>', { desc = '[S]ave (and format)' })
vim.keymap.set('n', '<C-w>', ':bw <cr>', { desc = 'Buffer [W]ipeout' })
vim.keymap.set('n', '<C-q>', ':q <cr>', { desc = '[Q]uit' })
vim.keymap.set('n', '<leader>lf', ':lua vim.lsp.buf.format() <cr>', { desc = 'Lsp [F]ormat' })

vim.keymap.set('i', 'jj', '<Esc>', { desc = 'Escape' })
vim.keymap.set('i', '<C-s>', '<Esc>:w<cr>', { desc = 'Escape' })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>de', vim.diagnostic.open_float, { desc = 'Open floating [d]iagnostic [e]rror message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- hop/easy motions
vim.keymap.set('n', '<leader>h', ':HopWord <cr>', { desc = '[H]op Word' })

-- nvim tree
vim.keymap.set('n', '<leader>e', ':NvimTreeToggle <cr>', { desc = 'File [E]xplorer' })

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

-- toggle term
vim.keymap.set('n', '<leader>tv', ':ToggleTerm size=80 direction=vertical <cr>', { desc = '[T]erminal [V]ertical' })
vim.keymap.set('n', '<leader>tf', ':ToggleTerm direction=float <cr>', { desc = '[T]erminal [f]oat' })
vim.keymap.set('n', '<leader>tt', ':ToggleTerm direction=tab <cr>', { desc = '[T]erminal [T]ab' })

function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
	vim.keymap.set('t', 'jk', [[<C-\><C-n>]], opts)
	vim.keymap.set('t', 'jj', [[<C-\><C-n>]], opts)
	vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
	vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
	vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
	vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

-- lazygit
-- local Terminal = require('toggleterm.terminal').Terminal
-- local lazygit  = Terminal:new({
-- 	cmd = "lazygit",
-- 	dir = "git_dir",
-- 	direction = "float",
-- 	float_opts = {
-- 		border = "double",
-- 	},
-- 	-- function to run on opening the terminal
-- 	on_open = function(term)
-- 		vim.cmd("startinsert!")
-- 		vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
-- 	end,
-- 	-- function to run on closing the terminal
-- 	on_close = function(term)
-- 		vim.cmd("startinsert!")
-- 	end,
-- })
--
-- function _lazygit_toggle()
-- 	lazygit:toggle()
-- end

-- vim.api.nvim_set_keymap("n", "<leader>lg", "<cmd>lua _lazygit_toggle()<CR>",
-- 	{ noremap = true, silent = true, desc = '[L]azy [G]it' }
-- )
-- vim.api.nvim_set_keymap("n", "<leader>gg", "<cmd>lua _lazygit_toggle()<CR>",
-- 	{ noremap = true, silent = true, desc = '[L]azy [G]it' }
-- )

-- dap
-- vim.keymap.set('n', '<leader>db', ':lua require("dap").toggle_breakpoint()<cr>', { desc = '[D]ebug Toggle [B]reakpoint' })
-- vim.keymap.set('n', '<leader>dc', ':lua require("dap").continue()<cr>', { desc = '[D]ebug [C]ontinue' })
-- vim.keymap.set('n', '<leader>dsi', ':lua require("dap").step_into()<cr>', { desc = '[D]ebug [S]tep [I]nto' })
-- vim.keymap.set('n', '<leader>dso', ':lua require("dap").step_over()<cr>', { desc = '[D]ebug [S]tep [O]ver' })

-- undotree
-- vim.keymap.set('n', '<leader>u', ':UndotreeToggle<cr>', { desc = '[U]ndo Tree Togggle' })

-- copilot
vim.cmd [[imap <silent><script><expr> <C-a> copilot#Accept("\<CR>")]]
vim.g.copilot_no_tab_map = true
