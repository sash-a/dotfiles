MiniDeps.add('nvim-mini/mini.bufremove')
require('mini.bufremove').setup()

-- mini plugins
MiniDeps.add('nvim-mini/mini.ai')
require("mini.ai").setup()

MiniDeps.add('nvim-mini/mini.pairs')
require('mini.pairs').setup()

MiniDeps.add('nvim-mini/mini.surround')
require('mini.surround').setup({
    mappings = {
        add = 'gsa',       -- Add surrounding in Normal and Visual modes
        delete = 'gsd',    -- Delete surrounding
        highlight = 'gsh', -- Highlight surrounding
        replace = 'gsr',   -- Replace surrounding

        suffix_last = 'l', -- Suffix to search with "prev" method
        suffix_next = 'n', -- Suffix to search with "next" method
    },
})


MiniDeps.add('nvim-mini/mini.extra')
require('mini.extra').setup()

MiniDeps.add('nvim-mini/mini.files')
require('mini.files').setup({ mappings = { synchronize = "<CR>" } })

MiniDeps.add('nvim-mini/mini.icons')
require('mini.icons').setup()

MiniDeps.add('nvim-mini/mini.cursorword')
require('mini.cursorword').setup()

MiniDeps.add('nvim-mini/mini.notify')
require('mini.notify').setup()

MiniDeps.add('nvim-mini/mini.starter')
require('mini.starter').setup()

MiniDeps.add('nvim-mini/mini.animate')
require('mini.animate').setup({
    -- Cursor path
    cursor = { enable = false, },
    scroll = { enable = true, },
})


MiniDeps.add('nvim-mini/mini.jump2d')
require('mini.jump2d').setup({
    labels = "etovxqpdygfblzhckisuran",
    view = {
        -- Whether to dim lines with at least one jump spot
        dim = true,
        n_steps_ahead = 1,
    },
    allowed_windows = {
        current = true,
        not_current = false,
    },
    mappings = {
        start_jumping = '<leader>h',
    },
})


MiniDeps.add('nvim-mini/mini.indentscope')
require('mini.indentscope').setup({ symbol = "│" })
vim.cmd('highlight MiniIndentscopeSymbol guifg=#504945') -- set colour of the indent to grey
