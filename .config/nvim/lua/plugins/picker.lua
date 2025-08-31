MiniDeps.add('nvim-mini/mini.pick')
require('mini.pick').setup({
    mappings = {
        move_down      = '<Tab>',
        toggle_preview = '<C-y>',
    }
})

-- -- Keymaps
vim.keymap.set('n', '<leader>ff', ':Pick files<CR>', { desc = "[F]ind [f]iles" })
vim.keymap.set('n', '<leader>fg', ':Pick grep_live<CR>', { desc = "[F]ind [g]rep" })
vim.keymap.set('n', '<leader> ', ':Pick buffers<CR>', { desc = "Search open buffers" })
vim.keymap.set('n', '<leader>/', ':Pick buf_lines<CR>', { desc = "Fuzzy find in buffer" })
vim.keymap.set('n', '<leader>fr', ':Pick resume<CR>', { desc = "[F]ind [r]esume" })
vim.keymap.set('n', '<leader>fc', ':Pick colorschemes<CR>', { desc = "[F]ind [c]oulorschemes" })
vim.keymap.set('n', '<leader>fh', ':Pick help<CR>', { desc = "[F]ind [h]elp" })
