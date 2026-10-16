MiniDeps.add("ellisonleao/gruvbox.nvim")
require("gruvbox").setup({
    transparent_mode = true,
    -- transparent_mode only clears Normal, NormalFloat, SignColumn, FoldColumn
    -- and WinSeparator. mini.statusline's groups link to StatusLine/StatusLineNC,
    -- which keep their bg, so clear them here. Mode groups keep their accent
    -- background on purpose.
    overrides = {
        MiniStatuslineFilename = { fg = require("gruvbox").palette.light4, bg = "NONE" },
        MiniStatuslineDevinfo = { fg = require("gruvbox").palette.light3, bg = "NONE" },
    },
})
vim.cmd [[colorscheme gruvbox]]

-- MiniDeps.add("neanias/everforest-nvim")
-- require('everforest').setup({
--     ui_contrast = "high",
--     -- Max valid level is 2. Anything higher silently fails every `== 2` check
--     -- in the theme, so Normal went transparent but StatusLine kept bg2.
--     transparent_background_level = 2,
--     on_highlights = function(hl, palette)
--         -- mini.statusline's own groups hardcode bg1 regardless of the
--         -- transparency level, so clear them here. Mode groups keep their
--         -- accent background on purpose.
--         hl.MiniStatuslineFilename = { fg = palette.grey1, bg = palette.none }
--         hl.MiniStatuslineDevinfo = { fg = palette.grey2, bg = palette.none }
--     end,
-- })
-- vim.cmd [[colorscheme everforest]]
