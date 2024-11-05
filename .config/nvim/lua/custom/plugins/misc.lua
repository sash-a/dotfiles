return {
  -- Detect tabstop and shiftwidth automatically
  { 'tpope/vim-sleuth' },
  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {} },
  -- Additional lua configuration, makes nvim stuff amazing!
  { 'folke/neodev.nvim', opts = {} },
  -- Automatically makes bracket pairs
  { 'windwp/nvim-autopairs', opts = {} },
  {
    'echasnovski/mini.surround',
    version = '*',
    config = function()
      require('mini.surround').setup {
        highlight_duration = 1000,
        n_lines = 100,
        mappings = {
          add = 'gsa', -- Add surrounding in Normal and Visual modes
          delete = 'gsd', -- Delete surrounding
          highlight = 'gsh', -- Highlight surrounding
          replace = 'gsr', -- Replace surrounding
          find = 'gsf', -- Find surrounding (to the right)
          find_left = 'gsF', -- Find surrounding (to the left)
          update_n_lines = 'gsn', -- Update `n_lines`
        },
      }
    end,
  },
  {
    'echasnovski/mini.files',
    version = '*',
    opts = {},
    keys = { { '<leader>e', ':lua MiniFiles.open()<cr>', desc = 'File browser' } },
  },
  { 'echasnovski/mini.cursorword', version = '*', opts = {} },
  { 'echasnovski/mini.starter', version = '*', opts = {} },
  { 'echasnovski/mini.comment', version = '*', opts = {} },
  { 'echasnovski/mini.animate', version = '*', opts = {} },
  { 'echasnovski/mini.indentscope', version = '*', opts = { symbol = '│', options = { try_as_border = true } } },
  { 
    'echasnovski/mini.ai', 
    version = false,
    config = function ()
      require('mini.ai').setup()
    end,
  },
}
