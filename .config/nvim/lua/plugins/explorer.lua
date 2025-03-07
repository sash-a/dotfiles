return {
  {
    "folke/snacks.nvim",
    keys = {
      { "<leader>e", false },
      { "<leader>E", false },
    },
  },
  {
    "echasnovski/mini.files",
    version = "*",
    keys = {
      { "<leader>e", ":lua MiniFiles.open()<cr>", desc = "File browser" },
    },
    opts = { mappings = { synchronize = "<CR>" } },
  },
}
