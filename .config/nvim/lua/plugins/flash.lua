return {
  "folke/flash.nvim",
  event = "VeryLazy",
  vscode = true,
  ---@type Flash.Config
  opts = {},
    -- stylua: ignore
    keys = {
      { "<leader>h", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
      { "s", mode = { "n", "x", "o" }, false },
      { "S", mode = { "n", "o", "x" }, false },
      { "r", mode = "o", false },
      { "R", mode = { "o", "x" }, false },
      { "<c-s>", mode = { "c" }, false },
    },
}
