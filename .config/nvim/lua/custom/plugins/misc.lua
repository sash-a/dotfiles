return {
  -- Detect tabstop and shiftwidth automatically
  { 'tpope/vim-sleuth' },
  -- Useful plugin to show you pending keybinds.
  { 'folke/which-key.nvim', opts = {} },
  -- Additional lua configuration, makes nvim stuff amazing!
  { 'folke/neodev.nvim', opts = {} },
  -- Automatically makes bracket pairs
  { 'windwp/nvim-autopairs', opts = {} },
  -- Cool icons
  { 'nvim-tree/nvim-web-devicons' },
  {
    'echasnovski/mini.surround',
    version = '*',
    config = function()
      require('mini.surround').setup {
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
  { 'echasnovski/mini.starter', version = '*', opts = {} },
  { 'echasnovski/mini.comment', version = '*', opts = {} },
  { 'echasnovski/mini.animate', version = '*', opts = {} },
  { 'echasnovski/mini.indentscope', version = '*', opts = { symbol = '│' } },
}
