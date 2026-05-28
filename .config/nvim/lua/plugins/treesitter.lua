MiniDeps.add({
    source = 'nvim-treesitter/nvim-treesitter',
    checkout = 'main',
    monitor = 'main',
    hooks = { post_checkout = function() vim.cmd('TSUpdate') end },
})

require('nvim-treesitter').install({
    'lua', 'vimdoc', 'python', 'c_sharp', 'markdown', 'markdown_inline',
})

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'lua', 'help', 'python', 'cs', 'markdown' },
    callback = function() vim.treesitter.start() end,
})
