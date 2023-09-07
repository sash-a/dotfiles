return {
  {
    "akinsho/toggleterm.nvim",
    -- tag = '*',
    config = function()
      require("toggleterm").setup({ auto_scroll = false })
    end
  }
}
