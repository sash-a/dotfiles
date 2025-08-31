-- UI
MiniDeps.add('nvim-mini/mini.icons')
require('mini.icons').setup()

MiniDeps.add('nvim-mini/mini.notify')
require('mini.notify').setup()

MiniDeps.add('nvim-mini/mini.starter')
require('mini.starter').setup()

MiniDeps.add('nvim-mini/mini.extra')
require('mini.extra').setup()

MiniDeps.add('nvim-mini/mini.indentscope')
require('mini.indentscope').setup({ symbol = "│" })
vim.cmd('highlight MiniIndentscopeSymbol guifg=#504945') -- set colour of the indent to grey

MiniDeps.add('nvim-mini/mini.animate')
require('mini.animate').setup({
    cursor = { enable = false, },
    scroll = { enable = true, },
})

-- text manipulation
MiniDeps.add('nvim-mini/mini.ai')
require("mini.ai").setup()

MiniDeps.add('nvim-mini/mini.pairs')
require('mini.pairs').setup()

MiniDeps.add('nvim-mini/mini.cursorword')
require('mini.cursorword').setup()

MiniDeps.add('nvim-mini/mini.surround')
require('mini.surround').setup({
    mappings = {
        add = 'gsa',       -- Add surrounding in Normal and Visual modes
        delete = 'gsd',    -- Delete surrounding
        highlight = 'gsh', -- Highlight surrounding
        replace = 'gsr',   -- Replace surrounding
    },
})

-- navigation
MiniDeps.add('nvim-mini/mini.bufremove')
require('mini.bufremove').setup()

MiniDeps.add('nvim-mini/mini.files')
require('mini.files').setup({ mappings = { synchronize = "<CR>" } })

MiniDeps.add('nvim-mini/mini.jump2d')
require('mini.jump2d').setup({
    labels = "etovxqpdygfblzhckisuran",
    view = {
        dim = true, -- Whether to dim lines with at least one jump spot
        n_steps_ahead = 0,
    },
    allowed_windows = {
        current = true,
        not_current = false,
    },
    mappings = { start_jumping = '<leader>h' },
})
