-- opts `:help option-list`
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.have_nerd_font = true
vim.o.winborder = 'rounded'
vim.o.relativenumber = true
vim.o.number = true   -- show true number on the current line
vim.o.signcolumn = 'yes'
vim.o.undofile = true -- undo tree
vim.o.wrap = false
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.spell = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.updatetime = 250 -- Decrease update time
vim.o.timeoutlen = 300 -- Decrease mapped sequence wait time

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.scrolloff = 10   -- Minimal number of screen lines to keep above and below the cursor.

vim.o.swapfile = false -- No swapfiles

-- sync with system clipboard
vim.schedule(function()
    vim.o.clipboard = 'unnamedplus'
end)
