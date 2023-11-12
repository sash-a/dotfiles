return {
  -- Theme inspired by Atom
  -- 'navarasu/onedark.nvim',
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  config = function()
    vim.cmd.colorscheme 'gruvbox'
  end,
}
